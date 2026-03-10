#!/bin/bash

if [ -z "$1" ]; then
  latest=$(ls -d day-* 2>/dev/null | sort -t- -k2 -n | tail -1)
  if [ -z "$latest" ]; then
    day=1
  else
    day=$(( ${latest#day-} + 1 ))
  fi
else
  day=$1
fi

dir="day-${day}"

if [ -d "$dir" ]; then
  echo "❌ ${dir} 디렉토리가 이미 존재합니다."
  exit 1
fi

mkdir "$dir"

cat > "${dir}/index.html" << EOF
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../reset.scss" />
    <link rel="stylesheet" href="style.scss" />
    <title>Day ${day} of 100 days of code</title>
  </head>
  <body>
    <div class="frame">
      <div class="center">
        <p>Happy coding :)</p>
      </div>
    </div>
  </body>
</html>
EOF

cat > "${dir}/style.scss" << 'EOF'
@import url(https://fonts.googleapis.com/css?family=Open+Sans:700,300);

.frame {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 400px;
  height: 400px;
  margin-top: -200px;
  margin-left: -200px;
  box-shadow: 4px 8px 16px 0 rgba(0, 0, 0, 0.1);
  overflow: hidden;
  background: #fff;
  color: #333;
  font-family: "Open Sans", Helvetica, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  border-radius: 6px;
}

.center {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
EOF

echo "✅ ${dir} 생성 완료!"
