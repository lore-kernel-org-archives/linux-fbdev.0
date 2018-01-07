From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 13:33:36 +0000
Subject: [PATCH v2 0/2] video-UDLFB: Adjustments for dlfb_realloc_framebuffer()
Message-Id: <25aee051-12fb-de5f-c806-f419fa4c0ef1@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124204825epcas1p41626d598b6e437dfb4c6b648e3730cc1@epcas1p4.samsung.com>
 <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
 <1768474.zA76iyE2Y1@amdc3058>
In-Reply-To: <1768474.zA76iyE2Y1@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 14:24:34 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return an error code only as a constant
  Delete an error message for a failed memory allocation

---

v2:
Rebased on Linux next-20180105.

 drivers/video/fbdev/udlfb.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.15.1

