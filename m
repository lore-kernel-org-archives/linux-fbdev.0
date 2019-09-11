From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 11 Sep 2019 23:34:10 +0000
Subject: [PATCH] video: hyperv_fb: Add the support of hibernation
Message-Id: <1568244833-66476-1-git-send-email-decui@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>

This patch depends on the vmbus side change of the definition of
struct hv_driver.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

I request this patch should go through Sasha's tree rather than the
fbdev tree.

 drivers/video/fbdev/hyperv_fb.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 2dcb7c5..fe4731f 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -34,6 +34,7 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/efi.h>
+#include <linux/console.h>
 
 #include <linux/hyperv.h>
 
@@ -211,6 +212,7 @@ struct hvfb_par {
 
 	struct delayed_work dwork;
 	bool update;
+	bool update_saved; /* The value of 'update' before hibernation */
 
 	u32 pseudo_palette[16];
 	u8 init_buf[MAX_VMBUS_PKT_SIZE];
@@ -878,6 +880,61 @@ static int hvfb_remove(struct hv_device *hdev)
 	return 0;
 }
 
+static int hvfb_suspend(struct hv_device *hdev)
+{
+	struct fb_info *info = hv_get_drvdata(hdev);
+	struct hvfb_par *par = info->par;
+
+	console_lock();
+
+	/* 1 means do suspend */
+	fb_set_suspend(info, 1);
+
+	cancel_delayed_work_sync(&par->dwork);
+
+	par->update_saved = par->update;
+	par->update = false;
+	par->fb_ready = false;
+
+	vmbus_close(hdev->channel);
+
+	console_unlock();
+
+	return 0;
+}
+
+static int hvfb_resume(struct hv_device *hdev)
+{
+	struct fb_info *info = hv_get_drvdata(hdev);
+	struct hvfb_par *par = info->par;
+	int ret;
+
+	console_lock();
+
+	ret = synthvid_connect_vsp(hdev);
+	if (ret != 0)
+		goto out;
+
+	ret = synthvid_send_config(hdev);
+	if (ret != 0) {
+		vmbus_close(hdev->channel);
+		goto out;
+	}
+
+	par->fb_ready = true;
+	par->update = par->update_saved;
+
+	schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
+
+	/* 0 means do resume */
+	fb_set_suspend(info, 0);
+
+out:
+	console_unlock();
+
+	return ret;
+}
+
 
 static const struct pci_device_id pci_stub_id_table[] = {
 	{
@@ -901,6 +958,8 @@ static int hvfb_remove(struct hv_device *hdev)
 	.id_table = id_table,
 	.probe = hvfb_probe,
 	.remove = hvfb_remove,
+	.suspend = hvfb_suspend,
+	.resume = hvfb_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
1.8.3.1
