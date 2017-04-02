library(DBI)
devtools::load_all("RSQLite-pkg")
RSQLite:::init_logging("VERB")


conn <- dbConnect(SQLite(), ":memory:")

tbl_in <- data.frame(a = c(-1e14, 1e15, NA))
dbWriteTable(conn, "test", tbl_in, field.types = "bigint")

asdf


#rs <- dbSendQuery(conn, "SELECT NULL, NULL UNION SELECT 10000000000, 1 UNION SELECT -10000000000, -1")
#rs <- dbSendQuery(conn, "SELECT NULL UNION SELECT 10000000000 UNION SELECT -1")
rs <- dbSendQuery(conn, "SELECT NULL UNION SELECT 1 UNION SELECT -1")
#dbFetch(rs, 0)
dbFetch(rs)$"NULL"
asdf

dbWriteTable(conn, "a", data.frame(a = I(list(raw(10), NULL))))
dbReadTable(conn, "a")

asdf


sql <- c(
  "CREATE TABLE splicing (",
  "  tx_id INTEGER NOT NULL,",
  "  exon_rank INTEGER NOT NULL,",
  "  exon_id INTEGER NOT NULL",
  ")"
)
dbGetQuery(conn, paste(sql, collapse=""))
table_data <- data.frame(
  tx_id=rep(1:100000, each=15),
  exon_rank=1:15,
  exon_id=1:3000
)
sql <- "INSERT INTO splicing VALUES (?,?,?)"
dbBegin(conn)
gc()
#Rprof(line.profiling = TRUE)
#gprofiler::start_profiler()
system.time({dbGetPreparedQuery(conn, sql, table_data); gc()})
system.time({dbGetPreparedQuery(conn, sql, table_data); gc()})
#Rprof(NULL)
#gprofiler::stop_profiler()
dbCommit(conn)
#profvis::profvis(prof_input = "Rprof.out")
#gprofiler::show_profiler_pdf(focus = "bind_rows_impl")
