From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 17:56:58 +0000
Subject: [PATCH 0/3] video/fbdev/au1100fb: Adjustments for au1100fb_drv_probe()
Message-Id: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 18:53:21 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
  Improve a size determination
  Delete an unnecessary variable initialisation

 drivers/video/fbdev/au1100fb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.15.0

