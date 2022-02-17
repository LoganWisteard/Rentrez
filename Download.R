#set vector of NCBI IDs
ncbi_ids<- c("HQ433692.1","HQ433694.1","HQ433691.1")

# load package; you may need install.packages first
library(rentrez)  
 
#download FASTA data files from NCBI
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#look at Bburg object
str(Bburg)

#Use the strsplit() function on the Bburg object to create a new object called Sequences that contains 3 elements: one for each sequence 
sequences <- strsplit(Bburg, split = "\n\n")

#Print sequences
print(sequences)

#[1] shows us that this is a list and coverts to a data frame
sequences <- unlist(sequences)

#Next, use regular expressions to separate the sequences from the headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",sequences)#create header object
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",sequences)#create sequences object
sequences<-data.frame(Name=header,Sequence=seq)#create new data frame combining the two

#remove the newline characters from the Sequences data frame using regular expressions
sequences$Sequence <- gsub("\\n", "", sequences$Sequence)
print(sequences$Sequence)


#Output this data frame to a file called Sequences.csv
write.csv(sequences, "Sequences.csv")
