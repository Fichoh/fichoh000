## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    m<- NULL
    #sets the matrix
    set<- function(y) {
      x<<-y
      m<<- NULL
    }
    #gets the matrix
    get<- function() 
      x
    #sets inverse of the matrix
    setinverse<- function(inverse)
      m<<- inverse
    #retrievs the inverse
    getinverse<- function()
      m
    list(set=set,get=get,setinverse=setinverse,
         getinverse=getinverse)
  
  }


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    #checks to see if inverse has been calculated
    m<- x$getinverse()
    #if so, retrieves from cache and skips computation
    if(!is.null()){
      message('getting cached data')
      return(m)
    }
    #if not, get the matrix
    data<- x$get()
    #calculates the inverse
    m<- solve(data,...)
    #sets value in cache
    x$setinverse(m)
    m
}
