From: Peter Rosin <peda@axentia.se>
Date: Mon, 26 Nov 2018 21:57:36 +0000
Subject: [PATCH 0/2] add config option to center the bootup logo
Message-Id: <20181126215725.2548-1-peda@axentia.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi!

I'm using these patches to get early display output at the center of
the screen. Maybe someone else will also find that useful?

Cheers,
Peter

Peter Rosin (2):
  fbdev: fbmem: make fb_show_logo_line return the end instead of the
    height
  fbdev: fbmem: add config option to center the bootup logo

 drivers/video/fbdev/core/fbmem.c | 31 +++++++++++++++++++++++++++----
 drivers/video/logo/Kconfig       |  9 +++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.11.0
