# Copyright (C) 2015, Radmon.
# Use of this source code is governed by the MIT license that can be
# found in the LICENSE file.

module.exports = ($) ->
  'use strict'

  target = '.dropdown'

  class Dropdown
    constructor: (element) ->
      @element = element

    open: () ->
      if @element.hasClass 'open'
        @element
        .find target
        .addBack()
        .removeClass 'open'
      else
        $(target).dropdown 'close'
        @element.addClass 'open'

    opensub: () ->
      if @element.hasClass 'open'
        @element
        .find target
        .addBack()
        .removeClass 'open'
      else
        @element
        .parent()
        .siblings()
        .find target
        .removeClass 'open'
        @element.addClass 'open'

    close: () ->
      @element.removeClass 'open'

  $.fn.dropdown = (option) ->
    key = 'tm.dropdown'
    this.each ->
      element = $(this)
      control = element.data key
      if not control
        control = new Dropdown element
        element.data key, control
      control[option].call control if typeof option == 'string'

  FindTarget = (trigger) ->
    guide = trigger.attr 'data-target'
    if guide then $(guide) else trigger.next target

  $(document)
  .on 'click touch', '[data-trigger="dropdown"]', (e) ->
    e.preventDefault()
    e.stopPropagation()
    FindTarget $(this)
    .dropdown 'open'
  .on 'click touch', "li:has(#{target})>a", (e) ->
    e.preventDefault()
    e.stopPropagation()
    $(this)
    .next target
    .dropdown 'opensub'
  .on 'click touch', (e) ->
    $(target).dropdown 'close'
