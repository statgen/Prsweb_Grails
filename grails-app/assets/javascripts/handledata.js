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
//console.log("from handledatajs");
LocusZoom.ScaleFunctions.add("effect_direction", function (parameters, input) {
    if (typeof input !== "undefined" && !isNaN(input['phewas:beta'])) {
        if (input['phewas:beta'] > 0) {
            return parameters['+'] || null;
        } else if (input['phewas:beta'] < 0) {
            return parameters['-'] || null;
        }
    }

    return null;
});
//console.log("2");
LocusZoom.TransformationFunctions.set('2sigfigs', function (x) {
    return x.toPrecision(2);
});
//console.log("3");
var handle_data = function handle_data(data) {
    //console.log("inside handledata.js loop");
    //console.log(data);
    document_ready().then(function () {
        _d.data = data;
        data.PRS_code_string = data.PRS_code_strings[data.PRS_code];
        LocusZoom.TransformationFunctions.set('trait_group_color', function (trait_group) {
            return data.color_by_category[trait_group];
        });
        make_drilldown(data);
        make_plots(data);

        if (data.weights37_fname) {
            add_weights_button(data.weights37_fname, 'GRCh37');
        }

        if (data.weights38_fname) {
            add_weights_button(data.weights38_fname, 'GRCh38');
        }
    });
};

var make_drilldown = function make_drilldown(data) {
    $('#select_PRS_code').change(function () {
        // Try to keep the current source and study, but if they're incompatible with the selected code, use the first available
        var selected_PRS_code = $('#select_PRS_code').val();
        var available_PRS_sources = Object.keys(data.drilldown[selected_PRS_code]);
        var new_PRS_source = available_PRS_sources.indexOf(data.PRS_source) != -1 ? data.PRS_source : available_PRS_sources[0];
        var available_PRS_studies = data.drilldown[selected_PRS_code][new_PRS_source].studies;
        var new_PRS_study = available_PRS_studies.indexOf(data.PRS_study) != -1 ? data.PRS_study : available_PRS_studies[0];
        var fname = "".concat(selected_PRS_code, "-").concat(new_PRS_source, "-").concat(new_PRS_study, ".html");
        window.location = fname;
    });
    $('#select_PRS_source').change(function () {
        // Try to keep the current study, but if they're incompatible with the selected source, use the first available
        var selected_PRS_source = $('#select_PRS_source').val();
        var available_PRS_studies = data.drilldown[data.PRS_code][selected_PRS_source].studies;
        var new_PRS_study = available_PRS_studies.indexOf(data.PRS_study) != -1 ? data.PRS_study : available_PRS_studies[0];
        var fname = "".concat(data.PRS_code, "-").concat(selected_PRS_source, "-").concat(new_PRS_study, ".html");
        window.location = fname;
    });
    $('#select_PRS_study').change(function () {
        var selected_PRS_study = $('#select_PRS_study').val();
        var fname = "".concat(data.PRS_code, "-").concat(data.PRS_source, "-").concat(selected_PRS_study, ".html");
        window.location = fname;
    });
};

var make_plots = function make_plots(data) {

    //console.log()
    var y_axis_max = Math.max(5, // show sig line
        d3.max(data.phewas_df.comparisons['continuous'].logp) * 1.15, //upper_buffer
        d3.max(data.phewas_ex_df.comparisons['continuous'].logp) * 1.15);
    //console.log("4");
    var phewas_plot = make_scatter_plot(data.phewas_df, "Figure 1: ".concat(data.PRS_code_string, " PRS (").concat(data.PRS_code, ")"), data.color_by_category, y_axis_max, 'phewas');
    //console.log("5");
    phewas_plot.on("element_clicked", function (elem) {
        var id = elem.data['phewas:id'];
        make_forest_plot_for_id(data.phewas_df, id);
    });
    //console.log("6");
    var phewas_ex_plot = make_scatter_plot(data.phewas_ex_df, "Figure 2: ".concat(data.PRS_code_string, " PRS (").concat(data.PRS_code, ") (exclusion)"), data.color_by_category, y_axis_max, 'phewas_ex');

    var pheno_id_with_strongest_pval = _.max(_.range(_d.data.phewas_df.comparisons.continuous.logp.length), function (id) {
        return _d.data.phewas_df.comparisons.continuous.logp[id];
    });

    make_forest_plot_for_id(data.phewas_df, pheno_id_with_strongest_pval);
};

