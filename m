From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:48:14 +0000
Subject: [PATCH 0/4] video-UDLFB: Adjustments for five function implementations
Message-Id: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 21:45:54 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in two functions
  Return an error code only as a constant in dlfb_realloc_framebuffer()
  Improve a size determination in dlfb_alloc_urb_list()
  Delete an unnecessary return statement in two functions

 drivers/video/fbdev/udlfb.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

-- 
2.15.0

