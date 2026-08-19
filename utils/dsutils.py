# from imports import *

import numpy as np

import pandas as pd
from pandas.api.types import is_string_dtype, is_numeric_dtype, is_categorical_dtype

from matplotlib import pyplot as plt

import sklearn
# from sklearn_pandas import DataFrameMapper
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.impute._base import SimpleImputer as Imputer
from sklearn.tree import export_graphviz
from sklearn.ensemble import _forest as forest
import IPython
import graphviz
import warnings
import re
import math

from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor


def set_plt_rc(sml=15, med=18, big=20):
    plt.rc('font', size=sml)
    plt.rc('axes', titlesize=sml, labelsize=med, labelcolor='red')
    plt.rc('xtick', labelsize=sml, color='tomato')
    plt.rc('ytick', labelsize=sml, color='tomato')
    plt.rc('legend', fontsize=sml)
    plt.rc('figure', titlesize=big, figsize=(10, 6))


def set_plt_rc_2(sml=16, med=20, lrg=25):
    # plt.rcParams['lines.linewidth'] = sml
    plt.rcParams['font.size'] = med
    plt.rcParams['axes.labelsize'] = lrg
    plt.rcParams['axes.labelcolor'] = 'Blue'
    plt.rcParams['xtick.major.size'] = sml
    plt.rcParams['xtick.color'] = 'red'
    plt.rcParams['xtick.labelsize'] = med
    plt.rcParams['ytick.major.size'] = sml
    plt.rcParams['ytick.color'] = 'red'
    plt.rcParams['ytick.labelsize'] = med
    # plt.rcParams['lines.markersize'] = med


def parallel_trees(m, fn, n_jobs=8):
    return list(ProcessPoolExecutor(n_jobs).map(fn, m.estimators_))


def draw_tree(t, df, size=10, ratio=0.6, precision=0):
    """ Draws a representation of a random forest in IPython.

    Parameters:
    -----------
    t:  The tree you wish to draw
    df: The data used to train the tree. This is used to get the names of
        the features.
    """

    s = export_graphviz(t,
                        out_file=None,
                        feature_names=df.columns,
                        filled=True,
                        special_characters=True,
                        rotate=True,
                        precision=precision)

    IPython.display.display(
        graphviz.Source(
            re.sub('Tree {', f'Tree {{ size={size}; ratio={ratio}', s)))


def combine_date(years,
                 months=1,
                 days=1,
                 weeks=None,
                 hours=None,
                 minutes=None,
                 seconds=None,
                 milliseconds=None,
                 microseconds=None,
                 nanoseconds=None):
    years = np.asarray(years) - 1970
    months = np.asarray(months) - 1
    days = np.asarray(days) - 1
    types = ('<M8[Y]', '<m8[M]', '<m8[D]', '<m8[W]', '<m8[h]', '<m8[m]',
             '<m8[s]', '<m8[ms]', '<m8[us]', '<m8[ns]')
    vals = (years, months, days, weeks, hours, minutes, seconds, milliseconds,
            microseconds, nanoseconds)
    return sum(
        np.asarray(v, dtype=t) for t, v in zip(types, vals) if v is not None)


def get_sample(df, n):
    """ Gets a random sample of n rows from df, without replacement.

    Parameters:
    -----------
    df: A pandas data frame, that you wish to sample from.
    n:  The number of rows you wish to sample.

    Returns:
    --------
    return value: A random sample of n rows of df.

    Examples:
    ---------
    >>> df = pd.DataFrame({'col1' : [1, 2, 3], 'col2' : ['a', 'b', 'a']})
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    >>> get_sample(df, 2)
       col1 col2
    1     2    b
    2     3    a
    """
    idxs = sorted(np.random.permutation(len(df))[:n])
    return df.iloc[idxs].copy()


