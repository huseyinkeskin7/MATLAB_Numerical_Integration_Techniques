clc;
clear;
close all;
   
IntervalAverageAT=[];                                       %bu satırda her bir tolerans değerinden elde ettiğimiz intervals ortalamalarını yazdırabilmek için boş bir küme olşturduk
IntervalAverageAS=[];                                       %bu satırda her bir tolerans değerinden elde ettiğimiz intervals1 ortalamalarını yazdırabilmek için boş bir küme olşturduk
IntervalAverageASNR=[];                                     %bu satırda her bir tolerans değerinden elde ettiğimiz intervals2 ortalamalarını yazdırabilmek için boş bir küme olşturduk

integralValues = [];                                        %bu satırda integral değerlerini yazdırabilmek için boş matris oluşturduk

estIntAdTrapValues = [];                                    %bu satırda AdapTrap'tan elde ettiğimiz tüm estInt değerlerini yazdırabilmek için boş bir küme olşturduk
estIntAdSimpValues = [];                                    %bu satırda AdapSimpson'dan elde ettiğimiz tüm estInt değerlerini yazdırabilmek için boş bir küme olşturduk
estIntAdSimpNonRecValues = [];                              %bu satırda AdapSimpsonNonRec'den elde ettiğimiz tüm estInt değerlerini yazdırabilmek için boş bir küme olşturduk

estIntSum=0;                                                %bu satır estInt ortalamasına ulaşmak için toplamasını yaptığımız değerleri 0 dan başlatır
estIntSum1=0;                                               %bu satır estInt ortalamasına ulaşmak için toplamasını yaptığımız değerleri 0 dan başlatır
estIntSum2=0;                                               %bu satır estInt ortalamasına ulaşmak için toplamasını yaptığımız değerleri 0 dan başlatır

adTrapintervals=0;                                          %bu satır her tolerans değeri ile elde edilen intervals değerlerimizin her satırında bulunan değerlerin toplama işlemini 0'dan başlatmamıza yarar
adSimpsonsintervals=0;                                      %bu satır her tolerans değeri ile elde edilen intervals1 değerlerimizin her satırında bulunan değerlerin toplama işlemini 0'dan başlatmamıza yarar
adSimpNonRecintervals=0;                                    %bu satır her tolerans değeri ile elde edilen intervals2 değerlerimizin her satırında bulunan değerlerin toplama işlemini 0'dan başlatmamıza yarar

ATTime = [];                                                %bu satır adaptrap'ta kurduğumuz zamanlayıcıların kaydolması için boş matris oluşturur
ASTime = [];                                                %bu satır adapsimpson'da kurduğumuz zamanlayıcıların kaydolması için boş matris oluşturur
ASNRTime = [];                                              %bu satır adapsimpsonnonrec'de kurduğumuz zamanlayıcıların kaydolması için boş matris oluşturur

ATTimeAverage = [];                                         %toplam Adaptrap hesap süresinin ortalamasını yazmak için boş matris oluşturuk
ASTimeAverage = [];                                         %toplam Adapsimpson hesap süresinin ortalamasını yazmak için boş matris oluşturuk
ASNRTimeAverage = [];                                       %toplam Adapsimpsonnonrec hesap süresinin ortalamasını yazmak için boş matris oluşturuk
    
errorAdapTrap = [];                                         %bu satırda her tolerans değerin için hesaplanan AdapTrap değerinin Error değerinin yazılması için boş matris oluşturduk
errorAdapSipmson = [];                                      %bu satırda her tolerans değerin için hesaplanan AdapSimpson değerinin Error değerinin yazılması için boş matris oluşturduk
errorAdapSipmsonNonRec = [];                                %bu satırda her tolerans değerin için hesaplanan AdapSimpsonNonRec değerinin Error değerinin yazılması için boş matris oluşturduk

tolvalue = logspace(-4,-1,20);                              %10^-4 le 10^-1 arasında eş aralıklı 20 değer alma

randomnumber = [];                                          %rastgele seçilen a ve b sayılarını kaydetek için oluşturulan boş küme

for r=1:100
                                                            %100 tane bağımsız random değeri alma için 100 kere dönecek for loop
    rng(r);

    randa = 1 + (5-1) * rand(1);                            %1 ve 5 arasında rastgele sayı seçmeye yarar
    randb = 5 + (9-5) * rand(1);                            %5 ve 9 arasında rastgele sayı seçmeye yarar
    randomnumber = [randa randb ; randomnumber];            %her dögüde rasgele seçilen a ve b değerlerini randomnumber değişkenine kaydetmeye yarar
    
    integralX = integral(@keskin19,randa,randb);            %her 100 random a ve b değeri için sıra sıra integral değerlerini almaya yarar
    integralValues = [integralX ; integralValues];          %elde ettiğimiz 100 integral değerinin bir matris şeklinde store edilmesine yarar
