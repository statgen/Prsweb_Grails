
// polyfills
if (!Math.log10) { Math.log10 = function(x) { return Math.log(x) / Math.LN10; }; }


const document_ready = () => (new Q.Promise((resolve,reject) => {
    if (document.readyState === 'complete') { resolve(); }
    else { document.addEventListener('readystatechange', ()=>{document_ready().then(resolve)}, {once:true}) }
}));
const deepcopy = (obj) => JSON.parse(JSON.stringify(obj));