def add_datepart(df, fldnames, drop=True, time=False, errors="raise"):
    """add_datepart converts a column of df from a datetime64 to many columns containing
    the information from the date. This applies changes inplace.

    Parameters:
    -----------
    df:         A pandas data frame. df gain several new columns.
    fldname:    A string or list of strings that is the name of the date column
                you wish to expand. If it is not a datetime64 series, it will be
                converted to one with pd.to_datetime.
    drop:       If true then the original date column will be removed.
    time:       If true time features: Hour, Minute, Second will be added.

    Examples:
    ---------
    >>> df = pd.DataFrame({ 'A' : pd.to_datetime(['3/11/2000', '3/12/2000', '3/13/2000'], infer_datetime_format=False) })
    >>> df
        A
    0   2000-03-11
    1   2000-03-12
    2   2000-03-13
    >>> add_datepart(df, 'A')
    >>> df
        AYear AMonth AWeek ADay ADayofweek ADayofyear AIs_month_end AIs_month_start AIs_quarter_end AIs_quarter_start AIs_year_end AIs_year_start AElapsed
    0   2000  3      10    11   5          71         False         False           False           False             False        False          952732800
    1   2000  3      10    12   6          72         False         False           False           False             False        False          952819200
    2   2000  3      11    13   0          73         False         False           False           False             False        False          952905600
    >>>df2 = pd.DataFrame({'start_date' : pd.to_datetime(['3/11/2000','3/13/2000','3/15/2000']),
                            'end_date':pd.to_datetime(['3/17/2000','3/18/2000','4/1/2000'],infer_datetime_format=True)})
    >>>df2
        start_date	end_date
    0	2000-03-11	2000-03-17
    1	2000-03-13	2000-03-18
    2	2000-03-15	2000-04-01
    >>>add_datepart(df2,['start_date','end_date'])
    >>>df2
        start_Year	start_Month	start_Week	start_Day	start_Dayofweek	start_Dayofyear	start_Is_month_end	start_Is_month_start	start_Is_quarter_end	start_Is_quarter_start	start_Is_year_end	start_Is_year_start	start_Elapsed	end_Year	end_Month	end_Week	end_Day	end_Dayofweek	end_Dayofyear	end_Is_month_end	end_Is_month_start	end_Is_quarter_end	end_Is_quarter_start	end_Is_year_end	end_Is_year_start	end_Elapsed
    0	2000	    3	        10	        11	        5	            71	            False	            False	                False	                False	                False	            False	            952732800	    2000	    3	        11	        17	    4	            77	            False	            False	            False	            False	                False	        False	            953251200
    1	2000	    3	        11	        13	        0	            73	            False	            False	                False	                False               	False           	False           	952905600     	2000       	3	        11      	18  	5           	78          	False	            False           	False           	False               	False          	False           	953337600
    2	2000	    3	        11	        15	        2           	75          	False           	False               	False               	False               	False               False           	953078400      	2000    	4          	13      	1   	5           	92          	False           	True            	False           	True                	False          	False           	954547200
    """
    if isinstance(fldnames, str):
        fldnames = [fldnames]
    for fldname in fldnames:
        fld = df[fldname]
        fld_dtype = fld.dtype
        if isinstance(fld_dtype, pd.core.dtypes.dtypes.DatetimeTZDtype):
            fld_dtype = np.datetime64

        if not np.issubdtype(fld_dtype, np.datetime64):
            df[fldname] = fld = pd.to_datetime(fld,
                                               infer_datetime_format=True,
                                               errors=errors)
        targ_pre = re.sub('[Dd]ate$', '', fldname)
        attr = [
            'Year', 'Month', 'Week', 'Day', 'Dayofweek', 'Dayofyear',
            'Is_month_end', 'Is_month_start', 'Is_quarter_end',
            'Is_quarter_start', 'Is_year_end', 'Is_year_start'
        ]
        if time:
            attr = attr + ['Hour', 'Minute', 'Second']
        for n in attr:
            df[targ_pre + n] = getattr(fld.dt, n.lower())
        df[targ_pre + 'Elapsed'] = fld.astype(np.int64) // 10**9
        if drop:
            df.drop(fldname, axis=1, inplace=True)


def is_date(x):
    return np.issubdtype(x.dtype, np.datetime64)