end
    integralSum = sum(integralValues);                      %elde ettiğimiz inteğral değerlerini toplar
    integraAverage=integralSum/100;                         %elde ettiğimiz integral değerlerinin toplamını 100e bölerek ortalamasını alır

for t=1:20                                                  %10^-4 le 10^-1 arasında eş aralıklı 20 değerin hepsini tek tek her döngüde yazdırma
    tol = tolvalue(t);
    disp(tol);

    for i=1:100                                             % 100 bağımsız çalıştırma

    tic;                                                    %tic komutuyla döngü sırasında adapTrap'tan elde ettiğimiz sonucu ne kadar sürede hesapladığını yazdırır
    [estInt, intervals] = adapTrapezoid(@keskin19, randomnumber(i,1), randomnumber(i,2), tol);
    ATTime(i,t) = toc;                                      %bu satırda ise loopta dönen i. değerde kaç saniyede hesapladığını yazdırır.
    
    tic;                                                    %tic komutuyla döngü sırasında adapSimpson'dan elde ettiğimiz sonucu ne kadar sürede hesapladığını yazdırır
    [estInt1, intervals1] = adapSimpsons(@keskin19, randomnumber(i,1), randomnumber(i,2), tol);
    ASTime(i,t) = toc;                                      %bu satırda ise loopta dönen i. değerde kaç saniyede hesapladığını yazdırır.

    tic;                                                    %tic komutuyla döngü sırasında adapSimpNonRec'ten elde ettiğimiz sonucu ne kadar sürede hesapladığını yazdırır
    [estInt2, intervals2] = adapSimpsonsNonRecursive(@keskin19, randomnumber(i,1), randomnumber(i,2), tol);
    ASNRTime(i,t) = toc;                                    %bu satırda ise loopta dönen i. değerde kaç saniyede hesapladığını yazdırır.

    estIntAdTrapValues(i,t) = estInt;                       %bu satırda her tol değeri için AdapTrap'tan elde ettiğimiz tüm estInt değerlerine erişiriz
    estIntAdSimpValues(i,t) = estInt1;                      %bu satırda her tol değeri için AdapSimpson'dan elde ettiğimiz tüm estInt değerlerine erişiriz
    estIntAdSimpNonRecValues(i,t) = estInt2;                %bu satırda her tol değeri için AdapSimpsonNonRec'den elde ettiğimiz tüm estInt değerlerine erişiriz

    [intervalsrow,intervalscol] = size(intervals);          %bu satırda size komutuyla interval değerlerinin satır ve sütunu ayrılır
    [intervalsrow1,intervalscol1] = size(intervals1);       %bu satırda size komutuyla interval değerlerinin satır ve sütunu ayrılır
    [intervalsrow2,intervalscol2] = size(intervals2);       %bu satırda size komutuyla interval değerlerinin satır ve sütunu ayrılır

    adTrapintervals = intervalsrow + adTrapintervals;                 %bu satırda her 100 döngü sonucu elde edilen intervals değerlerimizin her satırında bulunan değerlerin toplama işlemi yapılır                                   
    adSimpsonsintervals = intervalsrow1 + adSimpsonsintervals;        %bu satırda her 100 döngü sonucu elde edilen intervals1 değerlerimizin her satırında bulunan değerlerin toplama işlemi yapılır                      
    adSimpNonRecintervals = intervalsrow2 + adSimpNonRecintervals;    %bu satırda her 100 döngü sonucu elde edilen intervals2 değerlerimizin her satırında bulunan değerlerin toplama işlemi yapılır
    
    ATTimeAverage = mean(ATTime);                           %bu satırda toplam AdapTrap fonksiyonun hesap süresinin ortalamasını alır
    ASTimeAverage = mean(ASTime);                           %bu satırda toplam AdapSimpson fonksiyonun hesap süresinin ortalamasını alır
    ASNRTimeAverage = mean(ASNRTime);                       %bu satırda toplam AdapSimpsonNonRec fonksiyonun hesap süresinin ortalamasını alır

    end

    estIntSum = sum(estIntAdTrapValues);                    %bu satır AdapTrap'tan elde ettiğimiz verilerin toplanmasını sağlar
    estIntSum1 = sum(estIntAdSimpValues);                   %bu satır AdapSimpson'dan elde ettiğimiz verilerin toplanmasını sağlar
    estIntSum2 = sum(estIntAdSimpNonRecValues);             %bu satır AdapSimpsonNonRec'den elde ettiğimiz verilerin toplanmasını sağlar

    estIntAverageAT = estIntSum/100;                        %adapTrapdan elde ettiğimiz estInt verilerinin ortalamasını almamızı sağlar
    estIntAverageAS = estIntSum1/100;                       %adapSimpsondan elde ettiğimiz estInt verilerinin ortalamasını almamızı sağlar
    estIntAverageASNR = estIntSum2/100;                     %adapSimpsonNonRecden elde ettiğimiz estInt verilerinin ortalamasını almamızı sağlar

    adTrapintervals = adTrapintervals/100;                  %bu satır her tolerans değeri ile elde edilen intervals değerlerimizin toplamının ortalamasını alır                  
    adSimpsonsintervals = adSimpsonsintervals/100;          %bu satır her tolerans değeri ile elde edilen intervals1 değerlerimizin toplamının ortalamasını alır
    adSimpNonRecintervals = adSimpNonRecintervals/100;      %bu satır her tolerans değeri ile elde edilen intervals2 değerlerimizin toplamının ortalamasını alır

    IntervalAverageAT = [IntervalAverageAT ; adTrapintervals];                 %bu satırda her bir tolerans değerinden elde ettiğimiz intervals ortalamalarını sıra sıra yazdırıp kaydetmemizi sağlar
    IntervalAverageAS = [IntervalAverageAS ; adSimpsonsintervals];             %bu satırda her bir tolerans değerinden elde ettiğimiz intervals1 ortalamalarını sıra sıra yazdırıp kaydetmemizi sağlar
    IntervalAverageASNR = [IntervalAverageASNR ; adSimpNonRecintervals];       %bu satırda her bir tolerans değerinden elde ettiğimiz intervals2 ortalamalarını sıra sıra yazdırıp kaydetmemizi sağlar
    
    adTrapintervals=0;                                       %döngünün bir sonraki tolerans değerine geçip hesaplamaya devam etmesi sırasında eski tolerans değeri hesaplamalarından devam etmeyip 0'dan başlamasını sağlar
    adSimpsonsintervals=0;                                   %döngünün bir sonraki tolerans değerine geçip hesaplamaya devam etmesi sırasında eski tolerans değeri hesaplamalarından devam etmeyip 0'dan başlamasını sağlar
    adSimpNonRecintervals=0;                                 %döngünün bir sonraki tolerans değerine geçip hesaplamaya devam etmesi sırasında eski tolerans değeri hesaplamalarından devam etmeyip 0'dan başlamasını sağlar
