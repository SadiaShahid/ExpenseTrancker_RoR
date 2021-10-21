import { Application } from "stimulus"
import CheckboxSelectAll from "stimulus-checkbox-select-all"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
application.register("checkbox-select-all", CheckboxSelectAll)
const context = require.context(".", true, /\.js$/)
application.load(definitionsFromContext(context))