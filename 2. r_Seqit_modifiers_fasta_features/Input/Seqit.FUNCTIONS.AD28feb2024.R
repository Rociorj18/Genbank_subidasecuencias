# FUNCIONES ELABORADAS POR ANTONIO DIAZ-PEREZ (GESPLAN/JBCVC; 12may2021)

seqit.AD <- function(data.file,fasta.file)
{

#-----------------Reading TAB file from Excel ----------------------------------------------------

MAT <- as.matrix(read.table(data.file,encoding="UTF-8",sep="\t"))
SPECIES <- MAT[,2]
LOCUS <- MAT[,1]
COLLECTOR <- MAT[,3]
DATE <- MAT[,4]
VOUCHER <- MAT[,5]
COUNTRY <- MAT[,6]

#-----------------Reading original Fasta file ----------------------------------------------------

seqs <- read.dna(fasta.file,format="fasta")
seqs2 <- read.dna(fasta.file,format="fasta",as.character=T)
names <- labels(seqs)
number.seqs <- length(names)
long.seqs <- summary(seqs)[,1]
bio.material1 <- str_split(names,"_")
bio.materials2 <- vector() 
for(h in 1:number.seqs)
   {
   bio.materials2 <- c(bio.materials2,bio.material1[[h]][1])                              # modificado AD 28feb2024
   }
for(r in 1:number.seqs)
   {
   seqs2[[r]] <- replace(seqs2[[r]],seqs2[[r]]=="a","A")
   seqs2[[r]] <- replace(seqs2[[r]],seqs2[[r]]=="g","G")
   seqs2[[r]] <- replace(seqs2[[r]],seqs2[[r]]=="c","C")
   seqs2[[r]] <- replace(seqs2[[r]],seqs2[[r]]=="t","T")
   }
SEQ <- list(sequences=seqs2,names=names,number.seqs=number.seqs,long.seqs=long.seqs,voucher.code=bio.materials2)

#-----------------Generation of Fasta file ----------------------------------------------------

for(u in 1:number.seqs)
   {
   L.current.large <- ""
   ind.seq <- SEQ$names[u]
   ind.loc <- LOCUS[u]
   ind.sp  <- SPECIES[u]

   if(ind.loc=="matK") { L.current.large <- "maturase K"}
   if(ind.loc=="rbcl") { L.current.large <- "ribulose-1,5-bisphosphate carboxylase/oxygenase large subunit"}

   line1 <- paste(">",ind.seq," [organism=",ind.sp,"] ",L.current.large," (",ind.loc,") gene, partial sequence, partial cds; chloroplast",sep="")
   line2 <- SEQ$sequences[u] 
   write(line1,file="Seqit.fasta.OUT",append=T)
   write(line2[[1]],file="Seqit.fasta.OUT",append=T,sep="",ncolumns=5000)
   }

#-----------------Generation of Modifiers file ----------------------------------------------------

line1<- paste("Sequence_ID","Bio_material","Specimen_voucher","Collected_by","Collection_date","Country",sep="\t")
write(line1,file="Seqit.modifiers.OUT",append=F)
for(j in 1:number.seqs)
   {
   ind.seq <- SEQ$names[j]
   ind.Bio <- paste("JBCVC: DNABANK:",str_split(ind.seq,"_")[[1]][1],sep=" ")
   ind.vou <- VOUCHER[j]   
   ind.coll <- COLLECTOR[j]
   ind.date <- DATE[j]
   ind.country <- COUNTRY[j]
   line <- paste(ind.seq,ind.Bio,ind.vou,ind.coll,ind.date,ind.country,sep="\t")
   write(line,file="Seqit.modifiers.OUT",append=T)
   }

#-----------------Generation of Feature file ----------------------------------------------------

for(j in 1:number.seqs)
   {
   ind.seq <- SEQ$names[j]
   ind.long <- SEQ$long.seqs[j]
   ind.loc <- LOCUS[j]
   line <- paste(">Feature",ind.seq,sep=" ")
   write(line,file="Seqit.features.OUT",append=T)
   line <- paste("<1",paste(">",ind.long,sep=""),"gene",sep="\t")
   write(line,file="Seqit.features.OUT",append=T)
   line <- paste("","","","gene",ind.loc,sep="\t")
   write(line,file="Seqit.features.OUT",append=T)
   line <- ""
   write(line,file="Seqit.features.OUT",append=T)
   }

#---------------------------------------------------------------------

list(matrix=MAT,sequences=SEQ)

}