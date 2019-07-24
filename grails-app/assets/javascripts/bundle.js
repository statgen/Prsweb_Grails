/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/assets/";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

	'use strict';
	window._d = window._d || {};

	/*
	Note: example PheWAS: https://statgen.github.io/locuszoom/examples/phewas_scatter.html
	                code: https://github.com/statgen/locuszoom/blob/master/examples/phewas_scatter.html
	Note: example Forest: https://statgen.github.io/locuszoom/examples/phewas_forest.html
	                code: https://github.com/statgen/locuszoom/blob/master/examples/phewas_forest.html
	Note: LZ wiki: https://github.com/statgen/locuszoom/wiki/Scale-Functions
	*/

	/*
	NOTE: OR: "how much does trait incidence change b/w A and B?"
	    - simple/raw/unnormalized OR: for one SNP (useless)
	    - "continuous PRS": across one stdev (current)
	    - b/w Q1 and Q4 (interpretable)
	*/
	console.log("from the index js");

	LocusZoom.ScaleFunctions.add("effect_direction", function(parameters, input){
	    if (typeof input !== "undefined" && !isNaN(input['phewas:beta'])) {
	        if      (input['phewas:beta'] > 0) { return parameters['+'] || null; }
	        else if (input['phewas:beta'] < 0) { return parameters['-'] || null; }
	    }
	    return null;
	});
	LocusZoom.TransformationFunctions.set('2sigfigs', (x) => x.toPrecision(2));


	const handle_data = data => {
	    console.log("inside handle data");
	    console.log(data);
	    document_ready().then(() => {
	        _d.data = data;
	        data.PRS_code_string = data.PRS_code_strings[data.PRS_code];
	        LocusZoom.TransformationFunctions.set('trait_group_color', (trait_group) => data.color_by_category[trait_group]);
	        make_drilldown(data);
	        make_plots(data);
	        if (data.weights37_fname) { add_weights_button(data.weights37_fname, 'GRCh37'); }
	        if (data.weights38_fname) { add_weights_button(data.weights38_fname, 'GRCh38'); }
	    });
	}

	const make_drilldown = data => {
	    $('#select_PRS_code').change(() => {
	        // Try to keep the current source and study, but if they're incompatible with the selected code, use the first available
	        const selected_PRS_code = $('#select_PRS_code').val();
	        const available_PRS_sources = Object.keys(data.drilldown[selected_PRS_code]);
	        const new_PRS_source = (available_PRS_sources.indexOf(data.PRS_source) != -1) ? data.PRS_source : available_PRS_sources[0];
	        const available_PRS_studies = data.drilldown[selected_PRS_code][new_PRS_source].studies;
	        const new_PRS_study = (available_PRS_studies.indexOf(data.PRS_study) != -1) ? data.PRS_study : available_PRS_studies[0];
	        const fname = `${selected_PRS_code}-${new_PRS_source}-${new_PRS_study}.html`;
	        window.location = fname;
	    });

	    $('#select_PRS_source').change(() => {
	        // Try to keep the current study, but if they're incompatible with the selected source, use the first available
	        const selected_PRS_source = $('#select_PRS_source').val();
	        const available_PRS_studies = data.drilldown[data.PRS_code][selected_PRS_source].studies;
	        const new_PRS_study = (available_PRS_studies.indexOf(data.PRS_study) != -1) ? data.PRS_study : available_PRS_studies[0];
	        const fname = `${data.PRS_code}-${selected_PRS_source}-${new_PRS_study}.html`;
	        window.location = fname;
	    });

	    $('#select_PRS_study').change(() => {
	        const selected_PRS_study = $('#select_PRS_study').val();
	        const fname = `${data.PRS_code}-${data.PRS_source}-${selected_PRS_study}.html`;
	        window.location = fname;
	    });
	};

	const make_plots = data => {
	    const y_axis_max = Math.max(
	        5, // show sig line
	        d3.max(data.phewas_df.comparisons['continuous'].logp) * 1.15, //upper_buffer
	        d3.max(data.phewas_ex_df.comparisons['continuous'].logp) * 1.15
	    );
	    const phewas_plot = make_scatter_plot(data.phewas_df,
	                                        `Figure 1: ${data.PRS_code_string} PRS (${data.PRS_code})`,
	                                        data.color_by_category,
	                                        y_axis_max,
	                                        'phewas');
	    phewas_plot.on("element_clicked", function(elem) {
	        const id = elem.data['phewas:id'];
	        make_forest_plot_for_id(data.phewas_df, id);
	    });
	    const phewas_ex_plot = make_scatter_plot(data.phewas_ex_df,
	                                           `Figure 2: ${data.PRS_code_string} PRS (${data.PRS_code}) (exclusion)`,
	                                           data.color_by_category,
	                                           y_axis_max,
	                                           'phewas_ex');

	    let pheno_id_with_strongest_pval = _.max(
	        _.range(_d.data.phewas_df.comparisons.continuous.logp.length),
	        id=>_d.data.phewas_df.comparisons.continuous.logp[id]);
	    make_forest_plot_for_id(data.phewas_df, pheno_id_with_strongest_pval);
	};


	const make_scatter_plot = (df, title, color_by_category, y_axis_max, div_id) => {
	    _d.plots = _d.plots || {};
		console.log("inside the make scatterplot");
		console.log(df);
	    let y_scale;
	    let y_ticks = [];
	    if (y_axis_max < 20) { y_axis_max = 20; }
	    if (y_axis_max <= 40) {
	        y_scale = d3.scale.linear().domain([0, y_axis_max]).range([0,1]);
	        for (let neglog10p = 0; neglog10p < y_axis_max; neglog10p+=4) {
	            y_ticks.push({
	                position: 'left',
	                style: {'font-weight': 'bold'},
	                text: neglog10p.toString(),
	                y: y_scale(neglog10p),
	            });
	        }

	    } else {
	        y_scale = d3.scale.linear().domain([0,20,y_axis_max]).range([0,0.5,1]);
	        for (let neglog10p = 0; neglog10p <= 20; neglog10p+=4) {
	            y_ticks.push({
	                position: 'left',
	                style: {'font-weight': 'bold'},
	                text: neglog10p.toString(),
	                y: y_scale(neglog10p),
	            });
	        }
	        // y_axis_max in 40-60  (+20-40) -> [30, 40, 50, 60]
	        // y_axis_max in 60-100 (+40-80) -> [40, 60, 80, 100]
	        // y_axis_max in 100-180(+80-160)-> [60, 100, 140, 180]
	        // y_axis_max in 100-200         -> [50, 100, 150, 200]
	        // y_axis_max in 200-400         -> [100, 200, 300, 400]
	        // y_axis_max in 400-1000        -> [200, 400, 800, 1200]
	        // ...repeat for *10^n
	        let available_ticks;
	        if (y_axis_max <= 60) { available_ticks = [30,40,50,60]; }
	        else if (y_axis_max <= 80) { available_ticks = [40,60,80,100]; }
	        else if (y_axis_max <= 180) { available_ticks = [60,100,140,180,220]; }
	        else {
	            const power_of_ten = Math.pow(10, Math.floor(Math.log10(y_axis_max)));
	            const first_digit = y_axis_max / power_of_ten;
	            if (first_digit < 2) {
	                available_ticks = [power_of_ten*0.5, power_of_ten, power_of_ten*1.5, power_of_ten*2];
	            } else if (first_digit < 4) {
	                available_ticks = [power_of_ten, power_of_ten*2, power_of_ten*3, power_of_ten*4];
	            } else {
	                available_ticks = [power_of_ten*2, power_of_ten*4, power_of_ten*6, power_of_ten*8, power_of_ten*10];
	            }
	        }
	        for (let i=0; i < available_ticks.length; i++) {
	            if (available_ticks[i] <= y_axis_max) {
	                y_ticks.push({
	                    position: 'left',
	                    style: {'font-weight': 'bold'},
	                    text: available_ticks[i].toString(),
	                    y: y_scale(available_ticks[i]),
	                });
	            }
	        }
	    }

	    const scatter_data = {
	        x: _.range(1, 1+df.code.length),
	        id: _.range(df.code.length),
	        trait_label: df.string,
	        trait_group: df.category,
	        trait_code: df.code,
	        num_cases: df.num_cases,
	        num_controls: df.num_controls,
	        sex: df.sex,
	        log_pvalue:df.comparisons['continuous'].logp,
	        fake_y:    df.comparisons['continuous'].logp.map(y_scale),
	        beta:      df.comparisons['continuous'].beta,
	        sebeta:    df.comparisons['continuous'].sebeta,
	        ci1:       df.comparisons['continuous'].ci1.map(x => x.toPrecision(3)),
	        ci2:       df.comparisons['continuous'].ci2.map(x => x.toPrecision(3)),
	        oddsratio: df.comparisons['continuous'].or,
	    };
	    console.log("logp value");
	    console.log(scatter_data);
	    _d.plots[div_id] = {scatter_data: scatter_data};

	    const width = Math.max(400, $(`#${div_id}`).width()*0.95);

	    const phewas_panel = LocusZoom.Layouts.get('panel', 'phewas', {
	        id: 'panel-0',
	        margin: {left: 50, top: 15, bottom: 130, right: 5},
	        height: width*0.4,
	        width: null, min_width: 0, // override default 800
	    });
	    phewas_panel.axes.y1.ticks = y_ticks;

	    const sig_data_layer = phewas_panel.data_layers[0];
	    sig_data_layer.offset = y_scale(-Math.log10(0.05 / scatter_data.x.length));

	    const phewas_data_layer = phewas_panel.data_layers[1];
	    const phewas_data_layer_overrides = {
	        namespace: {},
	        color: {
	            scale_function: 'categorical_bin',
	            field: 'phewas:trait_group',
	            parameters: {
	                categories: Object.keys(color_by_category),
	                values: Object.keys(color_by_category).map(x => color_by_category[x]),
	            }
	        },
	        point_shape: [
	            {
	                scale_function: 'effect_direction',
	                parameters: {'+': 'triangle-up', '-': 'triangle-down'}
	            },
	            'circle'
	        ],
	        tooltip: {
	            html: "Trait: <strong>{{phewas:trait_label|htmlescape}}</strong><br>" +
	                "Trait Code: {{phewas:trait_code|htmlescape}}<br>" +
	                "Trait Category: <strong style='color:{{phewas:trait_group|trait_group_color}}'>{{phewas:trait_group|htmlescape}}</strong><br>" +
	                "P-value: <strong>{{phewas:log_pvalue|logtoscinotation|htmlescape}}</strong><br>" +
	                "Odds Ratio: <strong>{{phewas:oddsratio|2sigfigs|htmlescape}}</strong> [95%CI: {{phewas:ci1|htmlescape}}-{{phewas:ci2|htmlescape}}]<br>" +
	                "Beta: <strong>{{phewas:beta|2sigfigs|htmlescape}}</strong> [se: {{phewas:sebeta|2sigfigs|htmlescape}}]<br>" +
	                "#Cases: <strong>{{phewas:num_cases|htmlescape}}</strong><br>" +
	                "#Controls: <strong>{{phewas:num_controls|htmlescape}}</strong><br>" +
	                "sex: <strong>{{phewas:sex|htmlescape}}</strong>",
	            closable: false,
	            show: 'highlighted',
	            hide: 'unhighlighted',
	        },
	        //tooltip_positioning: "horizontal",
	    };
	    Object.keys(phewas_data_layer_overrides).forEach(key => { phewas_data_layer[key] = phewas_data_layer_overrides[key] })
	    phewas_data_layer.fields.push(
	        'phewas:x', // if we remove this, LZ sorts categories alphabetically (and then we don't need df.x)
	        'phewas:fake_y',
	        'phewas:trait_code',
	        'phewas:num_cases', 'phewas:num_controls', 'phewas:sex',
	        'phewas:beta', 'phewas:sebeta', 'phewas:ci1', 'phewas:ci2', 'phewas:oddsratio');
	    phewas_data_layer.y_axis.min_extent = [0, 1];
	    phewas_data_layer.y_axis.field = 'phewas:fake_y';
	    phewas_data_layer.label.filters = [{field:"phewas:log_pvalue", operator:">", value: 6}]; // I arbitrarily chose 6 by looking at some plots.

	    const layout = {
	        width: width, min_width: 0,
	        //responsize_resize: true, // what's this do?
	        mouse_guide: false,
	        panels: [phewas_panel],
	    };

	    const data_sources = new LocusZoom.DataSources().add('phewas', ['StaticJSON', scatter_data]);
	    const plot = LocusZoom.populate(`#${div_id}`, data_sources, layout);
	    plot.panels['panel-0'].setTitle(title);

	    _d.plots[div_id] = _d.plots[div_id] || {};
	    _d.plots[div_id].plot = plot;
	    _d.plots[div_id].phewas_data_layer= phewas_data_layer;
	    _d.plots[div_id].layout = layout;
	    return plot;
	};


	const make_forest_plot_for_id = (df, pheno_id) => {
	    const forest_data = {};
	    Object.keys(df.comparisons).forEach((comp) => {
	        forest_data[comp] = {
	            or: df.comparisons[comp].or[pheno_id],
	            or_ci: [
	                df.comparisons[comp].ci1[pheno_id],
	                df.comparisons[comp].ci2[pheno_id],
	            ],
	            // log_pvalue: df.comparisons[comp].logp[pheno_id],
	            // beta: df.comparisons[comp].beta[pheno_id],
	            // sebeta: df.comparisons[comp].sebeta[pheno_id],

	        };
	    });
	    make_forest_plot(forest_data, `Figure 3: ${df.string[pheno_id]}`, 'forest');
	};
	const make_forest_plot = (forest_data, title, div_id) => {
	    _d.forest_data = forest_data;

	    const or_ci_extent = d3.extent(_.flatten(Object.keys(forest_data).map(comp => forest_data[comp].or_ci)).concat([1]));

	    // TODO: use a dynamic width and height (with minimums)
	    const forest_div = d3.select('#'+div_id);
	    forest_div.html(''); // empty it out.

	    forest_div.append('p').attr('class', 'mb-0').style('font-weight', 'bold').text(title);

	    const svg_width = 200;
	    const svg_height = 300;
	    const forest_svg = forest_div.append('svg')
	        .attr('width', `${svg_width}px`)
	        //.attr('width', '100%')
	        .attr('height', `${svg_height}px`);
	    //forest_svg.style('background-color', '#eee')

	    const plot_margin = {left: 65, top: 10, right: 5, bottom: 100};
	    const plot_height = svg_height - plot_margin.top - plot_margin.bottom;
	    const plot_width = svg_width - plot_margin.left - plot_margin.right;
	    const forest_plot = forest_svg.append('g')
	          .attr('transform', `translate(${plot_margin.left},${plot_margin.top})`);
	    ///forest_plot.append('rect').attr('width',plot_width).attr('height',plot_height).style('fill', '#eee');

	    const y_scale = d3.scale.linear()
	          .domain([
	              or_ci_extent[0] - 0.07*(or_ci_extent[1]-or_ci_extent[0]), // upper/lower margins
	              or_ci_extent[1] + 0.07*(or_ci_extent[1]-or_ci_extent[0]),
	          ])
	          .range([plot_height, 0]);

	    ['continuous', 'Q1Q2', 'Q1Q3', 'Q1Q4'].forEach((comp, i) => {
	        const text = {Q1Q2: 'Q1 vs Q2', Q1Q3: 'Q1 vs Q3', Q1Q4: 'Q1 vs Q4', continuous: 'continuous'}[comp];
	        const plot_x_offset = plot_width * (comp=='continuous'? 0.8/5.7 : (i+2.1)/5.7);

	        forest_plot.append('rect')
	            .attr('x', plot_x_offset-5)
	            .attr('y', y_scale(forest_data[comp].or)-5)
	            .attr('width', 10)
	            .attr('height', 10)
	            .attr('stroke-width', 0);

	        forest_plot.append('rect')
	            .attr('x', plot_x_offset-2)
	            .attr('width', 4)
	            .attr('height', y_scale(forest_data[comp].or_ci[0]) - y_scale(forest_data[comp].or_ci[1]))
	            .attr('y', y_scale(forest_data[comp].or_ci[1]))
	            .attr('stroke-width', 0);

	        forest_svg.append('g')
	            .attr('transform', `translate(${plot_margin.left + plot_x_offset + 8},${plot_margin.top + plot_height + 5})`)
	            .append('text')
	            .attr('transform', 'rotate(-65)')
	            .style('text-anchor','end')
	            .text(text)
	    });

	    const y_axis = d3.svg.axis()
	        .scale(y_scale)
	        .orient('left')
	        .innerTickSize(-plot_width)
	        .outerTickSize(0)
	        .tickPadding(7)
	        .ticks(5);
	    forest_plot.append('g')
	        .attr('class', 'x axis')
	        .call(y_axis);

	    forest_svg.append('g')
	        .attr('transform', `translate(18,${plot_margin.top + plot_height/2})`)
	        .append('text')
	        .attr('transform', 'rotate(-90)')
	        .style('text-anchor','middle')
	        .text('Odds Ratio (95% CI)')

	};

	const add_weights_button = (weights_fname, label) => {
	    const str = `<span class="mx-1"><a href="${weights_fname}" class="btn btn-primary">Download weights for ${label}</a></span>`;
	    const $str = $(str);
	    $('#weights').append($str);
	};


	window.handle_data = handle_data;

	/*handle_data(window.jsvars.prs_json);

	handle_data('url/');
*/
/***/ })
/******/ ]);