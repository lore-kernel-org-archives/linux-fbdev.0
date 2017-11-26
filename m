From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 20:41:43 +0000
Subject: [PATCH 0/2] video/fbdev/mmp: Adjustments for two function implementations
Message-Id: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 21:38:42 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in path_init()

 drivers/video/fbdev/mmp/fb/mmpfb.c    | 5 ++---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 8 +++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.15.0

