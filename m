From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 20:42:57 +0000
Subject: [PATCH 0/5] video-SMSC UFX: Adjustments for five function implementations
Message-Id: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 21:38:42 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Delete an error message for a failed memory allocation in two functions
  Less checks in ufx_usb_probe() after error detection
  Return an error code only as a constant in ufx_realloc_framebuffer()
  Improve a size determination in two functions
  Adjust three checks for null pointers

 drivers/video/fbdev/smscufx.c | 80 ++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

-- 
2.15.0