def cont_cat_split(df, max_card=20, dep_var=None):
    "Helper function that returns column names of continious and catagorical variables from given `df`."
    cont_names, cat_names = [], []
    for label in df:
        if label in L(dep_var):
            continue
        if ((pd.api.types.is_integer_dtype(df[label].dtype)
             and df[label].unique().shape[0] > max_card)
                or pd.api.types.is_float_dtype(df[label].dtype)):
            cont_names.append(label)
        else:
            cat_names.append(label)
    return cont_names, cat_names


def train_cats(df: pd.DataFrame):
    """
    Change any columns of strings in a panda's dataframe to a column of
    categorical values. This applies the changes inplace.

    Parameters:
    -----------
    df: A pandas dataframe whose columns of strings will be changed to categorical values.

    Examples:
    ---------
    >>> df = pd.DataFrame({'col1' : [1, 2, 3], 'col2' : ['a', 'b', 'a']})
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    note the type of col2 is string
    >>> train_cats(df)
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    now the type of col2 is category
    """
    for n, c in df.items():
        if is_string_dtype(c):
            df[n] = c.astype('category').cat.as_ordered()


def apply_cats(df: pd.DataFrame, trn: pd.DataFrame):
    """
    Changes any columns of strings in df into categorical variables using trn as
    a template for the category codes.

    Parameters:
    -----------
    df : A DataFrame whose columns of strings will be changed to categorical
         values where the category codes are determined by trn.

    trn: A pandas dataframe. When creating a category for df, it looks up the
        what the category's code were in trn and makes those the category codes
        for df.

    Examples:
    ---------
    >>> df = pd.DataFrame({'col1' : [1, 2, 3], 'col2' : ['a', 'b', 'a']})
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    note the type of col2 is string
    >>> train_cats(df)
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    now the type of col2 is category {a : 1, b : 2}
    >>> df2 = pd.DataFrame({'col1' : [1, 2, 3], 'col2' : ['b', 'a', 'a']})
    >>> apply_cats(df2, df)
           col1 col2
        0     1    b
        1     2    a
        2     3    a
    now the type of col is category {a : 1, b : 2}
    """

    for n, c in df.items():
        if (n in trn.columns) and (trn[n].dtype.name == 'category'):
            df[n] = c.astype('category').cat.as_ordered()
            df[n].cat.set_categories(trn[n].cat.categories,
                                     ordered=True,
                                     inplace=True)


def fix_missing(df: pd.DataFrame, col: pd.Series, name: str, na_dict: dict):
    """
    Fill missing data in a numeric column of df, and add a {name}_na column which
    specifies if the data was missing.

    Parameters:
    -----------
    df     : The data frame that will be changed.
    col    : The column of df to fix by filling in missing data.
    name   : The name of the newly created filled column in df.
    na_dict: A dictionary of keys to create na's of and the value to fill
             missing data by. If name is not a key of na_dict the median will
             fill any missing data. Also if name is not a key of na_dict and
             there is no missing data in col, then no {name}_na column is not created.

    Examples:
    ---------
    >>> df = pd.DataFrame({'col1' : [1, np.NaN, 3], 'col2' : [5, 2, 2]})
    >>> df
       col1 col2
    0     1    5
    1   nan    2
    2     3    2
    >>> fix_missing(df, df['col1'], 'col1', {})
    >>> df
       col1 col2 col1_na
    0     1    5   False
    1     2    2    True
    2     3    2   False
    >>> df = pd.DataFrame({'col1' : [1, np.NaN, 3], 'col2' : [5, 2, 2]})
    >>> df
       col1 col2
    0     1    5
    1   nan    2
    2     3    2
    >>> fix_missing(df, df['col2'], 'col2', {})
    >>> df
       col1 col2
    0     1    5
    1   nan    2
    2     3    2
    >>> df = pd.DataFrame({'col1' : [1, np.NaN, 3], 'col2' : [5, 2, 2]})
    >>> df
       col1 col2
    0     1    5
    1   nan    2
    2     3    2
    >>> fix_missing(df, df['col1'], 'col1', {'col1' : 500})
    >>> df
       col1 col2 col1_na
    0     1    5   False
    1   500    2    True
    2     3    2   False
    """
    if is_numeric_dtype(col):
        if pd.isnull(col).sum() or (name in na_dict):
            df[name + '_na'] = pd.isnull(col)
            filler = na_dict[name] if name in na_dict else col.median()
            df[name] = col.fillna(filler)
            na_dict[name] = filler

    return na_dict


