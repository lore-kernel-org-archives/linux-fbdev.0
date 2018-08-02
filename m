From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 02 Aug 2018 11:28:41 +0000
Subject: [PATCH fix for 4.19 3/3] dummycon: Stop exporting dummycon_[un]register_output_notifier
Message-Id: <20180802112841.27679-4-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180802112841.27679-1-hdegoede@redhat.com>
In-Reply-To: <20180802112841.27679-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Now that we only allow FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER when
fbdev+fbcon are builtin exporting these is no longer necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/dummycon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 0254251fdd79..45ad925ad5f8 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -38,13 +38,11 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 	if (dummycon_putc_called)
 		nb->notifier_call(nb, 0, NULL);
 }
-EXPORT_SYMBOL_GPL(dummycon_register_output_notifier);
 
 void dummycon_unregister_output_notifier(struct notifier_block *nb)
 {
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
-EXPORT_SYMBOL_GPL(dummycon_unregister_output_notifier);
 
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
-- 
2.18.0

