From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:40 +0000
Subject: [PATCH 09/33] fbcon: Remove fbcon_has_exited
Message-Id: <20190528090304.9388-10-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: LKML <linux-kernel@vger.kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Daniel Thompson <daniel.thompson@linaro.org>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Konstantin Khorenko <khorenko@virtuozzo.com>

This is unused code since

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

when fbcon was made a compile-time static dependency of fbdev. We
can't exit fbcon anymore without exiting fbdev first, which only works
if all fbdev drivers have unloaded already. Hence this is all dead
code.

v2: I missed that fbcon_exit is also called from con_deinit stuff, and
there fbcon_has_exited prevents double-cleanup. But we can fix that
by properly resetting con2fb_map[] to all -1, which is used everywhere
else to indicate "no fb_info allocate to this console". With that
change the double-cleanup (which resulted in a module refcount underflow,
among other things) is prevented.

Aside: con2fb_map is a signed char, so don't register more than 128 fb_info
or hilarity will ensue.

v3: CI showed me that I still didn't fully understand what's going on
here. The leaked references in con2fb_map have been used upon
rebinding the fb console in fbcon_init. It worked because fbdev
unregistering still cleaned out con2fb_map, and reset it to info_idx.
If the last fbdev driver unregistered, then it also reset info_idx,
and unregistered the fbcon driver.

Imo that's all a bit fragile, so let's keep the con2fb_map reset to
-1, and in fbcon_init pick info_idx if we're starting fresh. That
means unbinding and rebinding will cleanse the mapping, but why are
you doing that if you want to retain the mapping, so should be fine.

Also, I think info_idx =3D -1 is impossible in fbcon_init - we
unregister the fbcon in that case. So catch&warn about that.

v4: Drop unecessary assignment - I forgot to delete the first
assignment of info in fbcon_init.

Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/core/fbcon.c | 41 ++++++--------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fb=
con.c
index 5424051c8e1a..e11bae2787e6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -112,7 +112,6 @@ static int softback_lines;
 static int first_fb_vc;
 static int last_fb_vc =3D MAX_NR_CONSOLES - 1;
 static int fbcon_is_default =3D 1;=20
-static int fbcon_has_exited;
 static int primary_device =3D -1;
 static int fbcon_has_console_bind;
=20
@@ -1050,13 +1049,12 @@ static const char *fbcon_startup(void)
 		info->var.bits_per_pixel);
=20
 	fbcon_add_cursor_timer(info);
-	fbcon_has_exited =3D 0;
 	return display_desc;
 }
=20
 static void fbcon_init(struct vc_data *vc, int init)
 {
-	struct fb_info *info =3D registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info;
 	struct fbcon_ops *ops;
 	struct vc_data **default_mode =3D vc->vc_display_fg;
 	struct vc_data *svc =3D *default_mode;
@@ -1064,9 +1062,13 @@ static void fbcon_init(struct vc_data *vc, int init)
 	int logo =3D 1, new_rows, new_cols, rows, cols, charcnt =3D 256;
 	int cap, ret;
=20
-	if (info_idx =3D -1 || info =3D NULL)
+	if (WARN_ON(info_idx =3D -1))
 	    return;
=20
+	if (con2fb_map[vc->vc_num] =3D -1)
+		con2fb_map[vc->vc_num] =3D info_idx;
+
+	info =3D registered_fb[con2fb_map[vc->vc_num]];
 	cap =3D info->flags;
=20
 	if (logo_shown < 0 && console_loglevel <=3D CONSOLE_LOGLEVEL_QUIET)
@@ -3336,14 +3338,6 @@ static int fbcon_event_notify(struct notifier_block =
*self,
 	struct fb_blit_caps *caps;
 	int idx, ret =3D 0;
=20
-	/*
-	 * ignore all events except driver registration and deregistration
-	 * if fbcon is not active
-	 */
-	if (fbcon_has_exited && !(action =3D FB_EVENT_FB_REGISTERED ||
-				  action =3D FB_EVENT_FB_UNREGISTERED))
-		goto done;
-
 	switch(action) {
 	case FB_EVENT_SUSPEND:
 		fbcon_suspended(info);
@@ -3396,7 +3390,6 @@ static int fbcon_event_notify(struct notifier_block *=
self,
 		fbcon_remap_all(idx);
 		break;
 	}
-done:
 	return ret;
 }
=20
@@ -3443,9 +3436,6 @@ static ssize_t store_rotate(struct device *device,
 	int rotate, idx;
 	char **last =3D NULL;
=20
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx =3D con2fb_map[fg_console];
=20
@@ -3468,9 +3458,6 @@ static ssize_t store_rotate_all(struct device *device,
 	int rotate, idx;
 	char **last =3D NULL;
=20
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx =3D con2fb_map[fg_console];
=20
@@ -3491,9 +3478,6 @@ static ssize_t show_rotate(struct device *device,
 	struct fb_info *info;
 	int rotate =3D 0, idx;
=20
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx =3D con2fb_map[fg_console];
=20
@@ -3514,9 +3498,6 @@ static ssize_t show_cursor_blink(struct device *devic=
e,
 	struct fbcon_ops *ops;
 	int idx, blink =3D -1;
=20
-	if (fbcon_has_exited)
-		return 0;
-
 	console_lock();
 	idx =3D con2fb_map[fg_console];
=20
@@ -3543,9 +3524,6 @@ static ssize_t store_cursor_blink(struct device *devi=
ce,
 	int blink, idx;
 	char **last =3D NULL;
=20
-	if (fbcon_has_exited)
-		return count;
-
 	console_lock();
 	idx =3D con2fb_map[fg_console];
=20
@@ -3668,9 +3646,6 @@ static void fbcon_exit(void)
 	struct fb_info *info;
 	int i, j, mapped;
=20
-	if (fbcon_has_exited)
-		return;
-
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	if (deferred_takeover) {
 		dummycon_unregister_output_notifier(&fbcon_output_nb);
@@ -3695,7 +3670,7 @@ static void fbcon_exit(void)
 		for (j =3D first_fb_vc; j <=3D last_fb_vc; j++) {
 			if (con2fb_map[j] =3D i) {
 				mapped =3D 1;
-				break;
+				con2fb_map[j] =3D -1;
 			}
 		}
=20
@@ -3718,8 +3693,6 @@ static void fbcon_exit(void)
 				info->queue.func =3D NULL;
 		}
 	}
-
-	fbcon_has_exited =3D 1;
 }
=20
 void __init fb_console_init(void)
--=20
2.20.1