def numericalize(df: pd.DataFrame, col: pd.Series, name: str, max_n_cat: int):
    """
    Changes the categorical column `col` from a categorical type to it's integer codes.

    Parameters:
    -----------
    df       : df[name] will be filled with the integer codes from col.
    col      : The column you wish to change into the categories.
    name     : Column name you wish to insert into df holding the integer codes.
    max_n_cat: Number of catagories greater than to which of col will be converted into code.

    Examples:
    ---------
    >>> df = pd.DataFrame({'col1' : [1, 2, 3], 'col2' : ['a', 'b', 'a']})
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    note the type of col2 is string
    >>> train_cats(df)
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    now the type of col2 is category { a : 1, b : 2}
    >>> numericalize(df, df['col2'], 'col3', None)
       col1 col2 col3
    0     1    a    1
    1     2    b    2
    2     3    a    1
    """
    cond1 = not is_numeric_dtype(col)
    cond2 = cond1 and (max_n_cat is None or len(
        col.cat.categories) > max_n_cat)
    if cond1 and cond2:
        df[name] = pd.Categorical(col).codes + 1


def scale_vars(df, mapper):
    warnings.filterwarnings('ignore',
                            category=sklearn.exceptions.DataConversionWarning)
    if mapper is None:
        map_f = [([col_name], StandardScaler()) for col_name in df.columns
                 if is_numeric_dtype(df[col_name])]
        mapper = DataFrameMapper(map_f).fit(df)

    df[mapper.transformed_names_] = mapper.transform(df)
    return mapper


