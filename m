From: Henry Nestler <henry.nestler@gmail.com>
Subject: [PATCH 2/4] fbcon: Macro CUR_USE_SW for
	vc_cursor_type mask 0x10
Date: Wed, 2 Dec 2009 03:50:09 +0100
Message-ID: <5b77f61c0912011850u71ae35a0p7fc9bdcc06898b4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <henry.nestler@gmail.com>) id 1NFfIP-0004Vn-65
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:50:25 +0000
Received: from mail-ew0-f211.google.com ([209.85.219.211])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFfIH-0000i6-03 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:50:25 +0000
Received: by ewy3 with SMTP id 3so9895211ewy.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 Dec 2009 18:50:10 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: geert@linux-m68k.org
Cc: trivial@kernel.org, linux-fbdev-devel@lists.sourceforge.net

from: Henry Nestler <henry.nestler@gmail.com>

Replace hard coded 0x10 mask for vc_cursor_type with new macro CUR_USE_SW.

Signed-off-by: Henry Nestler <henry.nestler@gmail.com>
---
Kernel version 2.6.32-rc8

 drivers/char/vt.c                       |    2 +-
 drivers/video/console/bitblit.c         |    2 +-
 drivers/video/console/fbcon.c           |    2 +-
 drivers/video/console/fbcon_ccw.c       |    2 +-
 drivers/video/console/fbcon_cw.c        |    2 +-
 drivers/video/console/fbcon_ud.c        |    2 +-
 include/linux/console_struct.h          |    1 +
 7 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 0c80c68..f8b0f58 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -566,7 +566,7 @@ static void add_softcursor(struct vc_data *vc)
 	int i = scr_readw((u16 *) vc->vc_pos);
 	u32 type = vc->vc_cursor_type;

-	if (! (type & 0x10)) return;
+	if (! (type & CUR_USE_SW)) return;
 	if (softcursor_original != -1) return;
 	softcursor_original = i;
 	i |= ((type >> 8) & 0xff00 );
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c
b/drivers/usb/misc/sisusbvga/sisusb_con.c
diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index 6b7c8fb..5858863 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -241,7 +241,7 @@ static void bit_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = DIV_ROUND_UP(vc->vc_font.width, 8), c;
 	int y = real_y(ops->p, vc->vc_y);
-	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	int attribute, use_sw = (vc->vc_cursor_type & CUR_USE_SW);
 	int err = 1;
 	char *src;

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 3681c6a..d1074ec 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1291,7 +1291,7 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
 		return;

-	if (vc->vc_cursor_type & 0x10)
+	if (vc->vc_cursor_type & CUR_USE_SW)
 		fbcon_del_cursor_timer(info);
 	else
 		fbcon_add_cursor_timer(info);
diff --git a/drivers/video/console/fbcon_ccw.c
b/drivers/video/console/fbcon_ccw.c
index bdf913e..c6fd4a9 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -226,7 +226,7 @@ static void ccw_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
 	int y = real_y(ops->p, vc->vc_y);
-	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	int attribute, use_sw = (vc->vc_cursor_type & CUR_USE_SW);
 	int err = 1, dx, dy;
 	char *src;
 	u32 vyres = GETVYRES(ops->p->scrollmode, info);
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index a6819b9..00ac747 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -210,7 +210,7 @@ static void cw_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
 	int y = real_y(ops->p, vc->vc_y);
-	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	int attribute, use_sw = (vc->vc_cursor_type & CUR_USE_SW);
 	int err = 1, dx, dy;
 	char *src;
 	u32 vxres = GETVXRES(ops->p->scrollmode, info);
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index d9b5d6e..ee740e1 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -256,7 +256,7 @@ static void ud_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(ops->p, vc->vc_y);
-	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	int attribute, use_sw = (vc->vc_cursor_type & CUR_USE_SW);
 	int err = 1, dx, dy;
 	char *src;
 	u32 vyres = GETVYRES(ops->p->scrollmode, info);
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 38fe59d..c12b3b1 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -129,6 +129,7 @@ extern void vc_SAK(struct work_struct *work);
 #define CUR_BLOCK	6
 #define CUR_HWMASK	0x0f
 #define CUR_SWMASK	0xfff0
+#define CUR_USE_SW	0x10

 #define CUR_DEFAULT CUR_UNDERLINE

===

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
