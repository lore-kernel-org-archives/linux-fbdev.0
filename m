From: Henry Nestler <henry.nestler@gmail.com>
Subject: [PATCH 1/4] vt: Replace mask 0x0f with macro
	CUR_HWMASK
Date: Wed, 2 Dec 2009 03:45:20 +0100
Message-ID: <5b77f61c0912011845o765c6f81sac06e635a79c2d3b@mail.gmail.com>
References: <5b77f61c0912011837n72bf3e03x7fd9d38c818aa30d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <henry.nestler@gmail.com>) id 1NFfDk-0003G8-2w
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:45:36 +0000
Received: from mail-ew0-f211.google.com ([209.85.219.211])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFfDb-00022V-QU for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:45:35 +0000
Received: by ewy3 with SMTP id 3so9892044ewy.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 Dec 2009 18:45:21 -0800 (PST)
In-Reply-To: <5b77f61c0912011837n72bf3e03x7fd9d38c818aa30d@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

from: Henry Nestler <henry.nestler@gmail.com>

Replace hard coded 0x0f with pre-defined macro CUR_HWMASK
to mask vc_cursor_type, and replace hard coded 1 with CUR_NONE.

Signed-off-by: Henry Nestler <henry.nestler@gmail.com>
---
Kernel version 2.6.32-rc8

 drivers/char/vt.c                       |    2 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c |    2 +-
 drivers/video/console/mdacon.c          |    2 +-
 drivers/video/console/sticon.c          |    2 +-
 drivers/video/console/tileblit.c        |    2 +-
 drivers/video/console/vgacon.c          |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 0c80c68..26cf397 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -606,7 +606,7 @@ static void set_cursor(struct vc_data *vc)
 		if (vc == sel_cons)
 			clear_selection();
 		add_softcursor(vc);
-		if ((vc->vc_cursor_type & 0x0f) != 1)
+		if ((vc->vc_cursor_type & CUR_HWMASK) != CUR_NONE)
 			vc->vc_sw->con_cursor(vc, CM_DRAW);
 	} else
 		hide_cursor(vc);
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c
b/drivers/usb/misc/sisusbvga/sisusb_con.c
index b624320..7599765 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -806,7 +806,7 @@ sisusbcon_cursor(struct vc_data *c, int mode)

 	baseline = c->vc_font.height - (c->vc_font.height < 10 ? 1 : 2);

-	switch (c->vc_cursor_type & 0x0f) {
+	switch (c->vc_cursor_type & CUR_HWMASK) {
 		case CUR_BLOCK:		from = 1;
 					to   = c->vc_font.height;
 					break;
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index dd3eaaa..688837d 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -520,7 +520,7 @@ static void mdacon_cursor(struct vc_data *c, int mode)

 	mda_set_cursor(c->vc_y*mda_num_columns*2 + c->vc_x*2);

-	switch (c->vc_cursor_type & 0x0f) {
+	switch (c->vc_cursor_type & CUR_HWMASK) {

 		case CUR_LOWER_THIRD:	mda_set_cursor_size(10, 13); break;
 		case CUR_LOWER_HALF:	mda_set_cursor_size(7,  13); break;
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 491c1c1..b7c3262 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -144,7 +144,7 @@ static void sticon_cursor(struct vc_data *conp, int mode)
 	break;
     case CM_MOVE:
     case CM_DRAW:
-	switch (conp->vc_cursor_type & 0x0f) {
+	switch (conp->vc_cursor_type & CUR_HWMASK) {
 	case CUR_UNDERLINE:
 	case CUR_LOWER_THIRD:
 	case CUR_LOWER_HALF:
diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
index 0056a41..33bb70d 100644
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -91,7 +91,7 @@ static void tile_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 	cursor.fg = fg;
 	cursor.bg = bg;

-	switch (vc->vc_cursor_type & 0x0f) {
+	switch (vc->vc_cursor_type & CUR_HWMASK) {
 	case CUR_NONE:
 		cursor.shape = FB_TILE_CURSOR_NONE;
 		break;
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index da55cca..40bd8f8 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -703,7 +703,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 	case CM_MOVE:
 	case CM_DRAW:
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
-		switch (c->vc_cursor_type & 0x0f) {
+		switch (c->vc_cursor_type & CUR_HWMASK) {
 		case CUR_UNDERLINE:
 			vgacon_set_cursor_size(c->vc_x,
 					       c->vc_font.height -
===

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
