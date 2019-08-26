From: Peter Rosin <peda@axentia.se>
Date: Mon, 26 Aug 2019 19:58:49 +0000
Subject: [PATCH v2 0/3] Add possibility to specify the number of displayed logos
Message-Id: <20190826195740.29415-1-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>

Hi!

The first patch fixes the fact that there are two items numbered "4" in
the list of fbcon options. This bug is a teenager...

The second patch extends that list with a new option that allows the
user to display any number of logos (that fits on the screen). I need it
to limit the display to only one logo instead of one for each CPU core.

Changes since v1

- do not needlessly export fb_logo_count [Matthew Wilcox]
- added patch 3/3, which removes the export of fb_center_logo

Cheers,
Peter

Peter Rosin (3):
  fbdev: fix numbering of fbcon options
  fbdev: fbmem: allow overriding the number of bootup logos
  fbdev: fbmem: avoid exporting fb_center_logo

 Documentation/fb/fbcon.rst       | 13 +++++++++----
 drivers/video/fbdev/core/fbcon.c |  7 +++++++
 drivers/video/fbdev/core/fbmem.c |  5 +++--
 include/linux/fb.h               |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.11.0
