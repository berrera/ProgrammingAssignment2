## Cache the inverse of a matrix to avoid recomputing it every time is it used
##
## First, makeCacheMatrix must be used to create the object that contains
## the "set" function to store the matrix.
## Then, cacheSolve returns the inverse matrix, calculating it once only.
## If the matrix is re-set, then cacheSolve recalculates the inverse

## Create a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinv <- function(inv) m <<- inv
    getinv <- function() m
    list(set = set, get = get,
        setinv = setinv,
        getinv = getinv)
}

## Compute the inverse of the special "matrix" returned by makeCacheMatrix above
## If the inverse has already been calculated (and the matrix has not changed),
## then it retrieves the inverse from the cache

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinv()
    if(!is.null(m)) {
        message("getting cached inverted matrix")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinv(m)
    m
}
