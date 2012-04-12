From: David Brown <davidb@codeaurora.org>
Date: Thu, 12 Apr 2012 18:45:33 +0000
Subject: [PATCH 1/2] video: msm: Fix section mismatches in mddi.c
Message-Id: <1334256334-8234-1-git-send-email-davidb@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The change
    commit 461cbe77d0a4f887c33a3a95ea68a7daf23b4302
    Author: Gregory Bean <gbean@codeaurora.org>
    Date:   Wed Jul 28 10:22:13 2010 -0700

        video: msm: Fix section mismatch in mddi.c.

fixes a section mismatch between the board file and the driver's probe
function, however, it misses the additional mismatches between the
probe function and some routines it calls.  Fix these up as well.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/video/msm/mddi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/msm/mddi.c b/drivers/video/msm/mddi.c
index 4527cbf..b061d70 100644
--- a/drivers/video/msm/mddi.c
+++ b/drivers/video/msm/mddi.c
@@ -420,7 +420,7 @@ static void mddi_resume(struct msm_mddi_client_data *cdata)
 	mddi_set_auto_hibernate(&mddi->client_data, 1);
 }
 
-static int __init mddi_get_client_caps(struct mddi_info *mddi)
+static int __devinit mddi_get_client_caps(struct mddi_info *mddi)
 {
 	int i, j;
 
@@ -622,9 +622,9 @@ uint32_t mddi_remote_read(struct msm_mddi_client_data *cdata, uint32_t reg)
 
 static struct mddi_info mddi_info[2];
 
-static int __init mddi_clk_setup(struct platform_device *pdev,
-				 struct mddi_info *mddi,
-				 unsigned long clk_rate)
+static int __devinit mddi_clk_setup(struct platform_device *pdev,
+				    struct mddi_info *mddi,
+				    unsigned long clk_rate)
 {
 	int ret;
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

