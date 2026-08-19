
import tqdm as tq
from tqdm import tqdm_notebook, tnrange
from ipykernel.kernelapp import IPKernelApp
from IPython.lib.deepreload import reload as dreload
import PIL
import os
import numpy as np
import math
import collections
import threading
import json
import random
import scipy
import pandas as pd
import pickle
import sys
import itertools
import string
import sys
import re
import datetime
import time
import shutil
import copy
import seaborn as sns
import matplotlib
import IPython
import graphviz
# import sklearn_pandas
import sklearn
import warnings
import pdb
import contextlib
from abc import abstractmethod
from glob import glob, iglob
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor
from itertools import chain
from functools import partial
from collections.abc import Iterable
from collections import Counter, OrderedDict
from isoweek import Week
from pandas_summary import DataFrameSummary
from IPython.lib.display import FileLink
from PIL import Image, ImageEnhance, ImageOps
from sklearn import metrics, ensemble, preprocessing
from operator import itemgetter, attrgetter
from pathlib import Path
from distutils.version import LooseVersion

from matplotlib import pyplot as plt, rcParams, animation
from ipywidgets import interact, interactive, fixed, widgets
matplotlib.rc('animation', html='html5')
np.set_printoptions(precision=5, linewidth=110, suppress=True)


def in_notebook(): return IPKernelApp.initialized()


def in_ipynb():
    try:
        cls = get_ipython().__class__.__name__
        return cls == 'ZMQInteractiveShell'
    except NameError:
        return False


def clear_tqdm():
    inst = getattr(tq.tqdm, '_instances', None)
    if not inst:
        return
    try:
        for i in range(len(inst)):
            inst.pop().close()
    except Exception:
        pass


if in_notebook():
    def tqdm(*args, **kwargs):
        clear_tqdm()
        return tq.tqdm(*args, file=sys.stdout, **kwargs)

    def trange(*args, **kwargs):
        clear_tqdm()
        return tq.trange(*args, file=sys.stdout, **kwargs)
else:
    from tqdm import tqdm, trange
    tnrange = trange
    tqdm_notebook = tqdm
