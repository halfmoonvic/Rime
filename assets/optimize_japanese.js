const fs = require("fs");
const path = require("path");

const RANGE = 100;

function normalize(filename) {
  const fileContent = fs.readFileSync(filename, "utf-8");
  const lines = fileContent.split("\n");

  const diffLine = (str, index, range = RANGE) => {
    const start = index - range < 0 ? index : index - range;
    const end = index + range;
    return lines.slice(start, end).some(line => line === str);
  };

  let newLines = [];
  for (let i = 0; i < lines.length; i++) {
    let currentLine = lines[i];
    newLines.push(currentLine);

    let newLine = currentLine;

    // 促音
    const cchLine = currentLine.replace(/tch/g, "cch");
    newLine = cchLine;
    if (!diffLine(cchLine, i)) {
      newLines.push(cchLine);
    }

    // 拗音
    newLine = newLine.replace(/sha/g, "sya");
    newLine = newLine.replace(/shu/g, "syu");
    newLine = newLine.replace(/sho/g, "syo");
    newLine = newLine.replace(/cha/g, "cya");
    newLine = newLine.replace(/chu/g, "cyu");
    newLine = newLine.replace(/cho/g, "cyo");
    newLine = newLine.replace(/che/g, "cye");

    if (newLine !== cchLine && !diffLine(newLine, i)) {
      newLines.push(newLine);
    }
  }

  const newFileContent = newLines.join("\n");
  console.log(
    `${path.basename(filename)}: add ${newLines.length - lines.length} line;`,
  );
  if (newFileContent !== fileContent) {
    fs.writeFileSync(filename, newFileContent);
  }
}

normalize(path.resolve(__dirname, "../dict", "japanese.kana.dict.yaml"));
normalize(path.resolve(__dirname, "../dict", "japanese.jmdict.dict.yaml"));
normalize(path.resolve(__dirname, "../dict", "japanese.mozc.dict.yaml"));