end

for e=1:20
    
    errorAdapTrap = ((estIntAverageAT(e)-integraAverage(1))/estIntAverageAT(e))/100;                %bu satırda her tolerans değerinde hesaplanan AdapTrap değerinin Error değeri alınır
    errorAdapSipmson = ((estIntAverageAS(e)-integraAverage(1))/estIntAverageAS(e))/100;             %bu satırda her tolerans değerinde hesaplanan AdapSimpson değerinin Error değeri alınır
    errorAdapSipmsonNonRec = ((estIntAverageASNR(e)-integraAverage(1))/estIntAverageASNR(e))/100;   %bu satırda her tolerans değerinde hesaplanan AdapSimpsonNonRec değerinin Error değeri alınır

    errorAT(e) = abs(errorAdapTrap);                        %hesaplanan error değerinin mutlak değerini almaya yarar
    errorAS(e) = abs(errorAdapSipmson);                     %hesaplanan error değerinin mutlak değerini almaya yarar
    erroeASNR(e) = abs(errorAdapSipmsonNonRec);             %hesaplanan error değerinin mutlak değerini almaya yarar

end

figure(1)                                                   %bu plotta toldeğeri ve interval ortalamaları grafiğini çıkardık
grid on
hold on
plot(tolvalue,IntervalAverageAT,'DisplayName', 'IntervalAverageAT', 'LineWidth',1.5, color='r');
plot(tolvalue,IntervalAverageAS,'DisplayName', 'IntervalAverageAS', 'LineWidth',1.5, color='b');
ylabel('Interval Average Values');
xlabel('Tolerance Values');
legend show

figure(2)                                                   %bu plotta toldeğeri ve zaman ortalamaları grafiğini çıkardık
grid on
hold on
plot(tolvalue,ATTimeAverage,'DisplayName', 'ATTimeAverage','LineWidth',1.5, color='r');
plot(tolvalue,ASTimeAverage,'DisplayName', 'ASTimeAverage','LineWidth',1.5, color='b');
plot(tolvalue,ASNRTimeAverage,'DisplayName', 'ASNRTimeAverage','LineWidth',1.5, color='g');
ylabel('Time Averages');
xlabel('Tolerance Values');
legend show

figure(3)                                                   %bu plotta toldeğeri ve error değerleri grafiğini çıkardık
grid on
hold on
plot(tolvalue,errorAT,'DisplayName', 'errorAT','LineWidth',1.5, color='r');
plot(tolvalue,errorAS,'DisplayName', 'errorAS','LineWidth',1.5, color='b');
ylabel('Error Values');
xlabel('Tolerance Values');
legend show


%4 sayfa
%1 i eski tüm kodları açıklıcan
%kalanı error - number of intervals - timer 