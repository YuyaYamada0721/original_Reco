function toggleSidebar(ref) {
  var btn = document.getElementById("sidebar-btn");

  if (document.getElementById("sidebar").classList.toggle('active') == true) {
    btn.className = "close-btn";
  } else {
    btn.className = "toggle-btn";
  }

}
