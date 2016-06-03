# Copyright (C) 2015, Radmon.
# Use of this source code is governed by the MIT license that can be
# found in the LICENSE file.

module.exports = ($) ->
  'use strict'

  target = '.toast'

  class Toast
    @TOAST_DURATION: 5000
    @FADING_DURATION: 3000

    constructor: (element) ->
      @element = element
      @element
      .on 'mouseenter', =>
        @restore()
      .on 'mouseleave', =>
        @countdown()

    show: () ->
      return if @element.hasClass 'open'
      @element.addClass 'open'
      @countdown()

    dismiss: () ->
      @element
      .removeClass 'open'
      .removeClass 'fading'

    countdown: () ->
      window.clearTimeout @timer
      @timer = window.setTimeout =>
        @decline()
      , @constructor.TOAST_DURATION

    decline: () ->
      @element.addClass 'fading'
      @timer = window.setTimeout =>
        @dismiss()
      , @constructor.FADING_DURATION

    restore: () ->
      @element.removeClass 'fading'
      window.clearTimeout @timer

  $.fn.toast = (option) ->
    key = 'tm.toast'
    this.each ->
      element = $(this)
      control = element.data key
      if not control
        control = new Toast element
        element.data key, control
      control[option].call control if typeof option == 'string'

  FindTarget = (trigger) ->
    guide = trigger.attr 'data-target'
    if guide then $(guide) else trigger.next target

  $(document)
  .on 'click touch', '[data-trigger="toast"]', (e) ->
    e.preventDefault()
    FindTarget $(this)
    .toast 'show'
