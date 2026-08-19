-   <b style="color:#C71585">DataFrame.first()</b> -> Returns the first row as a Row.

-   <b style="color:#C71585">DataFrame.head([n])</b> -> Returns the first n rows.

-   <b style="color:#C71585">DataFrame.limit(num)</b> -> Limits the result count to the number specified.

-   <b style="color:#C71585">DataFrame.tail(num)</b> -> Returns the last num rows as a list of Row.

-   <b style="color:#C71585">DataFrame.take(num)</b> -> Returns the first num rows as a list of Row.

-   <b style="color:#C71585">DataFrame.show([n, truncate, vertical])</b> -> Prints the first n rows to the console.

-   <b style="color:#C71585">DataFrame.printSchema([level])</b> -> Prints out the schema in the tree format.

---

-   <b style="color:#C71585">DataFrame.filter(condition)</b> -> Filters rows using the given condition.

-   <b style="color:#C71585">DataFrame.where(condition)</b> -> where() is an alias for filter().

-   <b style="color:#C71585">DataFrame.withColumn(colName, col)</b> -> Returns a new DataFrame by adding a column or replacing the existing column that has the same name.

-   <b style="color:#C71585">DataFrame.withColumns(\*colsMap)</b> -> Returns a new DataFrame by adding multiple columns or replacing the existing columns that have the same names.

-   <b style="color:#C71585">DataFrame.withColumnRenamed(existing, new)</b> -> Returns a new DataFrame by renaming an existing column.

-   <b style="color:#C71585">DataFrame.withColumnsRenamed(colsMap)</b> -> Returns a new DataFrame by renaming multiple columns.

---

-   <b style="color:#C71585">DataFrame.drop(\*cols)</b> -> Returns a new DataFrame without specified columns.

-   <b style="color:#C71585">DataFrame.dropDuplicates([subset])</b> -> Return a new DataFrame with duplicate rows removed, optionally only considering certain columns.

-   <b style="color:#C71585">DataFrame.dropDuplicatesWithinWatermark([subset])</b> -> Return a new DataFrame with duplicate rows removed,

-   <b style="color:#C71585">DataFrame.drop_duplicates([subset])</b> -> drop_duplicates() is an alias for dropDuplicates().

-   <b style="color:#C71585">DataFrame.dropna([how, thresh, subset])</b> -> Returns a new DataFrame omitting rows with null values.

-   <b style="color:#C71585">DataFrame.explain([extended, mode])</b> -> Prints the (logical and physical) plans to the console for debugging purposes.

-   <b style="color:#C71585">DataFrame.fillna(value[, subset])</b> -> Replace null values, alias for na.fill().

-   <b style="color:#C71585">DataFrame.foreach(f)</b> -> Applies the f function to all Row of this DataFrame.

-   <b style="color:#C71585">DataFrame.foreachPartition(f)</b> -> Applies the f function to each partition of this DataFrame.

-   <b style="color:#C71585">DataFrame.hint(name, \*parameters)</b> -> Specifies some hint on the current DataFrame.

-   <b style="color:#C71585">DataFrame.isEmpty()</b> -> Checks if the DataFrame is empty and returns a boolean value.

-   <b style="color:#C71585">DataFrame.isLocal()</b> -> Returns True if the collect() and take() methods can be run locally (without any Spark executors).

-   <b style="color:#C71585">DataFrame.alias(alias)</b> -> Returns a new DataFrame with an alias set.

-   <b style="color:#C71585">DataFrame.collect()</b> -> Returns all the records as a list of Row.

-   <b style="color:#C71585">DataFrame.count()</b> -> Returns the number of rows in this DataFrame.

-   <b style="color:#C71585">DataFrame.createTempView(name)</b> -> Creates a local temporary view with this DataFrame.

-   <b style="color:#C71585">DataFrame.distinct()</b> -> Returns a new DataFrame containing the distinct rows in this DataFrame.

---

-   <b style="color:#C71585">DataFrame.cache()</b> -> Persists the DataFrame with the default storage level (MEMORY_AND_DISK_DESER).

-   <b style="color:#C71585">DataFrame.coalesce(numPartitions)</b> -> Returns a new DataFrame that has exactly numPartitions partitions.

-   <b style="color:#C71585">DataFrame.persist([storageLevel])</b> -> Sets the storage level to persist the contents of the DataFrame across operations after the first time it is computed.

-   <b style="color:#C71585">DataFrame.unpersist([blocking])</b> -> Marks the DataFrame as non-persistent, and remove all blocks for it from memory and disk.

-   <b style="color:#C71585">DataFrame.join(other[, on, how])</b> -> Joins with another DataFrame, using the given join expression.

-   <b style="color:#C71585">DataFrame.crossJoin(other)</b> -> Returns the cartesian product with another DataFrame.

