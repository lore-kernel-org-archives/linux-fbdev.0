From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 21:20:13 +0000
Subject: [PATCH 0/5] Radeon backlight: Adjustments for radeonfb_bl_init()
Message-Id: <93c99f89-2d97-0e95-fe57-7b7a0824e864@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 22:14:04 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Delete an error message for a failed memory allocation
  Improve a size determination
  Delete an unnecessary return statement
  Return directly after a failed kmalloc()
  Delete a jump target

 drivers/video/fbdev/aty/radeon_backlight.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

-- 
2.15.0

