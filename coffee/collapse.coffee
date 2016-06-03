# Copyright (C) 2015, Radmon.
# Use of this source code is governed by the MIT license that can be
# found in the LICENSE file.

module.exports = ($) ->
  'use strict'

  target = '.collapse'

  class Collapse
    constructor: (element) ->
      @element = element

    toggle: () ->
      @element.toggleClass 'open'

  $.fn.collapse = (option) ->
    key = 'tm.collapse'
    this.each ->
      element = $(this)
      control = element.data key
      if not control
        control = new Collapse element
        element.data key, control
      control[option].call control if typeof option == 'string'

  FindTarget = (trigger) ->
    guide = trigger.attr 'data-target'
    if guide then $(guide) else trigger.next target

  $(document)
  .on 'click touch', '[data-trigger="collapse"]', (e) ->
    e.preventDefault()
    FindTarget $(this)
    .collapse 'toggle'
