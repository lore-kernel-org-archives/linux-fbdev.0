From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 29 Apr 2010 23:49:34 +0000
Subject: [PATCH 1/5] fsl-diu-fb: fix issue with re-enabling DIU area descriptor on MPC5121
Message-Id: <1272584978-19063-2-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com

On MPC5121 re-configuring the DIU area descriptor by writing
new descriptor address doesn't work. As a result, DIU continues
to display using old area descriptor even if the new one has
been set.

Disabling the DIU before setting the new descriptor and
subsequently enabling it fixes the problem.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/fsl-diu-fb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 994358a..ee15a99 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -329,8 +329,11 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
 		case 0:				/* plane 0 */
-			if (hw->desc[0] != ad->paddr)
+			if (hw->desc[0] != ad->paddr) {
+				out_be32(&dr.diu_reg->diu_mode, MFB_MODE0);
 				out_be32(&hw->desc[0], ad->paddr);
+				out_be32(&dr.diu_reg->diu_mode, MFB_MODE1);
+			}
 			break;
 		case 1:				/* plane 1 AOI 0 */
 			cmfbi = machine_data->fsl_diu_info[2]->par;
-- 
1.6.3.3

