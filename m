From: Dexuan Cui <decui@microsoft.com>
Date: Mon, 06 Jan 2020 22:41:51 +0000
Subject: [PATCH][RESEND] video: hyperv_fb: Fix hibernation for the deferred IO feature
Message-Id: <1578350511-130150-1-git-send-email-decui@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, b.zolnierkie@samsung.com, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com, Alexander.Levin@microsoft.co
Cc: Dexuan Cui <decui@microsoft.com>, weh@microsoft.com

fb_deferred_io_work() can access the vmbus ringbuffer by calling
fbdefio->deferred_io() -> synthvid_deferred_io() -> synthvid_update().

Because the vmbus ringbuffer is inaccessible between hvfb_suspend()
and hvfb_resume(), we must cancel info->deferred_work before calling
vmbus_close() and then reschedule it after we reopen the channel
in hvfb_resume().

Fixes: a4ddb11d297e ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
Fixes: 824946a8b6fb ("video: hyperv_fb: Add the support of hibernation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Wei Hu <weh@microsoft.com>
---

This is a RESEND of https://lkml.org/lkml/2019/11/20/73 .

The only change is the addition of Wei's Review-ed-by.

Please review.

If it looks good, Sasha Levin, can you please pick it up via the
hyperv/linux.git tree, as you did last time for this driver?


 drivers/video/fbdev/hyperv_fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 4cd27e5172a1..08bc0dfb5ce7 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1194,6 +1194,7 @@ static int hvfb_suspend(struct hv_device *hdev)
 	fb_set_suspend(info, 1);
 
 	cancel_delayed_work_sync(&par->dwork);
+	cancel_delayed_work_sync(&info->deferred_work);
 
 	par->update_saved = par->update;
 	par->update = false;
@@ -1227,6 +1228,7 @@ static int hvfb_resume(struct hv_device *hdev)
 	par->fb_ready = true;
 	par->update = par->update_saved;
 
+	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
 	schedule_delayed_work(&par->dwork, HVFB_UPDATE_DELAY);
 
 	/* 0 means do resume */
-- 
2.19.1
