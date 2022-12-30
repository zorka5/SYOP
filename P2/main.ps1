# Analiza dokumentu Windows Word ( nie mniej niż jedna strona tekstu, rozmiar czcionki 10, pojedyncza interlinia ). W formie graficznej ma zostać przedstawiona statystyka dotycząca tekstu. 
# Liczba wyrazów, liczba zdań, średnia liczba wyrazów na zdanie itd.

$file_path = 'C:\Users\zocha\Documents\Projects\SYOP\P2\test.docx'
$word = New-Object -ComObject Word.application
$document = $word.Documents.Open($file_path)
$document_content = $document.content.Text
# $FirstParagraph = $document.Paragraphs[1].range.Text
# $FirstParagraph
Write-Host($document_content.GetType()) -ForegroundColor Red
$sentences = $document_content.Split(".").Split("!").Split("?")
Write-Host($sentences.GetType()) -ForegroundColor Red
$document.close()
$word.Quit()