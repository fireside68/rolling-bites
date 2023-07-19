const esbuild = require("esbuild");

const options = {
  entryPoints: ["js/app.js"],
  bundle: true,
  minify: true,
  target: ["es2017"],
  outdir: "priv/static/assets",
  external: ["/fonts/*", "/images/*"],
};

esbuild.build(options).catch((err) => {
  console.error(err);
  process.exit(1);
});
