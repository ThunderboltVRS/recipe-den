function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};

function subscribeGoHome(app) {
  app.ports.goHome.subscribe(function (data) {
    window.location.href = "../index.html";
  });
}

function loadRecipe(path) {

  fetch(path)
                .then(response => response.text())
                .then(structuredDataText => {
                const script = document.createElement('script');
                script.setAttribute('type', 'application/ld+json');
                script.textContent = structuredDataText;
                document.head.appendChild(script);
                });

  fetch(path)
  .then(response => response.json())
  .then((recipe) => {
    var app = Elm.Main.init({
      node: document.getElementById('elmContainer'), 
      flags: {
        recipeUrl: "Test",
        stringifiedRecipe: JSON.stringify(recipe)
      }
    });
    subscribeGoHome(app);
  })
};







