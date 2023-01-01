$file_path = 'D:\Documents\Projects\SYOP\P2\test2.docx'
$word_object = New-Object -ComObject Word.application
$document = $word_object.Documents.Open($file_path)
$document_content = $document.content.Text

# Analiza zdań - ile pytających, twierdzących itp
$end_o_sentence = @('.', '!', '?')
$sentences = $document_content -join ""
$characters = @{}
foreach ($character in $end_o_sentence) {
    if ($character -eq $end_o_sentence[0]) {
        $len_before = 1
    }
    else {
        $len_before = $sentences.Length
    }
    $sentences = $sentences.Split($character)
    $len_after = $sentences.Length
    $diff = $len_after - $len_before
    $characters.add($character, $diff)

}

$clean_sentences = @()
foreach ($sentence in $sentences) {
    $sentence = $sentence.Trim()    
    if ($sentence.Length -eq 0) {
        continue
    }
    if ($sentence.substring(0, 2) -match " ") { 
        continue
    }
    $clean_sentences += $sentence 
}

Write-Host("Liczba zdan: " + $clean_sentences.Length)

#Wyszukiwanie ilości słów na zdanie

$sentences_lengths = @{}
foreach ($sentence in $clean_sentences) {
    $sentence = $sentence.Trim()    
    $words_in_sentence = $sentence.Split("")
    $len = $words_in_sentence.Length 
    if ($sentences_lengths.ContainsKey($len)) {
        $sentences_lengths.$len += $sentence
    }
    else {
        $sentences_lengths.Add($len , @())
        $sentences_lengths.$len += $sentence
    }
}
Write-Host("Dlugosci zdan: ")
foreach ($sentence_length_key in $sentences_lengths.Keys) {
    Write-Host("Dlugosc " + $sentence_length_key + ": " + $sentences_lengths.$sentence_length_key.Length)
    $i = 1
    foreach ($words in $sentences_lengths.$sentence_length_key) {
        Write-Host("(" + $i + ")" + $words + " ")
        $i += 1
    }
}
$sorted_sentences = ($sentences_lengths.GetEnumerator() | Sort-Object -Property Name -Descending)
$min_len = $sorted_sentences[$sorted_sentences.Length - 1].Name
$max_len = $sorted_sentences[0].Name
Write-Host("Ilosc zdan o roznej dlugosci: ")
Write-Host("Min: " + $min_len + " Max: " + $max_len)

$i = $min_len
while ($i -ne ($max_len + 1)) {
    if ($sentences_lengths.ContainsKey($i)) {
        $tab = $sentences_lengths[$i]
        Write-Host("-" + $i + ": ") -NoNewline
        $j = 1
        while ($j -ne $tab.Length + 1) {
            Write-Host("#") -NoNewline
            $j += 1
        }
    }
    else {
        Write-Host("-" + $i + ": ") -NoNewline
    }
    
    $i += 1
    Write-Host(" ")
}

$longest_sentences = $sentences_lengths[$max_len]
$shorest_sentences = $sentences_lengths[$min_len]


Write-Host("Najkrotsze zdania: ")
foreach ($short_sen in $shorest_sentences) {
    Write-Host($short_sen)

}

Write-Host("Najdluzsze zdania: ")
foreach ($long_sen in $longest_sentences) {
    Write-Host($long_sen)
}

#analiza słów
$whole_text = $document.content.Text
$words = $whole_text.Split(" ")
$words_dict = @{}
$end_chars = @('.', '!', '?', ',', ';')
foreach ($word in $words) {
    $word = $word.Trim()
    $word = $word.ToLower()
    $word = $word -replace '\s', ''

    if ($word.length -eq 0) {
        continue
    }
    foreach ($char in $end_chars) {
        if ($word -eq $char) {
            continue
        }
        $last = $word.substring($word.length - 1, 1)
        if ($last -eq $char) {
            $word = $word.TrimEnd($char)
        }
    }

    if ($words_dict.ContainsKey($word)) {
        $words_dict.$word += 1
    }
    else {
        $words_dict.Add($word, 1)
    }
}
$sorted_words = ($words_dict.GetEnumerator() | Sort-Object -Property Value -Descending)
Write-Host("Najpopularniejszy wyraz: " + $sorted_words[0].Name + ": " + $sorted_words[0].Value)

$words_count = 0
foreach ($word_key in $words_dict.Keys) {
    $words_count += $words_dict[$word_key]
}

Write-Host("Liczba slow: " + $words_count)

$avg_words_per_sentence = $words_count / $clean_sentences.Length
Write-Host("Srednio slow na zdanie: " + $avg_words_per_sentence)

#Close document
$document.close()
$word_object.Quit()
