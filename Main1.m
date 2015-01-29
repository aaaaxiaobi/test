function Main1
	tic;
    isFileOrDocument = 0     %0 is Document 1 is File
	mission = 1 : 2;
	dirName = 'E:/实验室/已完成修改代码/AISSig/';
	initPar = F_initPar;

%         spmd(length(mission))
            sigPath = [dirName, '/', num2str(labindex)];
%             resultPath = [sigPath, '/demodResult_2ant/'];
            resultPath = [sigPath, '/demodResult_2ant/', num2str(mission)];
            mkdir(resultPath);
            sigFile = dir(sigPath);
            fileName = cell(1, length(sigFile));
            fileNum = 1;
%             for ii = 1 : 1 : length(sigFile)
            for ii = 1 : 1 : length(sigFile)/2
%             for ii = (length(sigFile)/2 + 1) : 1 : length(sigFile)
                if sigFile(ii).isdir == 0 && ~strcmp(sigFile(ii).name, '.') ...
                        && ~strcmp(sigFile(ii).name, '..') ...
                        && strcmp(sigFile(ii).name(1 : 1 : 6), 'AISsig')
                    % 不记录文件夹和非信号文件
                    fileName{fileNum} = sigFile(ii).name;
                    fileNum = fileNum + 1;
                end
            end
            fileName(fileNum : end) = [];       % 删除剩余的cell
            fileNum = fileNum - 1;

            for fileIdx = 1 : 1 : fileNum
                sigStruct = load([sigPath '/' fileName{fileIdx}]);
                sig = sigStruct.sig;
                demodResult = F_aisDemod(sig, initPar);
                resultFileName = ['AISResult', fileName{fileIdx}(7: end)];
                F_save([resultPath, resultFileName, '_result.mat'], demodResult);
            end
%         end
% 	matlabpool close;
	toc;
end