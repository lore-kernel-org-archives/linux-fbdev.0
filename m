From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 15 Jul 2020 01:51:02 +0000
Subject: [PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
Message-Id: <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
In-Reply-To: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, George Kennedy <george.kennedy@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.com>, Dan Carpenter <dan.carpenter@oracle.com>

syzbot is reporting general protection fault in bitfill_aligned() [1]
caused by integer underflow in bit_clear_margins(). The cause of this
problem is when and how do_vc_resize() updates vc->vc_{cols,rows}.

If vc_do_resize() fails (e.g. kzalloc() fails) when var.xres or var.yres
is going to shrink, vc->vc_{cols,rows} will not be updated. This allows
bit_clear_margins() to see info->var.xres < (vc->vc_cols * cw) or
info->var.yres < (vc->vc_rows * ch). Unexpectedly large rw or bh will
try to overrun the __iomem region and causes general protection fault.

Also, vc_resize(vc, 0, 0) does not set vc->vc_{cols,rows} =3D 0 due to

  new_cols =3D (cols ? cols : vc->vc_cols);
  new_rows =3D (lines ? lines : vc->vc_rows);

exception. Since cols and lines are calculated as

  cols =3D FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
  rows =3D FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
  cols /=3D vc->vc_font.width;
  rows /=3D vc->vc_font.height;
  vc_resize(vc, cols, rows);

in fbcon_modechanged(), var.xres < vc->vc_font.width makes cols =3D 0
and var.yres < vc->vc_font.height makes rows =3D 0. This means that

  const int fd =3D open("/dev/fb0", O_ACCMODE);
  struct fb_var_screeninfo var =3D { };
  ioctl(fd, FBIOGET_VSCREENINFO, &var);
  var.xres =3D var.yres =3D 1;
  ioctl(fd, FBIOPUT_VSCREENINFO, &var);

easily reproduces integer underflow bug explained above.

Of course, callers of vc_resize() are not handling vc_do_resize() failure
is bad. But we can't avoid vc_resize(vc, 0, 0) which returns 0. Therefore,
as a band-aid workaround, this patch checks integer underflow in
"struct fbcon_ops"->clear_margins call, assuming that
vc->vc_cols * vc->vc_font.width and vc->vc_rows * vc->vc_font.heigh do not
cause integer overflow.

[1] https://syzkaller.appspot.com/bug?id=A565882df74fa76f10d3a6fec4be31098d=
bb37c6

Reported-and-tested-by: syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appsp=
otmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/core/bitblit.c   | 4 ++--
 drivers/video/fbdev/core/fbcon_ccw.c | 4 ++--
 drivers/video/fbdev/core/fbcon_cw.c  | 4 ++--
 drivers/video/fbdev/core/fbcon_ud.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/=
bitblit.c
index ca935c09a261..35ebeeccde4d 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -216,7 +216,7 @@ static void bit_clear_margins(struct vc_data *vc, struc=
t fb_info *info,
 	region.color =3D color;
 	region.rop =3D ROP_COPY;
=20
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dx =3D info->var.xoffset + rs;
 		region.dy =3D 0;
 		region.width =3D rw;
@@ -224,7 +224,7 @@ static void bit_clear_margins(struct vc_data *vc, struc=
t fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
=20
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dx =3D info->var.xoffset;
 		region.dy =3D info->var.yoffset + bs;
 		region.width =3D rs;
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/cor=
e/fbcon_ccw.c
index dfa9a8aa4509..78f3a5621478 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -201,7 +201,7 @@ static void ccw_clear_margins(struct vc_data *vc, struc=
t fb_info *info,
 	region.color =3D color;
 	region.rop =3D ROP_COPY;
=20
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dx =3D 0;
 		region.dy =3D info->var.yoffset;
 		region.height =3D rw;
@@ -209,7 +209,7 @@ static void ccw_clear_margins(struct vc_data *vc, struc=
t fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
=20
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dx =3D info->var.xoffset + bs;
 		region.dy =3D 0;
                 region.height =3D info->var.yres_virtual;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core=
/fbcon_cw.c
index ce08251bfd38..fd098ff17574 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -184,7 +184,7 @@ static void cw_clear_margins(struct vc_data *vc, struct=
 fb_info *info,
 	region.color =3D color;
 	region.rop =3D ROP_COPY;
=20
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dx =3D 0;
 		region.dy =3D info->var.yoffset + rs;
 		region.height =3D rw;
@@ -192,7 +192,7 @@ static void cw_clear_margins(struct vc_data *vc, struct=
 fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
=20
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dx =3D info->var.xoffset;
 		region.dy =3D info->var.yoffset;
                 region.height =3D info->var.yres;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core=
/fbcon_ud.c
index 1936afc78fec..e165a3fad29a 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -231,7 +231,7 @@ static void ud_clear_margins(struct vc_data *vc, struct=
 fb_info *info,
 	region.color =3D color;
 	region.rop =3D ROP_COPY;
=20
-	if (rw && !bottom_only) {
+	if ((int) rw > 0 && !bottom_only) {
 		region.dy =3D 0;
 		region.dx =3D info->var.xoffset;
 		region.width  =3D rw;
@@ -239,7 +239,7 @@ static void ud_clear_margins(struct vc_data *vc, struct=
 fb_info *info,
 		info->fbops->fb_fillrect(info, &region);
 	}
=20
-	if (bh) {
+	if ((int) bh > 0) {
 		region.dy =3D info->var.yoffset;
 		region.dx =3D info->var.xoffset;
                 region.height  =3D bh;
--=20
2.18.4
