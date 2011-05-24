From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Tue, 24 May 2011 20:32:21 +0000
Subject: [Patch 2/2 resend] Prevent vga16fb from accessing hw after it was
Message-Id: <20110524223221.741ffbc0@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Since fb_info is refcounted it can successfully remain open while
being unregistered (though not freed).

Prevent the following sequence to corrupt modify hardware state
behind back of native driver that took over control of hardware:
- vga16fb registered
+ open /dev/fb0 (vga16fb)
- load native driver
  - unregisters conflicting vga16fb
  - configures GPU with nouveaufb and more
  - fbcon takes over
+ close /dev/fb0
  + vga16fb resets hw to vgacon mode (in fbops.fb_release)


Add a new callback fb_unregistered to struct fbops to be called
at end of unregister_framebuffer() so interested drivers can
get know their fb was unregistered (previously they would know
through fb_destroy callback but now that callback may happen
way later)

Prevent such hardware access by setting a flag with new fb_unregistered
callback and checking it when vga16fb framebuffer is last closed and
skipping vga state restore in case it's not registered anymore.

CC: stable@kernel.org
Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
Resend as my MUA decided to take wrong source address...

This should also go into 2.6.39 stable as it didn't make it into 2.6.39
with the rest of fb_info refcounting work.

This comes from
  [2.6.39-rc2, framebuffer] use after free oops
     ...
       [PATCH 0/2] fbcon sanity
thread
---
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 5aac00e..bd9f93b 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1661,6 +1661,11 @@ static int do_unregister_framebuffer(struct fb_info =
*fb_info)
 	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 	event.info =3D fb_info;
 	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
+	if (fb_info->fbops->fb_unregistered) {
+		mutex_lock(&fb_info->lock);
+		fb_info->fbops->fb_unregistered(fb_info);
+		mutex_unlock(&fb_info->lock);
+	}
=20
 	/* this may free fb info */
 	put_fb_info(fb_info);
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 53b2c5a..dad96e1 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -59,7 +59,7 @@ struct vga16fb_par {
 	struct vgastate state;
 	unsigned int ref_count;
 	int palette_blanked, vesa_blanked, mode, isVGA;
-	u8 misc, pel_msk, vss, clkdiv;
+	u8 misc, pel_msk, vss, clkdiv, unregistered;
 	u8 crtc[VGA_CRT_C];
 };
=20
@@ -302,7 +302,7 @@ static int vga16fb_release(struct fb_info *info, int us=
er)
 	if (!par->ref_count)
 		return -EINVAL;
=20
-	if (par->ref_count =3D 1)
+	if (par->ref_count =3D 1 && !par->unregistered)
 		restore_vga(&par->state);
 	par->ref_count--;
=20
@@ -1271,19 +1271,26 @@ static void vga16fb_destroy(struct fb_info *info)
 	framebuffer_release(info);
 }
=20
+static void vga16fb_unregistered(struct fb_info *info)
+{
+	struct vga16fb_par *par =3D info->par;
+	par->unregistered =3D 1;
+}
+
 static struct fb_ops vga16fb_ops =3D {
-	.owner		=3D THIS_MODULE,
-	.fb_open        =3D vga16fb_open,
-	.fb_release     =3D vga16fb_release,
-	.fb_destroy	=3D vga16fb_destroy,
-	.fb_check_var	=3D vga16fb_check_var,
-	.fb_set_par	=3D vga16fb_set_par,
-	.fb_setcolreg 	=3D vga16fb_setcolreg,
-	.fb_pan_display =3D vga16fb_pan_display,
-	.fb_blank 	=3D vga16fb_blank,
-	.fb_fillrect	=3D vga16fb_fillrect,
-	.fb_copyarea	=3D vga16fb_copyarea,
-	.fb_imageblit	=3D vga16fb_imageblit,
+	.owner		 =3D THIS_MODULE,
+	.fb_open         =3D vga16fb_open,
+	.fb_release      =3D vga16fb_release,
+	.fb_destroy	 =3D vga16fb_destroy,
+	.fb_unregistered =3D vga16fb_unregistered,
+	.fb_check_var	 =3D vga16fb_check_var,
+	.fb_set_par	 =3D vga16fb_set_par,
+	.fb_setcolreg	 =3D vga16fb_setcolreg,
+	.fb_pan_display  =3D vga16fb_pan_display,
+	.fb_blank	 =3D vga16fb_blank,
+	.fb_fillrect	 =3D vga16fb_fillrect,
+	.fb_copyarea	 =3D vga16fb_copyarea,
+	.fb_imageblit	 =3D vga16fb_imageblit,
 };
=20
 #ifndef MODULE
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 6a82748..22a8796 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -685,6 +685,9 @@ struct fb_ops {
 	void (*fb_get_caps)(struct fb_info *info, struct fb_blit_caps *caps,
 			    struct fb_var_screeninfo *var);
=20
+	/* teardown hardware for this framebuffer (another driver may get
+	 * ownership of hardware after this returns) */
+	void (*fb_unregistered)(struct fb_info *info);
 	/* teardown any resources to do with this framebuffer */
 	void (*fb_destroy)(struct fb_info *info);
=20