-   <b style="color:#C71585">DataFrame.groupBy(\*cols)</b> -> Groups the DataFrame using the specified columns, so we can run aggregation on them.

-   <b style="color:#C71585">DataFrame.orderBy(\*cols, \*\*kwargs)</b> -> Returns a new DataFrame sorted by the specified column(s).

-   <b style="color:#C71585">DataFrame.agg(\*exprs)</b> -> Aggregate on the entire DataFrame without groups (shorthand for df.groupBy().agg()).

-   <b style="color:#C71585">DataFrame.repartition(numPartitions, \*cols)</b> -> Returns a new DataFrame partitioned by the given partitioning expressions.

-   <b style="color:#C71585">DataFrame.repartitionByRange(numPartitions, …)</b> -> Returns a new DataFrame partitioned by the given partitioning expressions.

-   <b style="color:#C71585">DataFrame.replace(to_replace[, value, subset])</b> -> Returns a new DataFrame replacing a value with another value.

-   <b style="color:#C71585">DataFrame.select(\*cols)</b> -> Projects a set of expressions and returns a new DataFrame.

-   <b style="color:#C71585">DataFrame.selectExpr(\*expr)</b> -> Projects a set of SQL expressions and returns a new DataFrame.

-   <b style="color:#C71585">DataFrame.sort(\*cols, \*\*kwargs)</b> -> Returns a new DataFrame sorted by the specified column(s).

-   <b style="color:#C71585">DataFrame.sortWithinPartitions(\*cols, \*\*kwargs)</b> -> Returns a new DataFrame with each partition sorted by the specified column(s).

-   <b style="color:#C71585">DataFrame.union(other)</b> -> Return a new DataFrame containing the union of rows in this and another DataFrame.

-   <b style="color:#C71585">DataFrame.unionAll(other)</b> -> Return a new DataFrame containing the union of rows in this and another DataFrame.

-   <b style="color:#C71585">DataFrame.intersect(other)</b> -> Return a new DataFrame containing rows only in both this DataFrame and another DataFrame.

-   <b style="color:#C71585">DataFrame.subtract(other)</b> -> Return a new DataFrame containing rows in this DataFrame but not in another DataFrame.

-   <b style="color:#C71585">DataFrame.unpivot(ids, values, …)</b> -> Unpivot a DataFrame from wide format to long format, optionally leaving identifier columns set.

-   <b style="color:#C71585">DataFrame.melt(ids, values, …)</b> -> Unpivot a DataFrame from wide format to long format, optionally leaving identifier columns set.

---

-   <b style="color:#C71585">DataFrame.describe(\*cols)</b> -> Computes basic statistics for numeric and string columns.

-   <b style="color:#C71585">DataFrame.summary(\*statistics)</b> -> Computes specified statistics for numeric and string columns.

-   <b style="color:#C71585">DataFrame.stat</b> -> Returns a DataFrameStatFunctions for statistic functions.

-   <b style="color:#C71585">DataFrame.sample([withReplacement, …])</b> -> Returns a sampled subset of this DataFrame.

-   <b style="color:#C71585">DataFrame.sampleBy(col, fractions[, seed])</b> -> Returns a stratified sample without replacement based on the fraction given on each stratum.

-   <b style="color:#C71585">DataFrame.corr(col1, col2[, method])</b> -> Calculates the correlation of two columns of a DataFrame as a double value.

-   <b style="color:#C71585">DataFrame.cov(col1, col2)</b> -> Calculate the sample covariance for the given columns, specified by their names, as a double value.

#### Convertion

-   <b style="color:#C71585">DataFrame.toDF(\*cols)</b> -> Returns a new DataFrame that with new specified column names

-   <b style="color:#C71585">DataFrame.toJSON([use_unicode])</b> -> Converts a DataFrame into a RDD of string.

-   <b style="color:#C71585">DataFrame.toPandas()</b> -> Returns the contents of this DataFrame as Pandas pandas.DataFrame.

-   <b style="color:#C71585">DataFrame.to_pandas_on_spark([index_col])</b> -> - <b style="color:#C71585">DataFrame.transform(func, \*args, \*\*kwargs)</b> -> Returns a new DataFrame.

-   <b style="color:#C71585">DataFrame.pandas_api([index_col])</b> -> Converts the existing DataFrame into a pandas-on-Spark DataFrame.

#### Writing

-   <b style="color:#C71585">DataFrame.write</b> -> Interface for saving the content of the non-streaming DataFrame out into external storage.

-   <b style="color:#C71585">DataFrame.writeStream</b> -> Interface for saving the content of the streaming DataFrame out into external storage.

-   <b style="color:#C71585">DataFrame.writeTo(table)</b> -> Create a write configuration builder for v2 sources.