var make_scatter_plot = function make_scatter_plot(df, title, color_by_category, y_axis_max, div_id) {
    _d.plots = _d.plots || {};
    //console.log("inside the make scatterplot");
    //console.log(df);
    var y_scale;
    var y_ticks = [];

    if (y_axis_max < 20) {
        y_axis_max = 20;
    }

    if (y_axis_max <= 40) {
        y_scale = d3.scale.linear().domain([0, y_axis_max]).range([0, 1]);

        for (var neglog10p = 0; neglog10p < y_axis_max; neglog10p += 4) {
            y_ticks.push({
                position: 'left',
                style: {
                    'font-weight': 'bold'
                },
                text: neglog10p.toString(),
                y: y_scale(neglog10p)
            });
        }
    } else {
        y_scale = d3.scale.linear().domain([0, 20, y_axis_max]).range([0, 0.5, 1]);

        for (var _neglog10p = 0; _neglog10p <= 20; _neglog10p += 4) {
            y_ticks.push({
                position: 'left',
                style: {
                    'font-weight': 'bold'
                },
                text: _neglog10p.toString(),
                y: y_scale(_neglog10p)
            });
        } // y_axis_max in 40-60  (+20-40) -> [30, 40, 50, 60]
        // y_axis_max in 60-100 (+40-80) -> [40, 60, 80, 100]
        // y_axis_max in 100-180(+80-160)-> [60, 100, 140, 180]
        // y_axis_max in 100-200         -> [50, 100, 150, 200]
        // y_axis_max in 200-400         -> [100, 200, 300, 400]
        // y_axis_max in 400-1000        -> [200, 400, 800, 1200]
        // ...repeat for *10^n


        var available_ticks;

        if (y_axis_max <= 60) {
            available_ticks = [30, 40, 50, 60];
        } else if (y_axis_max <= 80) {
            available_ticks = [40, 60, 80, 100];
        } else if (y_axis_max <= 180) {
            available_ticks = [60, 100, 140, 180, 220];
        } else {
            var power_of_ten = Math.pow(10, Math.floor(Math.log10(y_axis_max)));
            var first_digit = y_axis_max / power_of_ten;

            if (first_digit < 2) {
                available_ticks = [power_of_ten * 0.5, power_of_ten, power_of_ten * 1.5, power_of_ten * 2];
            } else if (first_digit < 4) {
                available_ticks = [power_of_ten, power_of_ten * 2, power_of_ten * 3, power_of_ten * 4];
            } else {
                available_ticks = [power_of_ten * 2, power_of_ten * 4, power_of_ten * 6, power_of_ten * 8, power_of_ten * 10];
            }
        }

        for (var i = 0; i < available_ticks.length; i++) {
            if (available_ticks[i] <= y_axis_max) {
                y_ticks.push({
                    position: 'left',
                    style: {
                        'font-weight': 'bold'
                    },
                    text: available_ticks[i].toString(),
                    y: y_scale(available_ticks[i])
                });
            }
        }
    }

    var scatter_data = {
        x: _.range(1, 1 + df.code.length),
        id: _.range(df.code.length),
        trait_label: df.string,
        trait_group: df.category,
        trait_code: df.code,
        num_cases: df.num_cases,
        num_controls: df.num_controls,
        sex: df.sex,
        log_pvalue: df.comparisons['continuous'].logp,
        fake_y: df.comparisons['continuous'].logp.map(y_scale),
        beta: df.comparisons['continuous'].beta,
        sebeta: df.comparisons['continuous'].sebeta,
        ci1: df.comparisons['continuous'].ci1.map(function (x) {
            return x.toPrecision(3);
        }),
        ci2: df.comparisons['continuous'].ci2.map(function (x) {
            return x.toPrecision(3);
        }),
        oddsratio: df.comparisons['continuous'].or
    };
    console.log("logp value");
    //console.log(scatter_data);
    _d.plots[div_id] = {
        scatter_data: scatter_data
    };
    var width = Math.max(400, $("#".concat(div_id)).width() * 0.95);
    var phewas_panel = LocusZoom.Layouts.get('panel', 'phewas', {
        id: 'panel-0',
        margin: {
            left: 50,
            top: 15,
            bottom: 130,
            right: 5
        },
        height: width * 0.4,
        width: null,
        min_width: 0 // override default 800

    });
    phewas_panel.axes.y1.ticks = y_ticks;
    var sig_data_layer = phewas_panel.data_layers[0];
    sig_data_layer.offset = y_scale(-Math.log10(0.05 / scatter_data.x.length));
    var phewas_data_layer = phewas_panel.data_layers[1];
    var phewas_data_layer_overrides = {
        namespace: {},
        color: {
            scale_function: 'categorical_bin',
            field: 'phewas:trait_group',
            parameters: {
                categories: Object.keys(color_by_category),
                values: Object.keys(color_by_category).map(function (x) {
                    return color_by_category[x];
                })
            }
        },
        point_shape: [{
            scale_function: 'effect_direction',
            parameters: {
                '+': 'triangle-up',
                '-': 'triangle-down'
            }
        }, 'circle'],
        tooltip: {
            html: "Trait: <strong>{{phewas:trait_label|htmlescape}}</strong><br>" + "Trait Code: {{phewas:trait_code|htmlescape}}<br>" + "Trait Category: <strong style='color:{{phewas:trait_group|trait_group_color}}'>{{phewas:trait_group|htmlescape}}</strong><br>" + "P-value: <strong>{{phewas:log_pvalue|logtoscinotation|htmlescape}}</strong><br>" + "Odds Ratio: <strong>{{phewas:oddsratio|2sigfigs|htmlescape}}</strong> [95%CI: {{phewas:ci1|htmlescape}}-{{phewas:ci2|htmlescape}}]<br>" + "Beta: <strong>{{phewas:beta|2sigfigs|htmlescape}}</strong> [se: {{phewas:sebeta|2sigfigs|htmlescape}}]<br>" + "#Cases: <strong>{{phewas:num_cases|htmlescape}}</strong><br>" + "#Controls: <strong>{{phewas:num_controls|htmlescape}}</strong><br>" + "sex: <strong>{{phewas:sex|htmlescape}}</strong>",
            closable: false,
            show: 'highlighted',
            hide: 'unhighlighted'
        } //tooltip_positioning: "horizontal",

    };
    Object.keys(phewas_data_layer_overrides).forEach(function (key) {
        phewas_data_layer[key] = phewas_data_layer_overrides[key];
    });
    phewas_data_layer.fields.push('phewas:x', // if we remove this, LZ sorts categories alphabetically (and then we don't need df.x)
        'phewas:fake_y', 'phewas:trait_code', 'phewas:num_cases', 'phewas:num_controls', 'phewas:sex', 'phewas:beta', 'phewas:sebeta', 'phewas:ci1', 'phewas:ci2', 'phewas:oddsratio');
    phewas_data_layer.y_axis.min_extent = [0, 1];
    phewas_data_layer.y_axis.field = 'phewas:fake_y';
    phewas_data_layer.label.filters = [{
        field: "phewas:log_pvalue",
        operator: ">",
        value: 6
    }]; // I arbitrarily chose 6 by looking at some plots.

    var layout = {
        width: width,
        min_width: 0,
        //responsize_resize: true, // what's this do?
        mouse_guide: false,
        panels: [phewas_panel]
    };
    var data_sources = new LocusZoom.DataSources().add('phewas', ['StaticJSON', scatter_data]);
    var plot = LocusZoom.populate("#".concat(div_id), data_sources, layout);
    plot.panels['panel-0'].setTitle(title);
    _d.plots[div_id] = _d.plots[div_id] || {};
    _d.plots[div_id].plot = plot;
    _d.plots[div_id].phewas_data_layer = phewas_data_layer;
    _d.plots[div_id].layout = layout;
    return plot;
};

