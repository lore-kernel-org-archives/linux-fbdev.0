From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date: Sat, 26 Sep 2020 16:25:17 +0000
Subject: Re: KASAN: use-after-free Read in bit_putcs
Message-Id: <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000000000000226d3f05b02dd607@google.com>
In-Reply-To: <000000000000226d3f05b02dd607@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org, syzkaller-bugs@googlegroups.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

A simplified reproducer and debug printk() patch shown below reported that
vc_font.height is increased to 9 via ioctl(VT_RESIZEX) after it was once
decreased from 16 to 2 via ioctl(PIO_FONT).



Since vc_resize() with v.v_rows =3D 0 preserves current vc->vc_rows value,
this reproducer is bypassing

	if (v.v_clin) {
		int rows =3D v.v_vlin / v.v_clin;
		if (v.v_rows !=3D rows) {
			if (v.v_rows) /* Parameters don't add up */
				return -EINVAL;
			v.v_rows =3D rows;
		}
	}

check by setting v.v_vlin =3D 1 and v.v_clin =3D 9.

If v.v_vcol > 0 and v.v_vcol !=3D vc->vc_cols (though this reproducer is pa=
ssing
v.v_vcol =3D 0), tty_do_resize() from vc_do_resize() from vc_resize() can m=
ake
"struct tty_struct"->winsize.ws_ypixel =3D 1 despite
"struct tty_struct"->winsize.vc->vc_rows =3D vc->vc_rows (which is usually =
larger
than 1). Does such winsize (a row has 1 / vc->vc_rows pixel) make sense?



Since I don't know the meaning of "struct vt_consize"->v_clin (which is com=
mented
with "/* number of pixel rows per character */" but does it mean font size =
?),
I don't know why we can assign that value to vcp->vc_font.height via

	if (v.v_clin)
		vcp->vc_font.height =3D v.v_clin;

in vt_resizex(). While ioctl(PIO_FONT) needs to pass vc->vc_sw->con_font_se=
t()
check in con_font_set(), ioctl(VT_RESIZEX) does not pass it in vt_resizex()=
...

Since this problem does not happen if I remove

	if (v.v_clin)
		vcp->vc_font.height =3D v.v_clin;

 from vt_resizex(), I guess that some variables are getting confused by cha=
nge
of vc->vc_font.height ...

  #define VT_RESIZE     0x5609  /* set kernel's idea of screensize */
  #define VT_RESIZEX    0x560A  /* set kernel's idea of screensize + more */

Hmm, what comes to the "+ more" part? Who is using VT_RESIZEX ?
If nobody is using VT_RESIZEX, better to make VT_RESIZEX =3D VT_RESIZE ?

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/kd.h>
#include <linux/vt.h>

int main(int argc, char *argv[])
{
        int fd =3D open("/dev/tty1", 3);
        static char fontdata[8192] =3D { 2, 3 };
        struct vt_consize v_c =3D { 0, 0, 1, 9, 0, 0 };
        ioctl(fd, PIO_FONT, fontdata);
        ioctl(fd, VT_RESIZEX, &v_c);
        return 0;
}
----------