def proc_df(df,
            y_fld=None,
            skip_flds=None,
            ignore_flds=None,
            do_scale=False,
            na_dict=None,
            preproc_fn=None,
            max_n_cat=None,
            subset=None,
            mapper=None):
    """
    Proc_df takes a data frame `df` and splits off the response variable, and
    changes the `df` into an entirely numeric dataframe. For each column of `df`
    which is not in `skip_flds` nor in `ignore_flds`, na values are replaced by the
    median value of the column.

    Parameters:
    -----------
    df         : The data frame you wish to process.
    y_fld      : The name of the response variable
    skip_flds  : A list of fields that dropped from df.
    ignore_flds: A list of fields that are ignored during processing.
    do_scale   : Standardizes each column in df. Takes Boolean Values(True, False)
    na_dict    : a dictionary of `na` columns to add. Na columns are also added
                 if there are any missing values.
    preproc_fn : A function that gets applied to df.
    max_n_cat  : The maximum number of categories to break into dummy values,
                 instead of integer codes.
    subset     : Takes a random subset of size subset from df.
    mapper     : If do_scale is set as True, the mapper variable calculates the
                 values used for scaling of variables during training time
                 (mean and standard deviation).

    Returns:
    --------
    [x, y, nas, mapper(optional)]:
        x:      x is entirely numeric version of `df` without the response variable.
        y:      y is the response variable
        nas:    returns a dictionary of which `nas` it created, and the associated median.
        mapper: A DataFrameMapper which stores the mean and standard deviation
                of the corresponding continuous variables which is then used
                for scaling of during test-time.
    Examples:
    ---------
    >>> df = pd.DataFrame({'col1' : [1, 2, 3], 'col2' : ['a', 'b', 'a']})
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    note the type of col2 is string
    >>> train_cats(df)
    >>> df
       col1 col2
    0     1    a
    1     2    b
    2     3    a
    now the type of col2 is category { a : 1, b : 2}
    >>> x, y, nas = proc_df(df, 'col1')
    >>> x
       col2
    0     1
    1     2
    2     1
    >>> data = DataFrame(pet=["cat", "dog", "dog", "fish", "cat", "dog", "cat", "fish"],
                 children=[4., 6, 3, 3, 2, 3, 5, 4],
                 salary=[90, 24, 44, 27, 32, 59, 36, 27])
    >>> mapper = DataFrameMapper([(:pet, LabelBinarizer()),
                          ([:children], StandardScaler())])
    >>> round(fit_transform!(mapper, copy(data)), 2)
    8x4 Array{Float64,2}:
    1.0  0.0  0.0   0.21
    0.0  1.0  0.0   1.88
    0.0  1.0  0.0  -0.63
    0.0  0.0  1.0  -0.63
    1.0  0.0  0.0  -1.46
    0.0  1.0  0.0  -0.63
    1.0  0.0  0.0   1.04
    0.0  0.0  1.0   0.21
    """
    if not ignore_flds:
        ignore_flds = []
    if not skip_flds:
        skip_flds = []

    if subset:
        df = get_sample(df, subset)
    else:
        df = df.copy()

    # asides the ignored fields to preppend with df before returns.
    ignored_flds = df.loc[:, ignore_flds]
    df.drop(ignore_flds, axis=1, inplace=True)

    if preproc_fn:
        preproc_fn(df)

    # process and extract off y field
    if y_fld is None:
        y = None
    else:
        if not is_numeric_dtype(df[y_fld]):
            df[y_fld] = pd.Categorical(df[y_fld]).codes
        y = df[y_fld].values
        skip_flds += [y_fld]

    # permenantly remove skiped fields
    df.drop(skip_flds, axis=1, inplace=True)

    if na_dict is None:
        na_dict = {}
    else:
        na_dict = na_dict.copy()

    na_dict_initial = na_dict.copy()

    # fix missing data
    for n, c in df.items():
        na_dict = fix_missing(df, c, n, na_dict)

    # trim df
    if len(na_dict_initial.keys()) > 0:
        df.drop([
            a + '_na'
            for a in list(set(na_dict.keys()) - set(na_dict_initial.keys()))
        ],
            axis=1,
            inplace=True)

    # transform if necessary
    if do_scale:
        mapper = scale_vars(df, mapper)

    # Convert categorical data to its code
    for n, c in df.items():
        numericalize(df, c, n, max_n_cat)

    # Convert categorical data to its dummy variable
    df = pd.get_dummies(df, dummy_na=True)
    df = pd.concat([ignored_flds, df], axis=1)
    res = [df, y, na_dict]

    if do_scale:
        res = res + [mapper]

    return res


def rf_feat_importance(m, df):
    return pd.DataFrame({
        'cols': df.columns,
        'imp': m.feature_importances_
    }).sort_values('imp', ascending=False)


def get_nn_mappers(df, cat_vars, contin_vars):
    # Replace nulls with 0 for continuous, "" for categorical.
    for v in contin_vars:
        df[v] = df[v].fillna(df[v].max() + 100, )
    for v in cat_vars:
        df[v].fillna('#NA#', inplace=True)

    # list of tuples, containing variable and instance of a transformer for that variable
    # for categoricals, use LabelEncoder to map to integers. For continuous, standardize
    cat_maps = [(o, LabelEncoder()) for o in cat_vars]
    contin_maps = [([o], StandardScaler()) for o in contin_vars]



class display(object):
    """Display HTML representation of multiple objects"""
    
    template = """<div style="float: left; padding: 10px;">
    <p style='font-family:"Courier New", Courier, monospace'>{0}</p>{1}
    </div>"""
    
    def __init__(self, *args):
        self.args = args
        
    def _repr_html_(self):
        return '\n'.join(
            self.template.format(a, eval(a)._repr_html_()) for a in self.args
        )
    
    def __repr__(self):
        return '\n\n'.join(a + '\n' + repr(eval(a)) for a in self.args)

def dirpy(obj):
    """
    Display the name of the public members and attributes of an `obj`.
    """
    return list(filter(lambda x: not (x.startswith("__") or x.startswith("_")), dir(obj)))