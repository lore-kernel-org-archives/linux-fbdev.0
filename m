From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 20 Jun 2017 06:30:14 +0000
Subject: [PATCH] video: fbdev: fsl-diu-fb: constify mfb_template and fsl_diu_match.
Message-Id: <9c07b512d764aa87a17dc871b9b2feaf050ff8c5.1497939324.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: timur@tabi.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   2469	   1552	     24	   4045	    fcd	drivers/video/fbdev/fsl-diu-fb.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   3821	    200	     24	   4045	    fcd	drivers/video/fbdev/fsl-diu-fb.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/fsl-diu-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index ca3d6b3..25abbcf 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -388,7 +388,7 @@ struct fsl_diu_data {
 /* Determine the DMA address of a member of the fsl_diu_data structure */
 #define DMA_ADDR(p, f) ((p)->dma_addr + offsetof(struct fsl_diu_data, f))
 
-static struct mfb_info mfb_template[] = {
+static const struct mfb_info mfb_template[] = {
 	{
 		.index = PLANE0,
 		.id = "Panel0",
@@ -1868,7 +1868,7 @@ static int __init fsl_diu_setup(char *options)
 }
 #endif
 
-static struct of_device_id fsl_diu_match[] = {
+static const struct of_device_id fsl_diu_match[] = {
 #ifdef CONFIG_PPC_MPC512x
 	{
 		.compatible = "fsl,mpc5121-diu",
-- 
1.9.1

