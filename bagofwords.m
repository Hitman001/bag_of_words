
%to get input from the user
[filename,filepath] = uigetfile({'*.*';'*.jpg';'*.bmp';'*.png'},'Search image to Display');
fullname = [filepath filename];
ImageFile = imread(fullname);
imshow(ImageFile);
imagesc(ImageFile);
imwrite(ImageFile,'img.png');

%ocr implementation

a = imread('img.png');
ocrResults = ocr(a);
 Iocr         = insertObjectAnnotation(a, 'rectangle', ...
                           ocrResults.WordBoundingBoxes, ...
                           ocrResults.WordConfidences);
                       figure;
 imshow(Iocr);

title('Text Detection');


%blocking the text area

businessCard = imread('img.png');
ocrResults = ocr(businessCard);
recognizedText = ocrResults.Text;

 
 text(200, 1350, recognizedText, 'BackgroundColor', [.94 .94 .94]);
 save('text','recognizedText');
 
 %making the bag of words
 
 Data = load('text.mat');
DataField = fieldnames(Data);
dlmwrite('text.txt',Data.(DataField{1}),'delimiter','');

filename = "text.txt";
str = extractFileText(filename);
textData = split(str,newline);
documents = tokenizedDocument(textData);

bag = bagOfWords(documents);
tbl = topkwords(bag,10)