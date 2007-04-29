From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/7] vga: vgastate fix
Date: Sun, 29 Apr 2007 11:48:27 +0800
Message-ID: <4634158B.6070402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0Te-0003bc-9Y for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:43 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0Td-000446-SW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:34 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:53:33 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ondrej Zajicek <santiago@crfreenet.org>

1) sets 'palette access disabled' during read from AR10.
   This is usually documented as needed for access AR01-AR0F,
   but on ARK Logic card it is needed for AR10 (otherwise read
   returns some nonsence and save_vga_text() returns before do
   anything).

2) do not restore AR10, because it was not changed during

3) remove modification of misc reg:
        /* force graphics mode */
        vga_w(state->vgabase, VGA_MIS_W, misc | 1);

   as comment is misleading - LSB of misc reg does not set/reset graphics
   mode, but set color/mono adresses of CRT and some other regs.
   but these regs are not used during save/restore fonts.
   (it worked even when (misc | 1) was replaced by (misc & ~1) ).

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/vgastate.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
index d94efaf..b91c466 100644
--- a/drivers/video/vgastate.c
+++ b/drivers/video/vgastate.c
@@ -50,23 +50,28 @@ static void save_vga_text(struct vgastat
 	struct regstate *saved = (struct regstate *) state->vidstate;
 	int i;
 	u8 misc, attr10, gr4, gr5, gr6, seq1, seq2, seq4;
+	unsigned short iobase;
 
 	/* if in graphics mode, no need to save */
+	misc = vga_r(state->vgabase, VGA_MIS_R);
+	iobase = (misc & 1) ? 0x3d0 : 0x3b0;
+
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x00);
 	attr10 = vga_rattr(state->vgabase, 0x10);
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x20);
+
 	if (attr10 & 1)
 		return;
-	
+
 	/* save regs */
-	misc = vga_r(state->vgabase, VGA_MIS_R);
 	gr4 = vga_rgfx(state->vgabase, VGA_GFX_PLANE_READ);
 	gr5 = vga_rgfx(state->vgabase, VGA_GFX_MODE);
 	gr6 = vga_rgfx(state->vgabase, VGA_GFX_MISC);
 	seq2 = vga_rseq(state->vgabase, VGA_SEQ_PLANE_WRITE);
 	seq4 = vga_rseq(state->vgabase, VGA_SEQ_MEMORY_MODE);
 	
-	/* force graphics mode */
-	vga_w(state->vgabase, VGA_MIS_W, misc | 1);
-
 	/* blank screen */
 	seq1 = vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
@@ -115,15 +120,12 @@ static void save_vga_text(struct vgastat
 	}
 
 	/* restore regs */
-	vga_wattr(state->vgabase, 0x10, attr10);
-
 	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, seq2);
 	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, seq4);
 
 	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, gr4);
 	vga_wgfx(state->vgabase, VGA_GFX_MODE, gr5);
 	vga_wgfx(state->vgabase, VGA_GFX_MISC, gr6);
-	vga_w(state->vgabase, VGA_MIS_W, misc);
 
 	/* unblank screen */
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
@@ -137,11 +139,10 @@ static void restore_vga_text(struct vgas
 {
 	struct regstate *saved = (struct regstate *) state->vidstate;
 	int i;
-	u8 misc, gr1, gr3, gr4, gr5, gr6, gr8; 
+	u8 gr1, gr3, gr4, gr5, gr6, gr8;
 	u8 seq1, seq2, seq4;
 
 	/* save regs */
-	misc = vga_r(state->vgabase, VGA_MIS_R);
 	gr1 = vga_rgfx(state->vgabase, VGA_GFX_SR_ENABLE);
 	gr3 = vga_rgfx(state->vgabase, VGA_GFX_DATA_ROTATE);
 	gr4 = vga_rgfx(state->vgabase, VGA_GFX_PLANE_READ);
@@ -151,9 +152,6 @@ static void restore_vga_text(struct vgas
 	seq2 = vga_rseq(state->vgabase, VGA_SEQ_PLANE_WRITE);
 	seq4 = vga_rseq(state->vgabase, VGA_SEQ_MEMORY_MODE);
 	
-	/* force graphics mode */
-	vga_w(state->vgabase, VGA_MIS_W, misc | 1);
-
 	/* blank screen */
 	seq1 = vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
@@ -213,8 +211,6 @@ static void restore_vga_text(struct vgas
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
 
 	/* restore regs */
-	vga_w(state->vgabase, VGA_MIS_W, misc);
-
 	vga_wgfx(state->vgabase, VGA_GFX_SR_ENABLE, gr1);
 	vga_wgfx(state->vgabase, VGA_GFX_DATA_ROTATE, gr3);
 	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, gr4);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
