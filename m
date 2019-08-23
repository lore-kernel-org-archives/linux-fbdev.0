From: Peter Rosin <peda@axentia.se>
Date: Fri, 23 Aug 2019 08:47:33 +0000
Subject: [PATCH 0/2] Add possibility to specify the number of displayed logos
Message-Id: <20190823084725.4271-1-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Hi!

The first patch fixes the fact that there are two items numbered "4" in
the list of fbcon options. This bug is a teenager...

The second patch extends that list with a new option that allows the
user to display any number of logos (that fits on the screen). I need it
to limit the display to only one logo instead of one for each CPU core.

Cheers,
Peter

Peter Rosin (2):
  fbdev: fix numbering of fbcon options
  fbdev: fbmem: allow overriding the number of bootup logos

 Documentation/fb/fbcon.rst       | 13 +++++++++----
 drivers/video/fbdev/core/fbcon.c |  7 +++++++
 drivers/video/fbdev/core/fbmem.c |  5 ++++-
 include/linux/fb.h               |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.11.0
