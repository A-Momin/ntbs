<h1 style="text-align:center"> Theories of Statistics </h1>

-   [Statistics - A Full University Course on Data Science Basics](https://www.youtube.com/watch?v=xxpc-HPKN28&t=28119s)
-   []()

---

<details><summary style="font-size:20px;color:Orange;text-align:left">Terms and Concepts</summary>

#### Terminology

-   <font color='tomato'>Population:</font> the entire group of interest
-   <font color='tomato'>Sample:</font> subset of the population
-   <font color='tomato'>Bootstrap:</font> Sampling with replacement
-   <font color='tomato'>Parameter:</font> a number that describes the population, typically unknown
-   <font color='tomato'>Statistic:</font> a number that is computed from a sample
-   <font color='tomato'>Sampling variability:</font> the statistics of different samples of a population will differ somewhat
-   Sample skewness + fundamental randomness
-   <font color='tomato'>Sampling distribution</font> is the distribution of a statistic across an infinite number of samples
-   <center><img src="/assets/statistics/inf_notation.png" width=300 align="middle"></center>

#### Law of Large Number

The law of large numbers (LLN) is a theorem that describes the result of performing the same experiment a large number of times. According to the law, the average of the results obtained from a large number of trials should be close to the expected value and will tend to become closer to the expected value as more trials are performed

#### Regression to the Mean:

-   Following an extreme random event, the next random event is likely to be less extreme
-   If you spin a fair roulette wheel 10 times and get 100% reds, that is an extreme event (probability = 1/1024)
-   It is likely that in the next 10 spins, you will get fewer than 10 reds
    -   But the expected number is only 5
-   So, if you look at the average of the 20 spins, it will be
    closer to the expected mean of 50% reds than to the 100% of the first 10 spins

#### Confidence Levels and Intervals :

-   Instead of estimating an unknown parameter by a single value (e.g., the mean of a set of trials), a confidence interval provides a range that is likely to contain the unknown value and a confidence that the unknown value lays within that range.

#### Empirical Rule:

-   Under the assumptions below
    -   ~68% of data within one standard deviation of mean
    -   ~95% of data within 1.96 standard deviations of mean
    -   ~99.7% of data within 3 standard deviations of mean
-   Assumption Underlying Empirical Rule

    -   The Mean estimation error is zero
    -   The distribution of the error in estimation is Normal (Gaussian)

-   **Verify the Empirical Rule**

```python
def verify_empirical(numTrials) -> None:
    for t in range(numTrials):
        mu = random.randint(-10, 10)
        sigma = random.randint(1, 10)
        print('For mu =', mu, 'and sigma =', sigma, ':')
        for numStd in (1, 1.96, 3):
            area = scipy.integrate.quad(gaussian, mu-numStd*sigma, mu+numStd*sigma, (mu, sigma))[0]
            print('\tFraction within', numStd, 'std =', round(area, 4))

verify_empirical(3)

```

    For mu = -7 and sigma = 4 :
    	Fraction within 1 std = 0.6827
    	Fraction within 1.96 std = 0.95
    	Fraction within 3 std = 0.9973
    For mu = -6 and sigma = 5 :
    	Fraction within 1 std = 0.6827
    	Fraction within 1.96 std = 0.95
    	Fraction within 3 std = 0.9973
    For mu = -6 and sigma = 6 :
    	Fraction within 1 std = 0.6827
    	Fraction within 1.96 std = 0.95
    	Fraction within 3 std = 0.9973

#### Stratified Sampling :

-   When there are small subgroups that should be represented
-   When it is important that subgroups be represented proportionally to their size in the population
-   Can be used to reduced the needed size of sample
    -   Variability of subgroups less than of entire population
-   Requires care to do properly

#### Central Limit Therom (Given suficiently large sample):

As long as adequately large samples and adequately large number of samples are used from a population, the distribution of the sample mean will be normally distributed.

-   The Central Limit Theorem actually applies for these well known statistics:

    -   Sample means ($\bar{x}$)
    -   Sample proportions ($\mathscr{p}$)
    -   Difference in sample means ($\bar{x}_1 - \bar{x}_2$)
    -   Difference in sample proportions ($\mathscr{p}_1 - \mathscr{p}_2$)

-   And it applies for additional statistics, but it doesn't apply for all statistics!

1. Means of the samples in a set of samples (the sample means) will be approximately normally distributated. In other word, the distribution of the sample means will be normally distributed.
2. This Normal Distribution will have a mean close to the mean of the population.
3. The variance of the sample means will be close to the variance of the population divided by the sample size.

#### [Covariance](https://en.wikipedia.org/wiki/Covariance):

-   `Definition`: `Covariance` is a statistical concept that measures the degree to which two variables change together. It indicates whether an increase in one variable is associated with an increase or decrease in another variable. In the context of data analysis, covariance helps us understand the relationship between two sets of data points and whether they tend to move in the same direction or in opposite directions.

-   `Range`: Covariance can take any real value, positive or negative.
-   `Scale Dependence`: Covariance is not standardized and can be affected by the scales of the variables. It doesn't provide a clear sense of the strength or direction of the relationship.
-   `Interpretation`: Covariance alone doesn't offer an intuitive interpretation of the strength of the relationship. It's affected by the units of the variables, making comparisons between different datasets challenging.

-   `Coveriance of X & Y`:

    -   $cov(X, Y) = E[(X - E[X]) \cdot (Y - E[Y])] = E[X Y] - E[X] \cdot E[Y] = E[X \cdot Y] - \mu_X \cdot \mu_Y$
        -   X is a Random Variable (a feature vector; $X \in R^m$)
        -   Y is also a Random Variable (another feature vector; $Y \in R^m$)
        -   $X \cdot Y \ne X^{T} Y $; it's elementwise multiplication
        -   $cov(X, Y) \in [- \sigma_X \sigma_Y, \sigma_X \sigma_Y]$

-   `Covariance Matrix` [wiki page](https://en.wikipedia.org/wiki/Covariance_matrix):
    -   **X is a Matrix** (a group of Random Variables; $X \in R^{m x n}$)
        -   Each column of **X** is a feature vector.

$\operatorname{K}_{\mathbf{X}\mathbf{X}} 
= \begin{bmatrix}
\mathrm{E}[(X_1 - \operatorname{E}[X_1])(X_1 - \operatorname{E}[X_1])] & \mathrm{E}[(X_1 - \operatorname{E}[X_1])(X_2 - \operatorname{E}[X_2])] & \cdots & \mathrm{E}[(X_1 - \operatorname{E}[X_1])(X_n - \operatorname{E}[X_n])] \\ \\
 \mathrm{E}[(X_2 - \operatorname{E}[X_2])(X_1 - \operatorname{E}[X_1])] & \mathrm{E}[(X_2 - \operatorname{E}[X_2])(X_2 - \operatorname{E}[X_2])] & \cdots & \mathrm{E}[(X_2 - \operatorname{E}[X_2])(X_n - \operatorname{E}[X_n])] \\ \\
 \vdots & \vdots & \ddots & \vdots \\ \\
 \mathrm{E}[(X_n - \operatorname{E}[X_n])(X_1 - \operatorname{E}[X_1])] & \mathrm{E}[(X_n - \operatorname{E}[X_n])(X_2 - \operatorname{E}[X_2])] & \cdots & \mathrm{E}[(X_n - \operatorname{E}[X_n])(X_n - \operatorname{E}[X_n])]
\end{bmatrix}$

-   $
\operatorname{K}_{\mathbf{X}\mathbf{X}} 
    = \operatorname{cov}[\mathbf{X},\mathbf{X}] 
    = \operatorname{E}[(\mathbf{X}-\mathbf{\mu_X})(\mathbf{X}-\mathbf{\mu_X})^{\rm T}]
    = \operatorname{E}[\mathbf{X} \mathbf{X}^T] - \mathbf{\mu_X} \mathbf{\mu_X}^T
$

-   $
\operatorname{E}[\mathbf{X} \mathbf{X}^T] 
    = \frac{1}{m} \cdot \sum\limits_{i=1}^m \mathbf{x}^i  {\mathbf{x}^i}^T
    \ne \frac{1}{m} \cdot \left[ \mathbf{X} \mathbf{X}^T \right] \quad where, \quad
    \begin{cases}
        \mathbf{X} \in R^{m x n} \\
        \mathbf{x} \in R^n \\
        \mathbf{x}^i  {\mathbf{x}^i}^T \in R^{n x n} \\
        m = n
    \end{cases}
$

-   Python Implementation:

    -   $\operatorname{K}_{\mathbf{X}\mathbf{X}} = \frac{1}{m} \cdot (\mathbf{X}-\mathbf{\mu_X})^{\rm T}(\mathbf{X}-\mathbf{\mu_X})$
        -   $\mathbf{X} \in R^{m x n}$
        -   $(\mathbf{X}-\mathbf{\mu_X})^{\rm T} \in R^{n x m}$
        -   $\mu_X \in R^n$

-   $\operatorname{K}_{\mathbf{X}\mathbf{X}}$ is a **Symetric Matrix**; $\operatorname{K}_{\mathbf{X}\mathbf{X}} \in R^{n x n}$
-   $\operatorname{K}_{\mathbf{X}\mathbf{X}}$ is a **Positive Semi-definite Matrix**
-   The matrix $\operatorname{K}_{\mathbf{X}\mathbf{X}}$ is also often called the **variance-covariance matrix**, since the diagonal terms are in fact variances of $n^{th}$ feature.

```python

```

#### Correlation:

-   `Definition`: Correlation is a statistical measure that quantifies the strength and direction of the linear relationship between two variables. It helps us understand how changes in one variable are associated with changes in another variable.
-   `Range`: Correlation values range from `-1` to `1`.
    -   A correlation of `-1` indicates a perfect negative linear relationship, meaning as one variable increases, the other decreases linearly.
    -   A correlation of `1` indicates a perfect positive linear relationship, meaning as one variable increases, the other also increases linearly.
    -   A correlation of `0` indicates no linear relationship between the variables.
-   `Interpretation`:
    -   `Positive Correlation`: A positive correlation indicates that as one variable increases, the other tends to increase as well. The closer the correlation is to 1, the stronger the positive linear relationship.
    -   `Negative Correlation`: A negative correlation indicates that as one variable increases, the other tends to decrease. The closer the correlation is to -1, the stronger the negative linear relationship.
    -   `Zero Correlation`: A correlation close to 0 indicates no linear relationship between the variables.
-   `Correlation Coefficient`: The correlation coefficient, denoted by `r`, is the numerical value that represents the correlation between two variables. It provides a quantitative measure of the strength and direction of the relationship.

##### [Pearson Correlation](https://en.wikipedia.org/wiki/Pearson_correlation_coefficient)

**Pearson's Correlation Coefficient:**

-   Standarized version of $cov(X,Y)$ ( Standarization is obtained dividing $cov(X,Y)$ by $\sigma_X \sigma_Y$)
-   X is a column (a Random Variable)
-   Y is also a column (another Random Variable)

-   For Population:

$$
\begin{split}
    \Large\rho_{X,Y}
    &= \frac{\operatorname{cov}(X,Y)}{\sigma_X \sigma_Y} \\
    &= \frac{\mathbb{E}[(X-\mu_X)(Y-\mu_Y)]} {\sigma_X\sigma_Y} \\
    &= \frac{\mathbb{E}[(X-\mathbb{E}[X]) \cdot (Y-\mathbb{E}[Y])]}{\sqrt{\mathbb{E}[\,X^2\,]-\left(\mathbb{E}[\,X\,] \right)^2} ~ \sqrt{\mathbb{E}[\,Y^2\,]- \left(\mathbb{E}[\,Y\,] \right)^2}} \\
    &= \frac{\mathbb{E}[\,X\,Y\,]-\mathbb{E}[\,X\,]\mathbb{E}[\,Y\,]}{\sqrt{\mathbb{E}[\,X^2\,]-\left(\mathbb{E}[\,X\,] \right)^2} ~ \sqrt{\mathbb{E}[\,Y^2\,]- \left(\mathbb{E}[\,Y\,] \right)^2}}
\end{split}
$$

-   For Sample:

$$
\begin{split}
    \Large r_{xy}
    &=\frac{\sum ^n _{i=1}(x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum ^n _{i=1}(x_i - \bar{x})^2} \sqrt{\sum ^n _{i=1}(y_i - \bar{y})^2}} \\
    &= \frac{n\sum x_i y_i - \sum x_i\sum y_i}{\sqrt{n\sum x_i^2-\left(\sum x_i\right)^2}~\sqrt{n\sum y_i^2-\left(\sum y_i\right)^2}} \\
    &= \frac{\sum x_i y_i-n\bar{x}\bar{y}}{\sqrt{\sum x_i^2-n\bar{x}^2}~\sqrt{\sum y_i^2-n\bar{y}^2}}
\end{split}
$$

**Pearson's Correlation Matrix:**

-   X is a Matrix (a group of Random Variables)
-   $corr(X) \in [- 1, 1]$

$\Large \operatorname{corr}(\mathbf{X})
= \begin{bmatrix}
 1 & \frac{\operatorname{E}[(X_1 - \mu_1)(X_2 - \mu_2)]}{\sigma(X_1)\sigma(X_2)} & \cdots & \frac{\operatorname{E}[(X_1 - \mu_1)(X_n - \mu_n)]}{\sigma(X_1)\sigma(X_n)} \\ \\
 \frac{\operatorname{E}[(X_2 - \mu_2)(X_1 - \mu_1)]}{\sigma(X_2)\sigma(X_1)} & 1 & \cdots & \frac{\operatorname{E}[(X_2 - \mu_2)(X_n - \mu_n)]}{\sigma(X_2)\sigma(X_n)} \\ \\
 \vdots & \vdots & \ddots & \vdots \\ \\
 \frac{\operatorname{E}[(X_n - \mu_n)(X_1 - \mu_1)]}{\sigma(X_n)\sigma(X_1)} & \frac{\operatorname{E}[(X_n - \mu_n)(X_2 - \mu_2)]}{\sigma(X_n)\sigma(X_2)} & \cdots & 1
\end{bmatrix}$

-   The correlation matrix can be seen as the covariance matrix of the **standardized variable** $\frac{X_i}{\sigma(X_i)}$ for $i = 1, \dots, n$

-   Each element on the principal diagonal of a correlation matrix is the correlation of a random variable with itself, which always equals 1. Each off-diagonal element is between −1 and +1 inclusive.

##### [Spearsman Correlation](https://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient):

-   The Spearman correlation coefficient is defined as the **Pearson correlation coefficient** between the rank variables.

-   For a sample of size `n`, the `n` raw scores $X_i, Y_i$ are converted to ranks $\operatorname{R}({X_i}), \operatorname{R}({Y_i})$, and $r_s$ is computed as

-   $$
    \Large r_s =
     \rho_{\operatorname{R}(X),\operatorname{R}(Y)} =
     \frac{\operatorname{cov}(\operatorname{R}(X), \operatorname{R}(Y))}
          {\sigma_{\operatorname{R}(X)} \sigma_{\operatorname{R}(Y)}}
    $$

    > where,
    >
    > -   $\rho$ denotes the usual Pearson correlation coefficient, but applied to the rank variables
    > -   $\operatorname{cov}(\operatorname{R}(X), \operatorname{R}(Y))$ is the covariance of the rank variables
    > -   $\sigma_{\operatorname{R}(X)}$ and $\sigma_{\operatorname{R}(Y)}$ are the standard deviations of the rank variables.
    > -   Only if all `n` ranks are **distinct integers**, it can be computed using the popular formula

-   $$\Large r_s = 1 - \frac{6 \sum d_i^2}{n(n^2 - 1)}$$

    > where,
    >
    > -   $d_i = \operatorname{R}(X_i) - \operatorname{R}(Y_i)$ is the difference between the two ranks of each observation,
    > -   `n` is the number of observations.

-   [Example](https://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient#Example)

#### Common methods to estimate parameters from observations

-   [Maximum Likelihood Estimation](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation)
-   [Method of Moments Estimation](<https://en.wikipedia.org/wiki/Method_of_moments_(statistics)>)
-   [Bayesian Estimation](https://en.wikipedia.org/wiki/Bayes_estimator)

</details>

---

### Bootstrapping

Bootstrapping is sampling with replacement. No more data needed to gain a better understanding of the parameter.

#### Confidence interval

-   Interpretation

    We are 95% confident that the [population mean] falls between [the bounds that you find].

-   Code

    ```python
    boot_means = []
    for _ in range(10000):
        boot_sample = coffee_red.sample(200, replace=True)
        boot_means.append(boot_sample.loc[boot_sample['drinks_coffee']==True, 'height'].mean())

    np.percentile(boot_means, 2.5), np.percentile(boot_means, 97.5) # 68.06, 68.97
    ```

    We are 95% confident that the mean height of all coffee drinkers is between 68.06 and 68.97.

#### Standard error of the mean - a measure of confidence

-   SE = $σ/√n$
-   s: standard deviation of sample
-   n: sample size

    ```python
    from scipy.stats import sem
    plt.errorbar(x_axis, means, yerr = standard_errors, fmt='o')
    ```

    comparing error bars could infer whether samples were drawn from the same population

#### Hypothesis testing

**Hypothesis testing:** Assessing evidence provided by the data in favor of or against each hypothesis about the population. To learn more about the traditional methods, see the documentation here on the [Stat Trek site](https://stattrek.com/hypothesis-test/hypothesis-testing.aspx) on the corresponding hypothesis tests.

1. Specify the null ($H_0$) and alternative ($H_a$) hypothesis
2. Choose a sample
3. Assess the evidence
    - A result is **statistically significant** if it is unlikely to have occurred by chance.
    - Significance level of a test: $\alpha=0.05$
    - **p-value** is also called **type one error rate** = the probability we would be wrong in rejecting null hypothesis
    - Probability value **p-value < 0.05**: more than 95% likely that the association of interest would be present following repeated samples drawn from the population (aka., sampling distribution). <br>
          <center><img src="/assets/statistics/bivariate_stat_tools.png" width=400></center>
4. Draw conclusions
    - If p-value < $\alpha$: the data provide significant evidence against the null hypothesis, so we reject the null hypothesis and accept the alternative hypothesis.
    - If p-value > $\alpha$: the data do not provide enough evidence to reject the null hypothesis; the data do not provide enough evidence to accept the alternative hypothesis.

#### Statistical vs. practical significance

-   Using confidence intervals and hypothesis testing, you are able to provide **statistical significance** in making decisions.

-   However, it is also important to take into consideration **practical significance** in making decisions. Practical significance takes into consideration other factors of your situation that might not be considered directly in the results of your hypothesis test or confidence interval. Constraints like **space, time, or money** are important in business decisions. However, they might not be accounted for directly in a statistical test.

---

### Bivariate statistical tools

#### Analysis of Variance (ANOVA)

Examine differences in the mean response variable for each category of our explanatory variable. E.g. Are any of the treatments significantly different than the rest?

-   Hypothesis

    $H_0$: $\mu_1=\mu_2=\mu_3=\mu_4$ <br>
    $H_a$: not all the $\mu$ are equal

-   ANOVA F test

    Are the differences among the sample means due to true differences among the population means or merely due to sampling variability?

    **F statistic:** $F=\frac{variation\ among\ sample\ means}{variation\ within\ groups}$

-   Code

    -   Explanatory variable with 2 levels

        ```python
        import statsmodels.formula.api as smf

        # using ols function for calculating the F-statistic and associated p value
        # C(...) indicates categorical variable
        # dataset has no missing values
        model1 = smf.ols(formula='NUMCIGMO_EST ~ C(MAJORDEPLIFE)', data=sub1)
        results1 = model1.fit()
        print (results1.summary())
        ```

        Alternative syntax

        ```python
        import scipy.stats as stats

        # Perform the ANOVA
        stats.f_oneway(group1, group2, group3, group4, group5)
        ```

    -   Explanatory variable with >2 levels

        ```python
        model2 = smf.ols(formula='NUMCIGMO_EST ~ C(ETHRACE2A)', data=sub3).fit()
        print (model2.summary())
        ```

        A significant ANOVA does not tell which groups are different from the others

    -   Post hoc test when explanatory variable has >2 levels

        Cannot compare each pair one-by-one due to the increase in the Type 1 error rate called the family-wise error rate, the error rate for the group of pair comparison.

          <center><img src="/assets/statistics/family_wise_error.png" width=400></center>

        Use one of the post hoc tests that are designed to evaluate the difference between pairs of means while protecting against inflation of Type 1 errors:

        -   Sidak
        -   Holm T test
        -   Fisher's Least Significant Difference Test
        -   Tukey's Honestly Significant Difference Test
        -   Scheffe test
        -   Newman-Keuls test
        -   Dunnett's Multiple Comparison Test
        -   Duncan Multiple Range Test
        -   Bonferroni Procedure

        ```python
        import statsmodels.stats.multicomp as multi
        mc1 = multi.MultiComparison(sub3['NUMCIGMO_EST'], sub3['ETHRACE2A'])
        res1 = mc1.tukeyhsd()
        print(res1.summary())
        ```

-   Example application

    [Blog post](https://www.tumblr.com/blog/rfbds)

#### Chi-Square test of independence

Which of the 2 categorical variables plays the role of the explanatory variable and then calculating the conditional percentages separately.

Whether there is a significant difference between the expected frequencies and the observed frequencies in one or more categories.

-   Hypothesis

    $H_0$:

    -   There is no difference in the drunk driving rate between males and females.
    -   There is no relationship between the 2 categorical variables - they are independent.
    -   Proportion of male drunk drivers = proportion of female drunk drivers.

    $H_a$:

    -   There is a difference in the drunk driving rate between males and females.
    -   There is a relationship between the 2 categorical variables - they are not independent.
    -   Proportion of male drunk drivers ≠ proportion of female drunk drivers.

-   $\chi^2$ test of independence

      <center><img src="/assets/statistics/chi_suqare.png" width=400></center>
      <center><img src="/assets/statistics/chi_suqare_table.png" width=600></center>
      <center><img src="/assets/statistics/chi_suqare_txt.png" width=400></center>

    The p-value of the $\chi^2$ test of independence is the probability of getting counts like those observed, assuming that the 2 variables are not related.

-   Code

    -   Chi Square test of independence

        Test

        ```python
        import scipy.stats
        import seaborn
        import matplotlib.pyplot as plt

        # contingency table of observed counts
        ct1=pandas.crosstab(sub2['TAB12MDX'], sub2['USFREQMO']) # response, explanatory
        print (ct1)

        # column percentages
        colsum=ct1.sum(axis=0)
        colpct=ct1/colsum
        print(colpct)

        # chi-square
        print ('chi-square value, p value, expected counts')
        cs1= scipy.stats.chi2_contingency(ct1)
        print (cs1)
        ```

        Visualize

        ```python
        # set variable types
        sub2["USFREQMO"] = sub2["USFREQMO"].astype('category')

        # new code for setting variables to numeric:
        sub2['TAB12MDX'] = pandas.to_numeric(sub2['TAB12MDX'], errors='coerce')

        # graph percent with nicotine dependence within each smoking frequency group
        seaborn.factorplot(x="USFREQMO", y="TAB12MDX", data=sub2, kind="bar", ci=None)
        plt.xlabel('Days smoked per month')
        plt.ylabel('Proportion Nicotine Dependent')
        ```

        Alternative syntax

        ```python
        import scipy.stats as stats

        # The degree of freedom is assumed 2
        # With a p-value of 0.05, the confidence level is 1.00-0.05 = 0.95.
        critical_value = stats.chi2.ppf(q = 0.95, df = 2)

        # Run the chi square test with stats.chisquare()
        stats.chisquare(df['observed'], df['expected'])
        ```

    -   Post hoc test when explanatory variable has >2 levels

        Bonferroni Adjusted p-value = $\frac{0.05}{\#\ comparisons}$ <br>
        Run $\chi^2$ test of independence for each paired comparison

          <center><img src="/assets/statistics/chi_suqare_post_hoc.png" width=400></center>

        ```python
        recode2 = {1: 1, 2.5: 2.5}
        sub2['COMP1v2']= sub2['USFREQMO'].map(recode2)

        # contingency table of observed counts
        ct2=pandas.crosstab(sub2['TAB12MDX'], sub2['COMP1v2'])
        print (ct2)

        # column percentages
        colsum=ct2.sum(axis=0)
        colpct=ct2/colsum
        print(colpct)

        print ('chi-square value, p value, expected counts')
        cs2= scipy.stats.chi2_contingency(ct2)
        print (cs2)

        recode3 = {1: 1, 6: 6}
        sub2['COMP1v6']= sub2['USFREQMO'].map(recode3)

        # contingency table of observed counts
        ct3=pandas.crosstab(sub2['TAB12MDX'], sub2['COMP1v6'])
        print (ct3)

        # column percentages
        colsum=ct3.sum(axis=0)
        colpct=ct3/colsum
        print(colpct)

        print ('chi-square value, p value, expected counts')
        cs3= scipy.stats.chi2_contingency(ct3)
        print (cs3)
        ```

*   Example application

    [Blog post](https://www.tumblr.com/blog/rccma)

#### Pearson Correlation

Pearson correlation coefficient (r) measures a linear relationship between two quantitative variables.

Correlation ignores any other type of relationship no matter how strong.

-   $r$: Pearson correlation coefficient
-   $r^2$: R Squared or Coefficient of Determination

    The fraction of the variability of 1 variable that can be predicted by the other. Aka., if we know x, we can predict $r^2$ of the variability we will see in y.

-   Code

    Pearson correlation coefficient

    ```python
    import pandas
    import numpy
    import seaborn
    import scipy
    import matplotlib.pyplot as plt

    # Print r and the corresponding p-value
    print ('association between urbanrate and internetuserate')
    print (scipy.stats.pearsonr(data_clean['urbanrate'], data_clean['internetuserate']))

    print ('association between incomeperperson and internetuserate')
    print (scipy.stats.pearsonr(data_clean['incomeperperson'], data_clean['internetuserate']))
    ```

    Visualize

    ```python
    scat1 = seaborn.regplot(x="urbanrate", y="internetuserate", fit_reg=True, data=data)
    plt.xlabel('Urban Rate')
    plt.ylabel('Internet Use Rate')
    plt.title('Scatterplot for the Association Between Urban Rate and Internet Use Rate')

    scat2 = seaborn.regplot(x="incomeperperson", y="internetuserate", fit_reg=True, data=data)
    plt.xlabel('Income per Person')
    plt.ylabel('Internet Use Rate')
    plt.title('Scatterplot for the Association Between Income per Person and Internet Use Rate')
    ```

-   Example application

    [Blog post](https://www.tumblr.com/blog/scfbid)

#### Moderation

Moderating variable (or moderator) is a third variable that affects the direction and or strength of the relation between the explanatory and response variable.

-   Testing moderation in the context of ANOVA

    Is our explanatory variable associated with our response variable, for each population subgroup or each level of our third variable?

    ```python
    sub2=data[(data['Exercise']=='Cardio')]
    sub3=data[(data['Exercise']=='Weights')]

    print ('association between diet and weight loss for those using Cardio exercise')
    model2 = smf.ols(formula='WeightLoss ~ C(Diet)', data=sub2).fit()
    print (model2.summary())

    print ('association between diet and weight loss for those using Weights exercise')
    model3 = smf.ols(formula='WeightLoss ~ C(Diet)', data=sub3).fit()
    print (model3.summary())

    print ("means for WeightLoss by Diet A vs. B  for CARDIO")
    m3= sub2.groupby('Diet').mean()
    print (m3)
    print ("Means for WeightLoss by Diet A vs. B for WEIGHTS")
    m4 = sub3.groupby('Diet').mean()
    print (m4)
    ```

-   Testing moderation in the context of Chi Square

    Is explanatory variable related to response variable, for each level of our third variable?

    ```python
    sub3=sub2[(sub2['MAJORDEPLIFE']== 0)]
    sub4=sub2[(sub2['MAJORDEPLIFE']== 1)]

    print ('association between smoking quantity and nicotine dependence for those W/O deperession')
    # contingency table of observed counts
    ct2=pandas.crosstab(sub3['TAB12MDX'], sub3['USQUAN'])
    print (ct2)

    # column percentages
    colsum=ct1.sum(axis=0)
    colpct=ct1/colsum
    print(colpct)

    # chi-square
    print ('chi-square value, p value, expected counts')
    cs2= scipy.stats.chi2_contingency(ct2)
    print (cs2)

    print ('association between smoking quantity and nicotine dependence for those WITH depression')
    # contingency table of observed counts
    ct3=pandas.crosstab(sub4['TAB12MDX'], sub4['USQUAN'])
    print (ct3)

    # column percentages
    colsum=ct1.sum(axis=0)
    colpct=ct1/colsum
    print(colpct)

    # chi-square
    print ('chi-square value, p value, expected counts')
    cs3= scipy.stats.chi2_contingency(ct3)
    print (cs3)

    # Visualize
    seaborn.factorplot(x="USQUAN", y="TAB12MDX", data=sub4, kind="point", ci=None)
    plt.xlabel('number of cigarettes smoked per day')
    plt.ylabel('Proportion Nicotine Dependent')
    plt.title('association between smoking quantity and nicotine dependence for those WITH depression')

    seaborn.factorplot(x="USQUAN", y="TAB12MDX", data=sub3, kind="point", ci=None)
    plt.xlabel('number of cigarettes smoked per day')
    plt.ylabel('Proportion Nicotine Dependent')
    plt.title('association between smoking quantity and nicotine dependence for those WITHOUT depression')
    ```

-   Testing moderation in the context of correlation

    ```python
    sub1=data_clean[(data_clean['incomegrp']== 1)]
    sub2=data_clean[(data_clean['incomegrp']== 2)]

    print('association between urbanrate and internetuserate for LOW income countries')
    print(scipy.stats.pearsonr(sub1['urbanrate'], sub1['internetuserate']))
    print()
    print('association between urbanrate and internetuserate for MIDDLE income countries')
    print(scipy.stats.pearsonr(sub2['urbanrate'], sub2['internetuserate']))

    scat1 = seaborn.regplot(x="urbanrate", y="internetuserate", data=sub1)
    plt.xlabel('Urban Rate')
    plt.ylabel('Internet Use Rate')
    plt.title('Scatterplot for the Association Between Urban Rate and Internet Use Rate for LOW income countries')
    print(scat1)
    scat2 = seaborn.regplot(x="urbanrate", y="internetuserate", fit_reg=False, data=sub2)
    plt.xlabel('Urban Rate')
    plt.ylabel('Internet Use Rate')
    plt.title('Scatterplot for the Association Between Urban Rate and Internet Use Rate for MIDDLE income countries')
    print(scat2)
    ```

---

### The Student's t-test

#### One Sample T-Test

Compare sample mean to the population mean

-   Assumptions

    -   Data is normally distributed
    -   Data is independent
    -   Data is randomly sampled

-   Code

    ```python
    import scipy.stats as stats
    stats.ttest_1samp(sample, population.mean())
    ```

#### Independent T-Test

Compare the means of 2 independent populations, i.e., how likely that two samples represent the same underlying population

-   Assumptions

    -   Data is normally distributed
    -   Data is independent
    -   Data is homogenous (The standard deviations are roughly equal)

-   Code

    ```python
    import scipy.stats as stats

    # Note: Setting equal_var=False performs Welch's t-test which does
    # not assume equal population variance
    stats.ttest_ind(population1, population2, equal_var=False)
    ```

---

---

## Non-Parametric Tests

We often use standard hypothesis tests on means of normal distributions to design and analyze experiments. However, it's possible that you will encounter scenarios where you can't rely on only standard tests. This might be due to uncertainty about the true variability of a metric's distribution, a lack of data to assume normality, or wanting to do inference on a statistic that lacks a standard test. It's useful to know about some non-parametric tests, not just as a workaround for cases like this, but also as a second check on your experimental results.

-   (+) The main benefit of non-parametric tests is that they don't rely on many assumptions of the underlying population, and so can be used in a wider range of circumstances compared to standard tests.

### Bootstrapping

#### Method

-   Bootstrapping use resampling of the collected data to make inferences about distributions.
-   In a standard bootstrap, a bootstrapped sample means drawing points from the original data with replacement until we get as many points as there were in the original data. Essentially, we're treating the original data as the population: without making assumptions about the original population distribution, using the original data as a model of the population is the best that we can do.
-   Taking a lot of bootstrapped samples allows us to estimate the sampling distribution for various statistics on our original data.

#### Pros and Cons

-   (+) The bootstrap procedure is fairly simple and straightforward.
-   (+) Since you don't make assumptions about the distribution of data, it can be applicable for any case you encounter.
-   (+) The results should also be fairly comparable to standard tests.
-   (-) It does take computational effort
-   (-) Its output does depend on the data put in. A different sample will produce different intervals, with different accuracies.
-   (-) Confidence intervals coming from the bootstrap procedure will be optimistic compared to the true state of the world. This is because there will be things that we don't know about the real world that we can't account for, due to not having a parametric model of the world's state. Consider the extreme case of trying to understand the distribution of the maximum value: our confidence interval would never be able to include any value greater than the largest observed value and it makes no sense to have any lower bound below the maximum observation. Intuitively, however, there's a pretty clear possibility for there to be unobserved values that are larger than the one we've observed, especially for skewed data.

#### Example

-   Create a 95% confidence interval for the 90th percentile from a dataset of 5000 data points. First of all, we take a bootstrap sample (i.e., draw 5000 points with replacement from the original data), record the 90th percentile, and then repeat this a large number of times, let's say 100 000. From this bunch of bootstrapped 90th percentile estimates, we form our confidence interval by finding the values that capture the central 95% of the estimates (cutting off 2.5% on each tail).

-   Code to calculate confidence interval of a quantile

    ```python
    def quantile_ci(data, q, c = .95, n_trials = 1000):
        """
        Compute a confidence interval for a quantile of a dataset using a bootstrap
        method.

        Input parameters:
            data: data in form of 1-D array-like (e.g. numpy array or Pandas series)
            q: quantile to be estimated, must be between 0 and 1
            c: confidence interval width
            n_trials: number of bootstrap samples to perform

        Output value:
            ci: Tuple indicating lower and upper bounds of bootstrapped
                confidence interval
        """

        # initialize storage of bootstrapped sample quantiles
        n_points = data.shape[0]
        sample_qs = []

        # For each trial...
        for _ in range(n_trials):
            # draw a random sample from the data with replacement...
            sample = np.random.choice(data, n_points, replace = True)

            # compute the desired quantile...
            sample_q = np.percentile(sample, 100 * q)

            # and add the value to the list of sampled quantiles
            sample_qs.append(sample_q)

        # Compute the confidence interval bounds
        lower_limit = np.percentile(sample_qs, (1 - c)/2 * 100)
        upper_limit = np.percentile(sample_qs, (1 + c)/2 * 100)

        return (lower_limit, upper_limit)
    ```

### Permutation tests

#### Method

-   The permutation test is a resampling-type test used to compare the values on an outcome variable between two or more groups.
-   In the case of the permutation test, resampling is done on the group labels. The idea here is that, under the null hypothesis, the outcome distribution should be the same for all groups, whether control or experimental. Thus, we can emulate the null by taking all of the data values as a single large group. Applying labels randomly to the data points (while maintaining the original group membership ratios) gives us one simulated outcome from the null.
-   The rest is similar to the sampling approach used in a standard hypothesis test, except that we haven't specified a reference distribution to sample from – we're sampling directly from the data we've collected. After applying the labels randomly to all the data and recording the outcome statistic many times, we compare our actual, observed statistic against the simulated statistics. A p-value is obtained by seeing how many simulated statistic values are as or more extreme than the one actually observed, and a conclusion is then drawn.

#### Example

-   Implement a permutation test to test if the 90th percentile of times is statistically significantly smaller for the experimental group, as compared to the control group.

-   Code to calculate p-value of a permutation test

    ```python
    def quantile_permtest(x, y, q, alternative = 'less', n_trials = 10_000):
        """
        Compute a p-value from the number of permuted sample differences that are
        less than or greater than the observed difference, depending on the desired
        alternative hypothesis.

        Input parameters:
            x: 1-D array-like of data for independent / grouping feature as 0s and 1s
            y: 1-D array-like of data for dependent / output feature
            q: quantile to be estimated, must be between 0 and 1
            alternative: type of test to perform, {'less', 'greater'}
            n_trials: number of permutation trials to perform

        Output value:
            p: estimated p-value of test
        """


        # initialize storage of bootstrapped sample quantiles
        sample_diffs = []

        # For each trial...
        for _ in range(n_trials):
            # randomly permute the grouping labels
            labels = np.random.permutation(x)

            # compute the difference in quantiles
            cond_q = np.percentile(y[labels == 0], 100 * q)
            exp_q  = np.percentile(y[labels == 1], 100 * q)

            # and add the value to the list of sampled differences
            sample_diffs.append(exp_q - cond_q)

        # compute observed statistic
        cond_q = np.percentile(y[x == 0], 100 * q)
        exp_q  = np.percentile(y[x == 1], 100 * q)
        obs_diff = exp_q - cond_q

        # compute a p-value
        if alternative == 'less':
            hits = (sample_diffs <= obs_diff).sum()
        elif alternative == 'greater':
            hits = (sample_diffs >= obs_diff).sum()

        return (hits / n_trials)

    quantile_permtest(data['condition'], data['time'], 0.9,
                      alternative = 'less')
    ```

### Rank-Sum Test (Mann-Whitney)

#### Method

-   The rank-sum test, also known as the Mann-Whitney U test, only uses the collected data to test distributions between groups.

-   Let's say we draw one value at random from the populations behind each group. The null hypothesis says that there's an equal chance that the larger value is from the first group as the second group; the alternative hypothesis says that there's an unequal chance, which can be specified as one- or two-tailed.

    In order to test this hypothesis, we should look at the data we've collected and see in how many cases values from one group win compared to values in the second. That is, for each data point in the first group, we count how many values in the second group that are smaller than it. (If both values are equal, we count that as a tie, worth +0.5 to the tally.) This number of wins for the first group gives us a value $U$.

    It turns out that $U$ is approximately normally-distributed, given a large enough sample size. If we have $n_1$ data points in the first group and $n_2$ points in the second, then we have a total of $n_1 n_2$ matchups and an equivalent number of victory points to hand out. Under the null hypothesis, we should expect the number of wins to be evenly distributed between groups, and so the expected wins are $\mu_U = \frac{n_1 n_2}{2}$. The variability in the number of wins can be found to be the following equation (assuming no or few ties):

    $$
    \sigma_U = \sqrt{\frac{n_1n_2(n_1+n_2+1)}{12}}
    $$

    These $\mu_U$ and $\sigma_U$ values can then be used to compute a standard normal z-score, which generates a p-value.

-   There's no resamplng involved; the test is performed only on the data present. The rank-sum test is not a test of any particular statistic, like the mean or median. Instead, it's a test of distributions.

#### Example

-   Code to calculate rank-sum test p-value

    ```python
    def ranked_sum(x, y, alternative = 'two-sided'):
        """
        Return a p-value for a ranked-sum test, assuming no ties.

        Input parameters:
            x: 1-D array-like of data for first group
            y: 1-D array-like of data for second group
            alternative: type of test to perform, {'two-sided', less', 'greater'}

        Output value:
            p: estimated p-value of test
        """

        # compute U
        u = 0
        for i in x:
            wins = (i > y).sum()
            ties = (i == y).sum()
            u += wins + 0.5 * ties

        # compute a z-score
        n_1 = x.shape[0]
        n_2 = y.shape[0]
        mean_u = n_1 * n_2 / 2
        sd_u = np.sqrt( n_1 * n_2 * (n_1 + n_2 + 1) / 12 )
        z = (u - mean_u) / sd_u

        # compute a p-value
        if alternative == 'two-sided':
            p = 2 * stats.norm.cdf(-np.abs(z))
        if alternative == 'less':
            p = stats.norm.cdf(z)
        elif alternative == 'greater':
            p = stats.norm.cdf(-z)

        return p

    ranked_sum(data[data['condition'] == 0]['time'],
               data[data['condition'] == 1]['time'],
               alternative = 'greater')
    ```

-   Code to perform rank-sum test using scipy stats package [`mannwhitneyu`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.mannwhitneyu.html)

    This function considers more factors than the implementation above, including a correction on the standard deviation for ties and a continuity correction (since we're approximating a discretely-valued distribution with a continuous one). In addition, the approach they take is computationally more efficient, based on the sum of value ranks (hence the rank-sum test name) rather than the matchups explanation provided above.

    ```python
    stats.mannwhitneyu(data[data['condition'] == 0]['time'],
                       data[data['condition'] == 1]['time'],
                       alternative = 'greater')
    ```

### Sign test

#### Method

-   The sign test only uses the collected data to compute a test result. It only requires that there be _paired values between two groups to compare_, and tests whether one group's values tend to be higher than the other's.

-   In the sign test, we don't care how large differences are between groups, only which group takes a larger value. So comparisons of 0.21 vs. 0.22 and 0.21 vs. 0.31 are both counted equally as a point in favor of the second group. This makes the sign test a fairly weak test, though also a test that can be applied fairly broadly. It's most useful when we have very few observations to draw from and can't make a good assumption of underlying distribution characteristics.

#### Example

-   Can use a sign test as an additional check on click rates that have been aggregated on a daily basis.

    The count of victories for a particular group can be modeled with the binomial distribution. Under the null hypothesis, it is equally likely that either group has a larger value (in the case of a tie, we ignore the comparison): the binomial distribution's success parameter is $p = 0.5$.

-   Code to calculate p-value of a sign test

    ```python
    def sign_test(x, y, alternative = 'two-sided'):
        """
        Return a p-value for a ranked-sum test, assuming no ties.

        Input parameters:
            x: 1-D array-like of data for first group
            y: 1-D array-like of data for second group
            alternative: type of test to perform, {'two-sided', less', 'greater'}

        Output value:
            p: estimated p-value of test
        """

        # compute parameters
        n = x.shape[0] - (x == y).sum()
        k = (x > y).sum() - (x == y).sum()

        # compute a p-value
        if alternative == 'two-sided':
            p = min(1, 2 * stats.binom(n, 0.5).cdf(min(k, n-k)))
        if alternative == 'less':
            p = stats.binom(n, 0.5).cdf(k)
        elif alternative == 'greater':
            p = stats.binom(n, 0.5).cdf(n-k)

        return p

    sign_test(data['control'], data['exp'], 'less')
    ```
