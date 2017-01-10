From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 10 Jan 2017 15:47:30 +0000
Subject: Re: [PATCH] fbcon: Fix vc attr at deinit
Message-Id: <s5h1swazzl9.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170103150322.10350-1-tiwai@suse.de>
        <s5hfukzq6h7.wl-tiwai@suse.de>
        <231ba295-087a-8913-77ba-89e0c1704709@ti.com>
In-Reply-To: <231ba295-087a-8913-77ba-89e0c1704709@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, 05 Jan 2017 13:26:07 +0100,
Tomi Valkeinen wrote:
> 
> On 04/01/17 15:50, Takashi Iwai wrote:
> > On Tue, 03 Jan 2017 16:03:22 +0100,
> > Takashi Iwai wrote:
> >>
> >> fbcon can deal with vc_hi_font_mask (the upper 256 chars) and adjust
> >> the vc attrs dynamically when vc_hi_font_mask is changed at
> >> fbcon_init().  When the vc_hi_font_mask is set, it remaps the attrs in
> >> the existing console buffer with one bit shift up (for 9 bits), while
> >> it remaps with one bit shift down (for 8 bits) when the value is
> >> cleared.  It works fine as long as the font gets updated after fbcon
> >> was initialized.
> >>
> >> However, we hit a bizarre problem when the console is switched to
> >> another fb driver (typically from vesafb or efifb to drmfb).  At
> >> switching to the new fb driver, we temporarily rebind the console to
> >> the dummy console, then rebind to the new driver.  During the
> >> switching, we leave the modified attrs as is.  Thus, the new fbcon
> >> takes over the old buffer as if it were to contain 8 bits chars
> >> (although the attrs are still shifted for 9 bits), and effectively
> >> this results in the yellow color texts instead of the original white
> >> color, as found in the bugzilla entry below.
> >>
> >> An easy fix for this is to re-adjust the attrs before leaving the
> >> fbcon at con_deinit callback.  Since the code to adjust the attrs is
> >> already present in the current fbcon code, in this patch, we simply
> >> factor out the relevant code, and call it from fbcon_deinit().
> >>
> >> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id00619
> >> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Actually not only checkpatch but also I can't find the proper
> > maintainer for this...
> > 
> > Tomi, could you check and take if it's OK?
> > 
> > Ideally, this kind of stuff should have been in rather vt side, I
> > suppose.  But since the code is already present in fbcon, it's easier
> > to reuse it as a fix for now.
> 
> I'm not fbdev maintainer anymore. Added Bartlomiej (and Andrew).

Bartlomiej (or Andrew), could you check the patch?  In case you missed
it, I attach it below again.


thanks,

Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] fbcon: Fix vc attr at deinit

fbcon can deal with vc_hi_font_mask (the upper 256 chars) and adjust
the vc attrs dynamically when vc_hi_font_mask is changed at
fbcon_init().  When the vc_hi_font_mask is set, it remaps the attrs in
the existing console buffer with one bit shift up (for 9 bits), while
it remaps with one bit shift down (for 8 bits) when the value is
cleared.  It works fine as long as the font gets updated after fbcon
was initialized.

However, we hit a bizarre problem when the console is switched to
another fb driver (typically from vesafb or efifb to drmfb).  At
switching to the new fb driver, we temporarily rebind the console to
the dummy console, then rebind to the new driver.  During the
switching, we leave the modified attrs as is.  Thus, the new fbcon
takes over the old buffer as if it were to contain 8 bits chars
(although the attrs are still shifted for 9 bits), and effectively
this results in the yellow color texts instead of the original white
color, as found in the bugzilla entry below.

An easy fix for this is to re-adjust the attrs before leaving the
fbcon at con_deinit callback.  Since the code to adjust the attrs is
already present in the current fbcon code, in this patch, we simply
factor out the relevant code, and call it from fbcon_deinit().

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id00619
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/video/console/fbcon.c | 67 ++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index a44f5627b82a..f4daadff8a6c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1165,6 +1165,8 @@ static void fbcon_free_font(struct display *p, bool freefont)
 	p->userfont = 0;
 }
 
+static void set_vc_hi_font(struct vc_data *vc, bool set);
+
 static void fbcon_deinit(struct vc_data *vc)
 {
 	struct display *p = &fb_display[vc->vc_num];
@@ -1200,6 +1202,9 @@ static void fbcon_deinit(struct vc_data *vc)
 	if (free_font)
 		vc->vc_font.data = NULL;
 
+	if (vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+
 	if (!con_is_bound(&fb_con))
 		fbcon_exit();
 
@@ -2436,32 +2441,10 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 	return 0;
 }
 
-static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
-			     const u8 * data, int userfont)
+/* set/clear vc_hi_font_mask and update vc attrs accordingly */
+static void set_vc_hi_font(struct vc_data *vc, bool set)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
-	struct display *p = &fb_display[vc->vc_num];
-	int resize;
-	int cnt;
-	char *old_data = NULL;
-
-	if (con_is_visible(vc) && softback_lines)
-		fbcon_set_origin(vc);
-
-	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
-	if (p->userfont)
-		old_data = vc->vc_font.data;
-	if (userfont)
-		cnt = FNTCHARCNT(data);
-	else
-		cnt = 256;
-	vc->vc_font.data = (void *)(p->fontdata = data);
-	if ((p->userfont = userfont))
-		REFCOUNT(data)++;
-	vc->vc_font.width = w;
-	vc->vc_font.height = h;
-	if (vc->vc_hi_font_mask && cnt = 256) {
+	if (!set) {
 		vc->vc_hi_font_mask = 0;
 		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask >>= 1;
@@ -2484,7 +2467,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 			    ((c & 0xfe00) >> 1) | (c & 0xff);
 			vc->vc_attr >>= 1;
 		}
-	} else if (!vc->vc_hi_font_mask && cnt = 512) {
+	} else {
 		vc->vc_hi_font_mask = 0x100;
 		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask <<= 1;
@@ -2516,8 +2499,38 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
 			} else
 				vc->vc_video_erase_char = c & ~0x100;
 		}
-
 	}
+}
+
+static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
+			     const u8 * data, int userfont)
+{
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
+	struct display *p = &fb_display[vc->vc_num];
+	int resize;
+	int cnt;
+	char *old_data = NULL;
+
+	if (con_is_visible(vc) && softback_lines)
+		fbcon_set_origin(vc);
+
+	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
+	if (p->userfont)
+		old_data = vc->vc_font.data;
+	if (userfont)
+		cnt = FNTCHARCNT(data);
+	else
+		cnt = 256;
+	vc->vc_font.data = (void *)(p->fontdata = data);
+	if ((p->userfont = userfont))
+		REFCOUNT(data)++;
+	vc->vc_font.width = w;
+	vc->vc_font.height = h;
+	if (vc->vc_hi_font_mask && cnt = 256)
+		set_vc_hi_font(vc, false);
+	else if (!vc->vc_hi_font_mask && cnt = 512)
+		set_vc_hi_font(vc, true);
 
 	if (resize) {
 		int cols, rows;
-- 
2.11.0

