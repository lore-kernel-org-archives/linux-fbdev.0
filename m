From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 25 Aug 2015 13:45:14 +0000
Subject: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
In-Reply-To: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

When the usual fbcon legacy options are enabled we have
->register_framebuffer
  ->fb notifier chain calls into fbcon
    ->fbcon sets up console on new fbi
      ->fbi->set_par
        ->drm_fb_helper_set_par exercises full kms api

And because of locking inversion hilarity all of register_framebuffer
is done with the console lock held. Which means that the first time on
driver load we exercise _all_ the kms code (all probe paths and
modeset paths for everything connected) is under the console lock.
That means if anything goes belly-up in that big pile of code nothing
ever reaches logfiles (and the machine is dead).

Usual tactic to debug that is to temporarily remove those console_lock
calls to be able to capture backtraces. I'm fed up writing this patch
and recompiling kernels. Hence this patch here to add an unsafe,
kernel-taining option to do this at runtime.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/core/fbmem.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0705d8883ede..4e73b6f6b1c0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1608,6 +1608,11 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 	return 0;
 }
 
+static bool lockless_register_fb;
+module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
+MODULE_PARM_DESC(lockless_register_fb,
+	"Lockless framebuffer registration for debugging [default=off]");
+
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
 	int i, ret;
@@ -1675,15 +1680,18 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	registered_fb[i] = fb_info;
 
 	event.info = fb_info;
-	console_lock();
+	if (!lockless_register_fb)
+		console_lock();
 	if (!lock_fb_info(fb_info)) {
-		console_unlock();
+		if (!lockless_register_fb)
+			console_unlock();
 		return -ENODEV;
 	}
 
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
 	unlock_fb_info(fb_info);
-	console_unlock();
+	if (!lockless_register_fb)
+		console_unlock();
 	return 0;
 }
 
-- 
1.8.3.1

