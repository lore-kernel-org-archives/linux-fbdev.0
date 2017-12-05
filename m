From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 05 Dec 2017 17:10:26 +0000
Subject: [PATCH 0/2] video/fbdev/amba-clcd: Adjustments for clcdfb_probe()
Message-Id: <107ed35f-1775-14e0-a7b5-20e7ee02ac16@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Russell King <linux@armlinux.org.uk>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Dec 2017 18:07:06 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/video/fbdev/amba-clcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.15.1

