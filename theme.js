// Copyright (C) 2015, Radmon.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

require('./less/theme.less');

if (typeof jQuery === 'undefined') {
  throw new Error('jQuery is required.');
}

require('./coffee/collapse.coffee')(jQuery);
require('./coffee/dropdown.coffee')(jQuery);
require('./coffee/toast.coffee')(jQuery);
