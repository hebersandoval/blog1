Notes about your code

Strong params:

# strong params, when enabled, rails needs to be told what parameters are allowed to be submitted through the form to th db. the default is to let nothing through.

```
private

def post_params

  # require: it means that the params that get passed in MUST contain a key called "post". if it doesn't, it fails and the user gets an error.

  params.require(:post).permit(:title, :content)

  # permit: it means that the params hash MAY have whatever keys are in it. so in the case of #create case, it may have the :title and :content keys. if it doesn't have one of those keys, its no problem, the hash just wont accept any other keys.

end
```
