context("DESeq2")

test_that("Basic DESeq2 tidier works as expected", {
    dds <- makeExampleDataSet("DESeq2")
    td <- tidy(dds)
    tdp <- tidy(dds, colData=TRUE)

    ## Check that both objects have the bare minimum columns with expected
    ## types
    req.cols <- c(gene='character', sample='character', count='integer')
    for (rc in names(req.cols)) {
        expect_is(td[[rc]], req.cols[[rc]], info=sprintf('td (%s)', rc))
        expect_is(tdp[[rc]], req.cols[[rc]], info=sprintf('tdp (%s)', rc))
    }

    ## tdp has the extra sample data
    pd <- as.data.frame(colData(dds))
    pd.cols <- setNames(sapply(pd, class), names(pd))
    for (pc in names(pd.cols)) {
        expect_is(tdp[[pc]], pd.cols[[pc]], info=sprintf("tdp pheno (%s)", pc))
    }
})
