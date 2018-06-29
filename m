From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 29 Jun 2018 09:36:27 +0000
Subject: [PATCH] console: dummycon: export dummycon_[un]register_output_notifier
Message-Id: <20180629093627.14620-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Stephen Rothwell <sfr@canb.auug.org.au>

Export dummycon_[un]register_output_notifier, the fbcon code needs this
and may be build as a module.

Fixes: 83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/console/dummycon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 45ad925ad5f8..0254251fdd79 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -38,11 +38,13 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 	if (dummycon_putc_called)
 		nb->notifier_call(nb, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(dummycon_register_output_notifier);
 
 void dummycon_unregister_output_notifier(struct notifier_block *nb)
 {
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
+EXPORT_SYMBOL_GPL(dummycon_unregister_output_notifier);
 
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
-- 
2.17.1

