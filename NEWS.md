
# cdata 1.2.1 2022/08/119

 * Work around https://github.com/r-lib/roxygen2/issues/1491

# cdata 1.2.0 2021/06/11

 * Remove LazyData decl.

# cdata 1.1.9 2020/10/17

 * Move to tinytest.

# cdata 1.1.8 2020/08/24

 * Deal with data.table change in date type treatment.
 * More links to https.

# cdata 1.1.7 2020/08/12

 * Documentation improvements.

# cdata 1.1.6 2020/02/01

 * fix noSuggests CRAN issue.
 * Move wrapr to Depends.
 * Add rmarkdown suggests.

# cdata 1.1.5 2020/01/21

 * Fix SQL path and improve queries tolerance to types.
 * Allow more trivial cases in transform construction.

# cdata 1.1.4 2020/01/07

 * Tolerate nonexistent column value.

# cdata 1.1.3 2019/10/29

 * Decorate transform.
 * Tune transform speed a bit (control column visibility and lifetime).

# cdata 1.1.2 2019/09/15

 * Add data_algebra interop.

# cdata 1.1.1 2019/07/24

 * Fix some newly dead links.
 * Make rqdatatable a dependency.
 * Start to schematize.
 * Move to newer f_db signature.
 * Adjust license.

# cdata 1.1.0 2019/04/27

 * Switch to rqdatatable implementation.
 * General transform specification.
 * More care with factors.
 * Update vignettes.
 * More tests with factors and dates/times.

# cdata 1.0.9 2019/04/20

 * "layout" commands.
 * Deal better with duplicate entries in db-version of blocks to rows.
 * Move to wrapr draw_framec().
 * Fix typo in general transform example code.

# cdata 1.0.8 2019/03/30

 * More column collision checks.
 * Operator notation.

# cdata 1.0.7 2019/03/23

 * Move to wrapr tests.
 * Better error messages.
 * Better handling of NA in row-dup check.
 
# cdata 1.0.6 2019/02/14

 * More generality in control table keys.
 * Move to RUnit.
 * Less direct data.table.

# cdata 1.0.5 2019/01/20

 * Unify S3 method signatures to allow generic programming over them.
 * Generic record to record transform.
 * Move more functions from DBI to rquery.

# cdata 1.0.4 2019/01/04

 * More vignettes.
 * Improve doc cross-linking.
 * Switch to new f_df signature.

# cdata 1.0.3 2018/10/20

 * Fix ragged gather bug.
 * More argument checking.

# cdata 1.0.2 2018/10/08

 * Change defaults.
 * Some bug fixes.
 
# cdata 1.0.1 2018/09/22

 * Clean up suggests.

# cdata 1.0.0 2018/09/08

 * Neaten up uniqueness checking.

# cdata 0.7.4 2018/08/16

 * rquery extension (moving methods to S3).
 * Documentation fixes.
 
# cdata 0.7.3 2018/07/20

 * Documentation fixes.

# cdata 0.7.2 2018/07/07

 * switch local ops to data.table implementation.
 * re-export more of wrapr
 * move db fns to rquery.

# cdata 0.7.1 2018/06/16

 * Documentation fixes.
 * Don't export cols().
 * Reduce wrapr re-export.
 * More rows in qlook().

# cdata 0.7.0 2018/04/09

 * Narrow dependencies.
 * Switch to dbExecute() (sparklyr seems to have that now).
 * Non-DB implementations for local data case.
 * Remove deprecated fns.

# cdata 0.6.0 2018/03/12

 * Add cols() method.
 * Add doi link in DESCRIPTION (CRAN request).
 * Use build_frame(), draw_frame(), and qchar_frame (quoted frame) from wrapr 1.3.0.

# cdata 0.5.2 2018/01/20

 * Remove append based row binding (seems to have some issues on Spark).
 * Deprecate old methods.

# cdata 0.5.1 2018/01/03

 * New naming convention.
 * Doc fixes.
 * Better table lifetime controls.
 * Move to wrapr 1.0.2.
 * Move grepdf out of package.
 * Add row binder.
 * Add map_fields.
 * Add winvector_temp_db_handle support.

# cdata 0.5.0 2017/11/13

 * query-based re-implementation
 * fluid data workflow.
 * remove dplyr and tidyr dependence
 
# cdata 0.1.7 2017/10/31

 * Better error msgs.

# cdata 0.1.6 2017/10/12

 * work around empty keyset issues.
 * add column control.

# cdata 0.1.5 2017/07/04

 * Allow NA in key columns.
 * Add optional class annotation when moving values to rows.

# cdata 0.1.1 2017/05/05

 * ungroup before calculating distinct.

# cdata 0.1.0 2017/03/28

 * First release.
