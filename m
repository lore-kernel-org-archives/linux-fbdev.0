From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 08 Mar 2015 12:43:26 +0000
Subject: [PATCH 4/4] staging: sm750fb: fix undeclared function
Message-Id: <1425817886-14387-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

kbuild test robot reported that for microblaze-allyesconfig
chan_to_field() and lynxfb_ops_set_par() were not defined. These two
functions were defined under CONFIG_PM, so for any archtecture if
CONFIG_PM is not defined we will have this error.
while moving the lynxfb_suspend() function some very obvious
checkpatch errors were taken care of.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 109 +++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 753869e..8a78ea5 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -303,62 +303,6 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
     return ret;
 }
 
-
-
-
-#ifdef CONFIG_PM
-static int lynxfb_suspend(struct pci_dev * pdev,pm_message_t mesg)
-{
-	struct fb_info * info;
-	struct lynx_share * share;
-	int ret;
-	
-
-	if(mesg.event = pdev->dev.power.power_state.event)
-		return 0;
-
-	ret = 0;
-	share = pci_get_drvdata(pdev);
-	switch (mesg.event) {
-	case PM_EVENT_FREEZE:
-	case PM_EVENT_PRETHAW:
-		pdev->dev.power.power_state = mesg;
-		return 0;
-	}
-
-	console_lock();
-	if (mesg.event & PM_EVENT_SLEEP) {
-		info = share->fbinfo[0];
-		if(info)
-			fb_set_suspend(info, 1);/* 1 means do suspend*/
-
-		info = share->fbinfo[1];
-		if(info)
-			fb_set_suspend(info, 1);/* 1 means do suspend*/
-
-		ret = pci_save_state(pdev);
-		if(ret){
-			pr_err("error:%d occured in pci_save_state\n",ret);
-			return ret;
-		}
-
-		/* set chip to sleep mode	*/
-		if(share->suspend)
-			(*share->suspend)(share);
-
-		pci_disable_device(pdev);
-		ret = pci_set_power_state(pdev,pci_choose_state(pdev,mesg));
-		if(ret){
-			pr_err("error:%d occured in pci_set_power_state\n",ret);
-			return ret;
-		}
-	}
-
-	pdev->dev.power.power_state = mesg;
-	console_unlock();
-	return ret;
-}
-
 static int lynxfb_ops_set_par(struct fb_info * info)
 {
 	struct lynxfb_par * par;
@@ -369,7 +313,6 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 	struct fb_fix_screeninfo * fix;
 	int ret;
 	unsigned int line_length;
-	
 
 	if(!info)
 		return -EINVAL;
@@ -441,6 +384,7 @@ static int lynxfb_ops_set_par(struct fb_info * info)
 		ret = output->proc_setMode(output,var,fix);
 	return ret;
 }
+
 static inline unsigned int chan_to_field(unsigned int chan,struct fb_bitfield * bf)
 {
 	chan &= 0xffff;
@@ -448,6 +392,57 @@ static inline unsigned int chan_to_field(unsigned int chan,struct fb_bitfield *
 	return chan << bf->offset;
 }
 
+#ifdef CONFIG_PM
+static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct fb_info *info;
+	struct lynx_share *share;
+	int ret;
+
+	if (mesg.event = pdev->dev.power.power_state.event)
+		return 0;
+
+	ret = 0;
+	share = pci_get_drvdata(pdev);
+	switch (mesg.event) {
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_PRETHAW:
+		pdev->dev.power.power_state = mesg;
+		return 0;
+	}
+
+	console_lock();
+	if (mesg.event & PM_EVENT_SLEEP) {
+		info = share->fbinfo[0];
+		if (info)
+			fb_set_suspend(info, 1);/* 1 means do suspend*/
+
+		info = share->fbinfo[1];
+		if (info)
+			fb_set_suspend(info, 1);/* 1 means do suspend*/
+
+		ret = pci_save_state(pdev);
+		if (ret) {
+			pr_err("error:%d occurred in pci_save_state\n", ret);
+			return ret;
+		}
+
+		/* set chip to sleep mode	*/
+		if (share->suspend)
+			(*share->suspend)(share);
+
+		pci_disable_device(pdev);
+		ret = pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
+		if (ret) {
+			pr_err("error:%d occurred in pci_set_power_state\n", ret);
+			return ret;
+		}
+	}
+
+	pdev->dev.power.power_state = mesg;
+	console_unlock();
+	return ret;
+}
 
 static int lynxfb_resume(struct pci_dev* pdev)
 {
-- 
1.8.1.2