----------
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index a4e520bdd521..df6b7abd1068 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -769,64 +769,70 @@ static int vt_resizex(struct vc_data *vc, struct vt_c=
onsize __user *cs)
 {
 	struct vt_consize v;
 	int i;
+	int ret =3D 0;
=20
 	if (copy_from_user(&v, cs, sizeof(struct vt_consize)))
 		return -EFAULT;
=20
-	/* FIXME: Should check the copies properly */
-	if (!v.v_vlin)
-		v.v_vlin =3D vc->vc_scan_lines;
+	console_lock();
+	for (i =3D 0; i < MAX_NR_CONSOLES; i++) {
+		struct vc_data *vcp =3D vc_cons[i].d;
=20
-	if (v.v_clin) {
-		int rows =3D v.v_vlin / v.v_clin;
-		if (v.v_rows !=3D rows) {
-			if (v.v_rows) /* Parameters don't add up */
-				return -EINVAL;
-			v.v_rows =3D rows;
+		if (!vcp)
+			continue;
+		if (v.v_clin) {
+			int rows =3D (v.v_vlin ? v.v_vlin : vcp->vc_scan_lines) / v.v_clin;
+			if (v.v_rows !=3D rows) {
+				if (v.v_rows) { /* Parameters don't add up */
+					ret =3D -EINVAL;
+					break;
+				}
+				v.v_rows =3D rows;
+			}
 		}
-	}
-
-	if (v.v_vcol && v.v_ccol) {
-		int cols =3D v.v_vcol / v.v_ccol;
-		if (v.v_cols !=3D cols) {
-			if (v.v_cols)
-				return -EINVAL;
-			v.v_cols =3D cols;
+		if (v.v_vcol && v.v_ccol) {
+			int cols =3D v.v_vcol / v.v_ccol;
+			if (v.v_cols !=3D cols) {
+				if (v.v_cols) {
+					ret =3D -EINVAL;
+					break;
+				}
+				v.v_cols =3D cols;
+			}
+		}
+		if (v.v_clin > 32) {
+			ret =3D -EINVAL;
+			break;
 		}
 	}
+	printk(KERN_INFO "vc=3D%px v.v_rows=3D%hu v.v_cols=3D%hu v.v_vlin=3D%hu v=
.v_clin=3D%u v.v_vcol=3D%hu v.v_ccol=3D%hu ret=3D%d\n", vc, v.v_rows, v.v_c=
ols, v.v_vlin, v.v_clin, v.v_vcol, v.v_ccol, ret);
+	for (i =3D 0; !ret && i < MAX_NR_CONSOLES; i++) {
+		unsigned int save_scan_lines;
+		unsigned int save_font_height;
+		struct vc_data *vcp =3D vc_cons[i].d;
=20
-	if (v.v_clin > 32)
-		return -EINVAL;
-
-	for (i =3D 0; i < MAX_NR_CONSOLES; i++) {
-		struct vc_data *vcp;
-
-		if (!vc_cons[i].d)
+		if (!vcp)
 			continue;
-		console_lock();
-		vcp =3D vc_cons[i].d;
-		if (vcp) {
-			int ret;
-			int save_scan_lines =3D vcp->vc_scan_lines;
-			int save_font_height =3D vcp->vc_font.height;
-
-			if (v.v_vlin)
-				vcp->vc_scan_lines =3D v.v_vlin;
-			if (v.v_clin)
-				vcp->vc_font.height =3D v.v_clin;
-			vcp->vc_resize_user =3D 1;
-			ret =3D vc_resize(vcp, v.v_cols, v.v_rows);
-			if (ret) {
-				vcp->vc_scan_lines =3D save_scan_lines;
-				vcp->vc_font.height =3D save_font_height;
-				console_unlock();
-				return ret;
-			}
+		save_scan_lines =3D vcp->vc_scan_lines;
+		save_font_height =3D vcp->vc_font.height;
+		if (v.v_vlin)
+			vcp->vc_scan_lines =3D v.v_vlin;
+		if (v.v_clin)
+			vcp->vc_font.height =3D v.v_clin;
+		printk(KERN_INFO "vcp=3D%px before: ->vc_rows=3D%u ->vc_cols=3D%u ->vc_s=
can_lines=3D%u save_scan_lines=3D%u ->vc_font.height=3D%u save_font_height=
=3D%u\n",
+		       vcp, vcp->vc_rows, vcp->vc_cols, vcp->vc_scan_lines, save_scan_li=
nes, vcp->vc_font.height, save_font_height);
+		vcp->vc_resize_user =3D 1;
+		ret =3D vc_resize(vcp, v.v_cols, v.v_rows);
+		printk(KERN_INFO "vcp=3D%px after: ->vc_rows=3D%u ->vc_cols=3D%u ->vc_sc=
an_lines=3D%u save_scan_lines=3D%u ->vc_font.height=3D%u save_font_height=
=3D%u ret=3D%d\n",
+		       vcp, vcp->vc_rows, vcp->vc_cols, vcp->vc_scan_lines, save_scan_li=
nes, vcp->vc_font.height, save_font_height, ret);
+		if (ret) {
+			vcp->vc_scan_lines =3D save_scan_lines;
+			vcp->vc_font.height =3D save_font_height;
 		}
-		console_unlock();
 	}
+	console_unlock();
=20
-	return 0;
+	return ret;
 }
=20
 /*
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/=
bitblit.c
index 9725ecd1255b..c1b9f43ff657 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -181,6 +181,8 @@ static void bit_putcs(struct vc_data *vc, struct fb_inf=
o *info,
 		dst =3D fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data =3D dst;
=20
+		printk(KERN_DEBUG "%s: width=3D%u cellsize=3D%u count=3D%d maxcnt=3D%u s=
can_align=3D%u buf_align=3D%u image.width=3D%u image.height=3D%u pitch=3D%u=
\n",
+		       __func__, width, cellsize, count, maxcnt, scan_align, buf_align, =
image.width, image.height, pitch);
 		if (!mod)
 			bit_putcs_aligned(vc, info, s, attribute, cnt, pitch,
 					  width, cellsize, &image, buf, dst);
----------

----------
[  297.298013] [ T2823] bit_putcs: width=3D1 cellsize=16 count=80 maxcntQ2 =
scan_align=3D0 buf_align=3D0 image.widthd0 image.height=16 pitch=80
[  297.312092] [ T2823] bit_putcs: width=3D1 cellsize=16 count=80 maxcntQ2 =
scan_align=3D0 buf_align=3D0 image.widthd0 image.height=16 pitch=80
[  297.324735] [ T2823] bit_putcs: width=3D1 cellsize=16 count=80 maxcntQ2 =
scan_align=3D0 buf_align=3D0 image.widthd0 image.height=16 pitch=80
[  297.337634] [ T2823] bit_putcs: width=3D1 cellsize=16 count=80 maxcntQ2 =
scan_align=3D0 buf_align=3D0 image.widthd0 image.height=16 pitch=80
[  297.350185] [ T2823] bit_putcs: width=3D1 cellsize=16 count=80 maxcntQ2 =
scan_align=3D0 buf_align=3D0 image.widthd0 image.height=16 pitch=80
[  297.361861] [ T2823] bit_putcs: width=3D1 cellsize=16 count=80 maxcntQ2 =
scan_align=3D0 buf_align=3D0 image.widthd0 image.height=16 pitch=80
[  297.474116] [ T2823] bit_putcs: width=3D1 cellsize=16 count( maxcntQ2 sc=
an_align=3D0 buf_align=3D0 image.width"4 image.height=16 pitch(
[  297.481866] [ T2823] bit_putcs: width=3D1 cellsize=16 count=3D4 maxcntQ2=
 scan_align=3D0 buf_align=3D0 image.width2 image.height=16 pitch=3D4
[  297.483529] [ T2823] bit_putcs: width=3D1 cellsize=16 count=3D1 maxcntQ2=
 scan_align=3D0 buf_align=3D0 image.width=3D8 image.height=16 pitch=3D1
[  297.484792] [ T2823] bit_putcs: width=3D1 cellsize=16 count=3D7 maxcntQ2=
 scan_align=3D0 buf_align=3D0 image.widthV image.height=16 pitch=3D7
[  357.373828] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.375232] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.376821] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.378256] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.379684] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
(...snipped...)
[  357.720089] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.721519] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.722962] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.724390] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.725834] [ T2940] bit_putcs: width=3D1 cellsize=3D2 count=80 maxcnt@9=
6 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D2 pitch=80
[  357.727876] [ T2940] vc=FFff8880d69b6000 v.v_rows=3D0 v.v_cols=3D0 v.v_v=
lin=3D1 v.v_clin=3D9 v.v_vcol=3D0 v.v_ccol=3D0 ret=3D0
[  357.727933] [ T2940] vcp=FFff8880d69b6000 before: ->vc_rows$0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines@0 ->vc_font.height=3D9 save_font_he=
ight=3D2
[  357.727994] [ T2940] vcp=FFff8880d69b6000 after: ->vc_rows$0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines@0 ->vc_font.height=3D9 save_font_he=
ight=3D2 ret=3D0
[  357.728050] [ T2940] vcp=FFff8880d46d9000 before: ->vc_rows0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_=
height=16
[  357.728110] [ T2940] vcp=FFff8880d46d9000 after: ->vc_rows0 ->vc_cols=80=
 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_hei=
ght=16 ret=3D0
[  357.728167] [ T2940] vcp=FFff8880d40a8000 before: ->vc_rows0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_=
height=16
[  357.728227] [ T2940] vcp=FFff8880d40a8000 after: ->vc_rows0 ->vc_cols=80=
 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_hei=
ght=16 ret=3D0
[  357.728283] [ T2940] vcp=FFff8880d46fb000 before: ->vc_rows0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_=
height=16
[  357.728344] [ T2940] vcp=FFff8880d46fb000 after: ->vc_rows0 ->vc_cols=80=
 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_hei=
ght=16 ret=3D0
[  357.728400] [ T2940] vcp=FFff8880d46f9000 before: ->vc_rows0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_=
height=16
[  357.728460] [ T2940] vcp=FFff8880d46f9000 after: ->vc_rows0 ->vc_cols=80=
 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_hei=
ght=16 ret=3D0
[  357.728516] [ T2940] vcp=FFff8880ce2d1000 before: ->vc_rows0 ->vc_cols=
=80 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_=
height=16
[  357.728616] [ T2940] vcp=FFff8880ce2d1000 after: ->vc_rows0 ->vc_cols=80=
 ->vc_scan_lines=3D1 save_scan_lines=3D0 ->vc_font.height=3D9 save_font_hei=
ght=16 ret=3D0
[  357.743762] [    C0] bit_putcs: width=3D1 cellsize=3D9 counth maxcnt=910=
 scan_align=3D0 buf_align=3D0 image.widthT4 image.height=3D9 pitchh
[  357.743783] [    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  357.743803] [    C0] BUG: KASAN: slab-out-of-bounds in bit_putcs+0x6a0/0=
x980
[  357.743822] [    C0] Read of size 1 at addr ffff8880d46ff343 by task a.o=
ut/2940
[  357.743830] [    C0]
[  357.743848] [    C0] CPU: 0 PID: 2940 Comm: a.out Not tainted 5.9.0-rc6+=
 #635
[  357.743871] [    C0] Hardware name: innotek GmbH VirtualBox/VirtualBox, =
BIOS VirtualBox 12/01/2006
[  357.743880] [    C0] Call Trace:
[  357.743891] [    C0]  dump_stack+0x161/0x1c3
[  357.743902] [    C0]  ? bit_putcs+0x6a0/0x980
[  357.743914] [    C0]  ? bit_putcs+0x6a0/0x980
[  357.743932] [    C0]  print_address_description.constprop.0.cold+0xd3/0x=
4c5
[  357.743944] [    C0]  ? log_store.cold+0x16/0x16
[  357.743956] [    C0]  ? vprintk_func+0xe2/0x155
[  357.743968] [    C0]  ? bit_putcs+0x6a0/0x980
[  357.743979] [    C0]  ? bit_putcs+0x6a0/0x980
[  357.743992] [    C0]  kasan_report.cold+0x1f/0x42
[  357.744003] [    C0]  ? bit_putcs+0x6a0/0x980
[  357.744014] [    C0]  bit_putcs+0x6a0/0x980
[  357.744026] [    C0]  ? bit_clear+0x2f0/0x2f0
[  357.744038] [    C0]  ? find_held_lock+0x85/0xa0
[  357.744052] [    C0]  ? raw_notifier_call_chain+0x31/0x40
[  357.744067] [    C0]  ? fb_get_color_depth.part.0+0x57/0xe0
[  357.744082] [    C0]  ? __sanitizer_cov_trace_switch+0x49/0x80
[  357.744093] [    C0]  fbcon_putcs+0x1d8/0x1e0
[  357.744105] [    C0]  ? bit_clear+0x2f0/0x2f0
[  357.744118] [    C0]  vt_console_print+0x72d/0x870
[  357.744130] [    C0]  ? fb_flashcursor+0x230/0x230
[  357.744144] [    C0]  ? screen_glyph_unicode+0x140/0x140
[  357.744157] [    C0]  ? rwlock_bug.part.0+0x50/0x50
[  357.744171] [    C0]  ? screen_glyph_unicode+0x140/0x140
[  357.744183] [    C0]  console_unlock+0x92c/0xb30
[  357.744195] [    C0]  vt_ioctl.cold+0x182/0x3a2
[  357.744210] [    C0]  ? complete_change_console+0x1e0/0x1e0
[  357.744222] [    C0]  ? find_held_lock+0x85/0xa0
[  357.744237] [    C0]  ? debug_check_no_obj_freed+0x18d/0x276
[  357.744249] [    C0]  ? lock_downgrade+0x3e0/0x3e0
[  357.744261] [    C0]  ? find_held_lock+0x85/0xa0
[  357.744274] [    C0]  ? lock_is_held_type+0xbf/0xf0
[  357.744285] [    C0]  ? putname+0xa7/0xc0
[  357.744296] [    C0]  ? putname+0xa7/0xc0
[  357.744306] [    C0]  ? putname+0xa7/0xc0
[  357.744322] [    C0]  ? __sanitizer_cov_trace_switch+0x49/0x80
[  357.744336] [    C0]  ? complete_change_console+0x1e0/0x1e0
[  357.744361] [    C0]  ? tty_ioctl+0x7c4/0xec0
[  357.744373] [    C0]  tty_ioctl+0x7c4/0xec0
[  357.744387] [    C0]  ? kmem_cache_free.part.0+0x1b0/0x1e0
[  357.744399] [    C0]  ? tty_vhangup+0x30/0x30
[  357.744414] [    C0]  ? __sanitizer_cov_trace_switch+0x49/0x80
[  357.744426] [    C0]  ? do_vfs_ioctl+0x224/0xc50
[  357.744439] [    C0]  ? ioctl_file_clone+0x140/0x140
[  357.744452] [    C0]  ? file_open_root+0x420/0x420
[  357.744467] [    C0]  ? check_preemption_disabled+0x50/0x130
[  357.744479] [    C0]  ? lock_is_held_type+0xbf/0xf0
[  357.744495] [    C0]  ? syscall_enter_from_user_mode+0x1c/0x60
[  357.744509] [    C0]  ? rcu_read_lock_sched_held+0xa0/0xd0
[  357.744521] [    C0]  ? mark_held_locks+0x24/0x90
[  357.744533] [    C0]  ? tty_vhangup+0x30/0x30
[  357.744545] [    C0]  __x64_sys_ioctl+0xec/0x140
[  357.744557] [    C0]  do_syscall_64+0x31/0x70
[  357.744572] [    C0]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  357.744583] [    C0] RIP: 0033:0x7f9b8316150b
[  357.744632] [    C0] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 =
00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 =
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 89 01 48
[  357.744647] [    C0] RSP: 002b:00007ffe190139b8 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000010
[  357.744680] [    C0] RAX: ffffffffffffffda RBX: 000055dc2ea7b220 RCX: 00=
007f9b8316150b
[  357.744701] [    C0] RDX: 00007ffe190139cc RSI: 000000000000560a RDI: 00=
00000000000003
[  357.744721] [    C0] RBP: 0000000000000003 R08: 0000000000000000 R09: 00=
007f9b83257d50
[  357.744741] [    C0] R10: 0000000000000000 R11: 0000000000000246 R12: 00=
0055dc2ea7b130
[  357.744762] [    C0] R13: 00007ffe19013ad0 R14: 0000000000000000 R15: 00=
00000000000000
[  357.744769] [    C0]
[  357.744781] [    C0] Allocated by task 2940:
[  357.744793] [    C0]  kasan_save_stack+0x1f/0x40
[  357.744808] [    C0]  __kasan_kmalloc.constprop.0+0xbf/0xd0
[  357.744819] [    C0]  __kmalloc+0x57d/0x9d0
[  357.744831] [    C0]  fbcon_set_font+0x1a6/0x4a0
[  357.744843] [    C0]  con_font_op+0x8e2/0xac0
[  357.744854] [    C0]  vt_ioctl+0x1186/0x21a0
[  357.744866] [    C0]  tty_ioctl+0x7c4/0xec0
[  357.744878] [    C0]  __x64_sys_ioctl+0xec/0x140
[  357.744889] [    C0]  do_syscall_64+0x31/0x70
[  357.744905] [    C0]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  357.744912] [    C0]
[  357.744932] [    C0] The buggy address belongs to the object at ffff8880=
d46ff000
[  357.744949] [    C0]  which belongs to the cache kmalloc-1k of size 1024
[  357.744967] [    C0] The buggy address is located 835 bytes inside of
[  357.744985] [    C0]  1024-byte region [ffff8880d46ff000, ffff8880d46ff4=
00)
[  357.745000] [    C0] The buggy address belongs to the page:
[  357.745027] [    C0] page:00000000878ccadc refcount:1 mapcount:0 mapping=
:0000000000000000 index:0x0 pfn:0xd46ff
[  357.745040] [    C0] flags: 0xfffe0000000200(slab)
[  357.745063] [    C0] raw: 00fffe0000000200 ffffea00032a0808 ffffea00035a=
e308 ffff8880d6840700
[  357.745086] [    C0] raw: 0000000000000000 ffff8880d46ff000 000000010000=
0002 ffff8880cbe8b281
[  357.745103] [    C0] page dumped because: kasan: bad access detected
[  357.745117] [    C0] page->mem_cgroup:ffff8880cbe8b281
[  357.745125] [    C0]
[  357.745140] [    C0] Memory state around the buggy address:
[  357.745162] [    C0]  ffff8880d46ff200: 00 00 fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[  357.745186] [    C0]  ffff8880d46ff280: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[  357.745208] [    C0] >ffff8880d46ff300: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[  357.745224] [    C0]                                            ^
[  357.745246] [    C0]  ffff8880d46ff380: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[  357.745267] [    C0]  ffff8880d46ff400: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[  357.745288] [    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  357.745305] [    C0] Disabling lock debugging due to kernel taint
[  357.745349] [    C0] bit_putcs: width=3D1 cellsize=3D9 countF maxcnt=910=
 scan_align=3D0 buf_align=3D0 image.width68 image.height=3D9 pitchF
[  357.759878] [    C0] bit_putcs: width=3D1 cellsize=3D9 count=80 maxcnt=
=910 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D9 pitch=80
[  357.759910] [    C0] bit_putcs: width=3D1 cellsize=3D9 countt maxcnt=910=
 scan_align=3D0 buf_align=3D0 image.widthY2 image.height=3D9 pitcht
[  357.775006] [    C0] bit_putcs: width=3D1 cellsize=3D9 count=80 maxcnt=
=910 scan_align=3D0 buf_align=3D0 image.widthd0 image.height=3D9 pitch=80
----------
