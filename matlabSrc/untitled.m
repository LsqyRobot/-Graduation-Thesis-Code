t = 0:0.01:10;
tp = 1;
peak = 0.2;
fat1 = 5;
fat2 = 20;
noiseList1 = arrayfun(@(t)noise(t,tp,peak,fat1),t);
noiseList2 = arrayfun(@(t)noise(t,tp,peak,fat2),t);


