From: <gregkh@linuxfoundation.org>
Date: Thu, 27 Oct 2016 14:39:07 +0000
Subject: patch "tty: vgacon+sisusb, move scrolldelta to a common helper" added to tty-testing
Message-Id: <147757914725110@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    tty: vgacon+sisusb, move scrolldelta to a common helper

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 35cc56f9a30480c8a0cca809cf341614a2144758 Mon Sep 17 00:00:00 2001
From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 3 Oct 2016 11:18:35 +0200
Subject: tty: vgacon+sisusb, move scrolldelta to a common helper

The code is mirrorred in scrolldelta implementations of both vgacon
and sisusb. Let's move the code to a separate helper where we will
perform a common cleanup and further changes.

While we are moving the code, make it linear and save one indentation
level. This is done by returning from the "!lines" then-branch
immediatelly. This allows flushing the else-branch 1 level to the
left, obviously.

Few more new lines and comments were added too.

And do not forget to export the helper function given sisusb can be
built as module.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
Cc: <linux-usb@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c                     | 38 +++++++++++++++++++++++++++++++++
 drivers/usb/misc/sisusbvga/sisusb_con.c | 37 ++------------------------------
 drivers/video/console/vgacon.c          | 27 ++---------------------
 include/linux/vt_kern.h                 |  2 ++
 4 files changed, 44 insertions(+), 60 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a0b7576747cd..2eab714aab67 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4279,6 +4279,44 @@ void vcs_scr_updated(struct vc_data *vc)
 	notify_update(vc);
 }
 
+void vc_scrolldelta_helper(struct vc_data *c, int lines,
+		unsigned int rolled_over, void *base, unsigned int size)
+{
+	unsigned long ubase = (unsigned long)base;
+	int margin = c->vc_size_row * 4;
+	int ul, we, p, st;
+
+	/* Turn scrollback off */
+	if (!lines) {
+		c->vc_visible_origin = c->vc_origin;
+		return;
+	}
+
+	/* Do we have already enough to allow jumping from 0 to the end? */
+	if (rolled_over > (c->vc_scr_end - ubase) + margin) {
+		ul = c->vc_scr_end - ubase;
+		we = rolled_over + c->vc_size_row;
+	} else {
+		ul = 0;
+		we = size;
+	}
+
+	p = (c->vc_visible_origin - ubase - ul + we) % we +
+		lines * c->vc_size_row;
+	st = (c->vc_origin - ubase - ul + we) % we;
+
+	/* Only a little piece would be left? Show all incl. the piece! */
+	if (st < 2 * margin)
+		margin = 0;
+	if (p < margin)
+		p = 0;
+	if (p > st - margin)
+		p = st;
+
+	c->vc_visible_origin = ubase + (p + ul) % we;
+}
+EXPORT_SYMBOL_GPL(vc_scrolldelta_helper);
+
 /*
  *	Visible symbols for modules
  */
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 6331965daa0b..4b5777ec1501 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -686,8 +686,6 @@ static void
 sisusbcon_scrolldelta(struct vc_data *c, int lines)
 {
 	struct sisusb_usb_data *sisusb;
-	int margin = c->vc_size_row * 4;
-	int ul, we, p, st;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
 	if (!sisusb)
@@ -700,39 +698,8 @@ sisusbcon_scrolldelta(struct vc_data *c, int lines)
 		return;
 	}
 
-	if (!lines)		/* Turn scrollback off */
-		c->vc_visible_origin = c->vc_origin;
-	else {
-
-		if (sisusb->con_rolled_over >
-				(c->vc_scr_end - sisusb->scrbuf) + margin) {
-
-			ul = c->vc_scr_end - sisusb->scrbuf;
-			we = sisusb->con_rolled_over + c->vc_size_row;
-
-		} else {
-
-			ul = 0;
-			we = sisusb->scrbuf_size;
-
-		}
-
-		p = (c->vc_visible_origin - sisusb->scrbuf - ul + we) % we +
-				lines * c->vc_size_row;
-
-		st = (c->vc_origin - sisusb->scrbuf - ul + we) % we;
-
-		if (st < 2 * margin)
-			margin = 0;
-
-		if (p < margin)
-			p = 0;
-
-		if (p > st - margin)
-			p = st;
-
-		c->vc_visible_origin = sisusb->scrbuf + (p + ul) % we;
-	}
+	vc_scrolldelta_helper(c, lines, sisusb->con_rolled_over,
+			(void *)sisusb->scrbuf, sisusb->scrbuf_size);
 
 	sisusbcon_set_start_address(sisusb, c);
 
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 4c54a873452e..ede6a5a85ccd 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -332,31 +332,8 @@ static void vgacon_restore_screen(struct vc_data *c)
 
 static void vgacon_scrolldelta(struct vc_data *c, int lines)
 {
-	if (!lines)		/* Turn scrollback off */
-		c->vc_visible_origin = c->vc_origin;
-	else {
-		int margin = c->vc_size_row * 4;
-		int ul, we, p, st;
-
-		if (vga_rolled_over >
-		    (c->vc_scr_end - vga_vram_base) + margin) {
-			ul = c->vc_scr_end - vga_vram_base;
-			we = vga_rolled_over + c->vc_size_row;
-		} else {
-			ul = 0;
-			we = vga_vram_size;
-		}
-		p = (c->vc_visible_origin - vga_vram_base - ul + we) % we +
-		    lines * c->vc_size_row;
-		st = (c->vc_origin - vga_vram_base - ul + we) % we;
-		if (st < 2 * margin)
-			margin = 0;
-		if (p < margin)
-			p = 0;
-		if (p > st - margin)
-			p = st;
-		c->vc_visible_origin = vga_vram_base + (p + ul) % we;
-	}
+	vc_scrolldelta_helper(c, lines, vga_rolled_over, (void *)vga_vram_base,
+			vga_vram_size);
 	vga_set_mem_top(c);
 }
 #endif /* CONFIG_VGACON_SOFT_SCROLLBACK */
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 6abd24f258bc..833fdd4794a0 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -191,5 +191,7 @@ extern void vt_set_led_state(int console, int leds);
 extern void vt_kbd_con_start(int console);
 extern void vt_kbd_con_stop(int console);
 
+void vc_scrolldelta_helper(struct vc_data *c, int lines,
+		unsigned int rolled_over, void *_base, unsigned int size);
 
 #endif /* _VT_KERN_H */
-- 
2.10.1


