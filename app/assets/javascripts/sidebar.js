function toggleSidebar(ref) {
  var btn = document.getElementById("sidebar-btn");
  var closeElement = document.createElement("i")
  var closeContent = document.createTextNode("CLOSE MENU")
  closeElement.appendChild(closeContent);
  closeElement.setAttribute("class", "fa fa-backward")
  closeElement.setAttribute("id", "open-btn")
  var openIcon = document.getElementById("sidebar-btn")

  var openElement = document.createElement("i")
  var openContent = document.createTextNode("OPEN MENU")
  openElement.appendChild(openContent);
  openElement.setAttribute("class", "fa fa-forward")
  openElement.setAttribute("id", "open-btn")
  var closeIcon = document.getElementById("sidebar-btn")

  var openBtn = document.getElementById("open-btn")

  if (document.getElementById("sidebar").classList.toggle('active') == true) {
    btn.className = "close-btn";
    openBtn.remove()
    openIcon.appendChild(closeElement);
  } else {
    btn.className = "toggle-btn";
    openBtn.remove()
    closeIcon.appendChild(openElement);
  }

}
