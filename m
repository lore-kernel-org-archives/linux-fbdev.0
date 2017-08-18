From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Aug 2017 17:41:16 +0000
Subject: Re: [PATCH] video: fbdev: constify copied structures
Message-Id: <7127868.v7Fj1TocLv@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170802093008epcas2p48a98827ec2c27fbd6f6de8913d47c02b@epcas2p4.samsung.com>
 <1501664679-10356-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1501664679-10356-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi,

On Wednesday, August 02, 2017 11:04:39 AM Julia Lawall wrote:
> Make const some structures that are only copied into other structures.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

fb_fix_screeninfo and fb_var_screeninfo structures were already
const-ified by commit 40445365a43f ("video: xilinxfb: constify
fb_fix_screeninfo and fb_var_screeninfo structures") in my -next
tree (git://github.com/bzolnier/linux.git fbdev-for-next) so
I just applied xilinx_fb_default_pdata part (patch included below
for reference).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] video: fbdev: xilinxfb: constify copied structure

Make const xilinx_fb_default_pdata structure that is only copied into
other structure.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>,
[b.zolnierkie: split from a bigger patch]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/xilinxfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/xilinxfb.c
=================================--- a/drivers/video/fbdev/xilinxfb.c	2017-08-18 19:34:11.383004874 +0200
+++ b/drivers/video/fbdev/xilinxfb.c	2017-08-18 19:34:35.383005478 +0200
@@ -100,7 +100,7 @@ struct xilinxfb_platform_data {
 /*
  * Default xilinxfb configuration
  */
-static struct xilinxfb_platform_data xilinx_fb_default_pdata = {
+static const struct xilinxfb_platform_data xilinx_fb_default_pdata = {
 	.xres = 640,
 	.yres = 480,
 	.xvirt = 1024,

