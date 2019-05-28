From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:32 +0000
Subject: [PATCH 01/33] dummycon: Sprinkle locking checks
Message-Id: <20190528090304.9388-2-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

As part of trying to understand the locking (or lack thereof) in the
fbcon/vt/fbdev maze, annotate everything.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 drivers/video/console/dummycon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index ff886e99104b..2a0d0bda7faa 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -34,6 +34,8 @@ static bool dummycon_putc_called;
 
 void dummycon_register_output_notifier(struct notifier_block *nb)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	raw_notifier_chain_register(&dummycon_output_nh, nb);
 
 	if (dummycon_putc_called)
@@ -42,11 +44,15 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 
 void dummycon_unregister_output_notifier(struct notifier_block *nb)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
 
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	dummycon_putc_called = true;
 	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
 }
-- 
2.20.1