var make_forest_plot_for_id = function make_forest_plot_for_id(df, pheno_id) {
    var forest_data = {};
    Object.keys(df.comparisons).forEach(function (comp) {
        forest_data[comp] = {
            or: df.comparisons[comp].or[pheno_id],
            or_ci: [df.comparisons[comp].ci1[pheno_id], df.comparisons[comp].ci2[pheno_id]] // log_pvalue: df.comparisons[comp].logp[pheno_id],
            // beta: df.comparisons[comp].beta[pheno_id],
            // sebeta: df.comparisons[comp].sebeta[pheno_id],

        };
    });
    make_forest_plot(forest_data, "Figure 3: ".concat(df.string[pheno_id]), 'forest');
};

var make_forest_plot = function make_forest_plot(forest_data, title, div_id) {
    _d.forest_data = forest_data;
    var or_ci_extent = d3.extent(_.flatten(Object.keys(forest_data).map(function (comp) {
        return forest_data[comp].or_ci;
    })).concat([1])); // TODO: use a dynamic width and height (with minimums)

    var forest_div = d3.select('#' + div_id);
    forest_div.html(''); // empty it out.

    forest_div.append('p').attr('class', 'mb-0').style('font-weight', 'bold').text(title);
    var svg_width = 200;
    var svg_height = 300;
    var forest_svg = forest_div.append('svg').attr('width', "".concat(svg_width, "px")) //.attr('width', '100%')
        .attr('height', "".concat(svg_height, "px")); //forest_svg.style('background-color', '#eee')

    var plot_margin = {
        left: 65,
        top: 10,
        right: 5,
        bottom: 100
    };
    var plot_height = svg_height - plot_margin.top - plot_margin.bottom;
    var plot_width = svg_width - plot_margin.left - plot_margin.right;
    var forest_plot = forest_svg.append('g').attr('transform', "translate(".concat(plot_margin.left, ",").concat(plot_margin.top, ")")); ///forest_plot.append('rect').attr('width',plot_width).attr('height',plot_height).style('fill', '#eee');

    var y_scale = d3.scale.linear().domain([or_ci_extent[0] - 0.07 * (or_ci_extent[1] - or_ci_extent[0]), // upper/lower margins
        or_ci_extent[1] + 0.07 * (or_ci_extent[1] - or_ci_extent[0])]).range([plot_height, 0]);
    ['continuous', 'Q1Q2', 'Q1Q3', 'Q1Q4'].forEach(function (comp, i) {
        var text = {
            Q1Q2: 'Q1 vs Q2',
            Q1Q3: 'Q1 vs Q3',
            Q1Q4: 'Q1 vs Q4',
            continuous: 'continuous'
        }[comp];
        var plot_x_offset = plot_width * (comp == 'continuous' ? 0.8 / 5.7 : (i + 2.1) / 5.7);
        forest_plot.append('rect').attr('x', plot_x_offset - 5).attr('y', y_scale(forest_data[comp].or) - 5).attr('width', 10).attr('height', 10).attr('stroke-width', 0);
        forest_plot.append('rect').attr('x', plot_x_offset - 2).attr('width', 4).attr('height', y_scale(forest_data[comp].or_ci[0]) - y_scale(forest_data[comp].or_ci[1])).attr('y', y_scale(forest_data[comp].or_ci[1])).attr('stroke-width', 0);
        forest_svg.append('g').attr('transform', "translate(".concat(plot_margin.left + plot_x_offset + 8, ",").concat(plot_margin.top + plot_height + 5, ")")).append('text').attr('transform', 'rotate(-65)').style('text-anchor', 'end').text(text);
    });
    var y_axis = d3.svg.axis().scale(y_scale).orient('left').innerTickSize(-plot_width).outerTickSize(0).tickPadding(7).ticks(5);
    forest_plot.append('g').attr('class', 'x axis').call(y_axis);
    forest_svg.append('g').attr('transform', "translate(18,".concat(plot_margin.top + plot_height / 2, ")")).append('text').attr('transform', 'rotate(-90)').style('text-anchor', 'middle').text('Odds Ratio (95% CI)');
};

var add_weights_button = function add_weights_button(weights_fname, label) {
    var str = "<span class=\"mx-1\"><a href=\"".concat(weights_fname, "\" class=\"btn btn-primary\">Download weights for ").concat(label, "</a></span>");
    var $str = $(str);
    $('#weights').append($str);
};

window.handle_data = handle_data; // handle_data(window.jsvars.prs_json);