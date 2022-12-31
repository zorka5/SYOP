# Analiza dokumentu Windows Word ( nie mniej niż jedna strona tekstu, rozmiar czcionki 10, pojedyncza interlinia ). W formie graficznej ma zostać przedstawiona statystyka dotycząca tekstu. 
# Liczba wyrazów, liczba zdań, średnia liczba wyrazów na zdanie itd.

$file_path = 'C:\Users\zocha\Documents\Projects\SYOP\P2\test.docx'
$word = New-Object -ComObject Word.application
$document = $word.Documents.Open($file_path)
$document_content = $document.content.Text
# $FirstParagraph = $document.Paragraphs[1].range.Text
# $FirstParagraph

# Analiza zdań
$end_o_sentence = @('.','!','?')
$sentences = $document_content -join " "
Write-Host($sentences.GetType())
$characters = @{}
foreach ($character in $end_o_sentence){
    if($character -eq $end_o_sentence[0]){
        $len_before = 0
    }
    else {
        $len_before = $sentences.Length
    }
    $sentences = $sentences.Split($character)
    $len_after = $sentences.Length
    $diff = $len_after - $len_before
    $characters.add($character, $diff)
    Write-Host("Liczba zdan zakonczonych na '"+ $character + "': " + $diff + ". ")
}
# $sentences
$characters
$words = $sentences.Split(" ")
$words_dict = @{}
foreach ($word in $words){

    if ($words_dict.ContainsKey($word)){
        $words_dict.$word +=1
    }
    else{
        $words_dict.Add($word, 0)
    }
}
$words_dict
Write-Host($words.Length) -ForegroundColor Red
# $words
$word_count = ($words).Length
$sentences = $document_content.Split(".").Split("!").Split("?")
Write-Host($sentences.GetType()) -ForegroundColor Red
$document.close()
$word.Quit()