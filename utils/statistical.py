import random
from typing import Union, Tuple

import scipy.stats as stats
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate

plt.style.use('seaborn')




def plot_dist(data: Union[np.array, pd.Series], rel_freq=True, title=None, ax=None, bs=100):
    """
    Plot the distributions of given data.
    """
    w = [1/data.size]*data.size if rel_freq else None
    y_label = 'Relative Frequency' if rel_freq else 'Absolute Frequency'
    title = 'Distribution of Data' if not title else title
    
    if ax: 
        ax.hist(data, bins=bs, weights=w, ec='black')
        ax.set_xlabel('X', size='xx-large', c='red')
        ax.set_ylabel(y_label, c='red', fontsize=15)
        ax.set_title(title, c='red', fontsize=20)
    else: 
        plt.hist(data, bins=bs, weights=w, ec='black')
        plt.xlabel('X', size='xx-large', c='red')
        plt.ylabel(y_label, c='red', fontsize=15)
        plt.title(title, c='red', fontsize=20)




def get_mean_std(smpl) -> Tuple[int, int]:
    """
    Computes the mean and std of the finite sample or population.
    
    Args:
    ----
        smpl (list): a collection of samples
    
    Return:
    ------
        mean (float): mean of the given sample
        std (float): standard deviation of the given sample
    """
    mean = sum(smpl)/float(len(smpl))
    tot = 0.0
    for x in smpl: tot += (x - mean)**2
    std = (tot/len(smpl))**0.5
    return mean, std


def means_sem(dts, smpl_sz=100, num_smpl=1000, bootstrap=True):
    """Computes the means of samples and standard error of the computed means.
    
    Return:
    ------
        means (np.array): The collection of mean.
        sem (float): The standard deviation of the computed means.    
    """
    means = []
    n = smpl_sz
    
    if bootstrap:
        for i in range(num_smpl):
            smpl = np.random.choice(dts, size=smpl_sz)
            means.append(smpl.mean())
    else:
        for i in range(0, dts.size, n): means.append(dts[i: i+n].mean())
        
    sem = dts.std()/n**0.5
    return np.array(means), sem



def gaussian(x: float, mu: float, sigma: float) -> float:
    constand = (1.0/(sigma*((2*np.pi)**0.5)))
    expomential = np.e**-(((x-mu)**2)/(2*sigma**2))
    return constand*expomential

def gaussian_distributions():
    random.seed(1)
    numSamples = 10000
    dist = [random.gauss(0, 100) for i in range(numSamples)]
    weights = [1/numSamples]*len(dist)
    v = plt.hist(dist, bins=100, weights=weights, ec='black')
    print(len(dist))
    # print(v)
    # print(v[0])
    print('Min:', min(*dist), ';','Max:', max(dist))
    print('Fraction within ~200 of mean =', sum(v[0][30:70]))
    plt.xlabel('X', size='xx-large', c='red')
    plt.ylabel('Relative Frequency', c='red', fontsize=20)
    plt.title('Gaussian Distributions', c='red', fontsize=25)
    plt.show()

def _printGaussian(mu=0, sigma=1) -> None:
    """Plot the gaussian function (Normal Distributaion) of given mu and sigma."""
    xVals, yVals = [], []
    y1, y2 = [], []
    x = -4
    while x <= 4:
        xVals.append(x)
        yVals.append(gaussian(x, mu, sigma))
        y1.append(gaussian(x, 1, 1))
        y2.append(gaussian(x, -1, 0.5))
        x += 0.05
    # plot x and y using star  markers with dashed linestyle
    plt.plot(xVals, yVals, 'r',lw=4, label='N. Dist, mu = ' + str(mu) + ', sigma = ' + str(sigma)) 
    plt.plot(xVals, y1, 'g--', label='N. Dist, mu = 1, sigma = 2')
    plt.plot(xVals, y2, 'b--', label='N. Dist, mu = -1, sigma = 0.5')
    plt.title('Normal Distribution', c='r', fontsize=25)
    plt.xlabel('X', c='r', size='xx-large')
    plt.ylabel('Density', c='r', fontsize=20)
    # plt.axvline(0, ymax='0.6', c='navy')
    plt.legend()
    plt.show()


def check_empirical(num_trials) -> None:
    for t in range(num_trials):
        mu = random.randint(-10, 10)
        sigma = random.randint(1, 10)
        print('For mu =', mu, 'and sigma =', sigma, ':')
        for numStd in (1, 1.96, 3):
            area = scipy.integrate.quad(gaussian, mu-numStd*sigma, mu+numStd*sigma, (mu, sigma))[0]
            print('\tFraction within', numStd, 'std =', round(area, 4))
