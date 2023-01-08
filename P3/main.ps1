$recipes = Get-Content -Raw C:\Users\zocha\Documents\Projects\SYOP\P3\recipes_short.json | ConvertFrom-Json 

function Get-Recipes-By-Author ($AuthorName) {
    $i = 1
    foreach($recipe in $recipes){
        if($recipe.Author -eq $AuthorName){
            Write-Host("(" + $i + ")" + $recipe.Name + ": " + $recipe.Author)
            $i += 1
        }
    }
}
# Get-Recipes-By-Author("Mary Cadogan")

function Get-Shortest-Recipies ($steps) {
    $i = 1
    foreach($recipe in $recipes){
        if($recipe.Method.Length -le $steps){
            Write-Host("(" + $i + "). " + $recipe.Name)
            $j = 1
            foreach($step in $recipe.Method){
                Write-Host("    " + "(" + $j + "). " + $step)
                $j +=1
            }
            $i += 1
        }
    }
}
# Get-Shortest-Recipies(1)

function Get-Recipes-With-Ingredient($ingredient_search) {
    $i = 1
    $recipes_with_ingredient = @()
    foreach($recipe in $recipes){
        foreach($ingredient in $recipe.Ingredients){
            if ($ingredient.Contains($ingredient_search)) { 
                Write-Host("(" + $i + "). "+ $recipe.Name + ": " + $ingredient)
                $recipes_with_ingredient += $recipe
                $i += 1
            }
        }
    }
    return $recipes_with_ingredient
}
Get-Recipes-With-Ingredient("sausage")

function Get-Ingredient-Amount($ingredient_search) {
    $i = 1
    foreach($recipe in Get-Recipes-With-Ingredient($ingredient_search)){
        foreach($ingredient in $recipe.Ingredients){
            if ($ingredient.Contains($ingredient_search)) { 
                Write-Host("(" + $i + "). "+ $recipe.Name + ": " + $ingredient)
                $i += 1
            }
        }
    }
}
Get-Ingredient-Amount