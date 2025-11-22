function s() {
    let x = document.getElementById('a').value;
      let z = document.getElementById('b').value;
      let res = document.getElementById('r');
      let l1 = parseFloat(x);
      let l2 = parseFloat(z);

      if (isNaN(l1) && isNaN(l2)) {
        res.innerHTML = "Некорректные данные в обеих строках";
      } else if (isNaN(l1)) {
        res.innerHTML = "Некорректные данные в первой строке";
      } else if (isNaN(l2)) {
        res.innerHTML = "Некорректные данные во второй строке";
      } else {
        res.innerHTML = "Результат: " + (l1 + l2);
      }
    }