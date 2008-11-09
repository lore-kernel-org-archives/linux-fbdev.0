From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH] Fix crash in viafb due to 4k stack overflow
Date: Sun, 9 Nov 2008 20:25:37 +0100
Message-ID: <20081109202537.33ead0a2@neptune.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756103AbYKITeV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: JosephChan@via.com.tw, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The function viafb_cursor() uses 2 stack-variables of CURSOR_SIZE bits;
CURSOR_SIZE is defined as (8 * 1024). Using up twice 1k on stack is too=
 much
for 4k-stack (though it works with 8k-stacks).

Make those two variables kzalloc'ed to preserve stack space.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

---
--- linux-2.6.28-rc3.orig/drviers/video/via/viafbdev.c	2008-11-09 19:22=
:15.000000000 +0100
+++ linux-2.6.28-rc3/drivers/video/via/viafbdev.c	2008-11-09 19:36:15.0=
00000000 +0100
@@ -1052,10 +1052,8 @@ static void viafb_imageblit(struct fb_in
=20
 static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor=
)
 {
-	u8 data[CURSOR_SIZE / 8];
-	u32 data_bak[CURSOR_SIZE / 32];
 	u32 temp, xx, yy, bg_col =3D 0, fg_col =3D 0;
-	int size, i, j =3D 0;
+	int i, j =3D 0;
 	static int hw_cursor;
 	struct viafb_par *p_viafb_par;
=20
@@ -1178,10 +1176,15 @@ static int viafb_cursor(struct fb_info *
 	}
=20
 	if (cursor->set & FB_CUR_SETSHAPE) {
-		size =3D
+		u8 *data =3D kzalloc(CURSOR_SIZE / 8, GFP_KERNEL);
+		u32 *data_bak =3D kzalloc(CURSOR_SIZE / 32, GFP_KERNEL);
+		int size =3D
 		    ((viacursor.image.width + 7) >> 3) *
 		    viacursor.image.height;
=20
+		if (data =3D=3D NULL || data_bak =3D=3D NULL)
+			goto out;
+
 		if (MAX_CURS =3D=3D 32) {
 			for (i =3D 0; i < (CURSOR_SIZE / 32); i++) {
 				data_bak[i] =3D 0x0;
@@ -1231,6 +1234,9 @@ static int viafb_cursor(struct fb_info *
 		memcpy(((struct viafb_par *)(info->par))->fbmem_virt +
 		       ((struct viafb_par *)(info->par))->cursor_start,
 		       data_bak, CURSOR_SIZE);
+out:
+		kfree(data);
+		kfree(data_bak);
 	}
=20
 	if (viacursor.enable)
