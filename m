From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 16:00:49 +0000
Subject: [PATCH v3 0/3] video-SMSC UFX: Adjustments for two function implementations
Message-Id: <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
 <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
 <1736749.UIs06O4xc5@amdc3058>
In-Reply-To: <1736749.UIs06O4xc5@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 16:54:32 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Less checks in ufx_usb_probe() after error detection
  Return an error code only as a constant
    in ufx_realloc_framebuffer()
  Delete an error message for a failed memory allocation
    in ufx_realloc_framebuffer()

---

v3:
Rebased on Linux next-20180105.

 drivers/video/fbdev/smscufx.c | 59 ++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

-- 
2.15.1

