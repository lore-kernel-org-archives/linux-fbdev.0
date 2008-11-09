From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] Fix crash in viafb due to 4k stack overflow
Date: Sun, 9 Nov 2008 22:37:48 +0100
Message-ID: <20081109223748.3182e31d@neptune.home>
References: <20081109202537.33ead0a2@neptune.home>
	<20081109113603.d45361ad.akpm@linux-foundation.org>
	<20081109122515.1deb9ec2@infradead.org>
	<20081109213811.4b85adc6@neptune.home>
	<20081109125522.b5266352.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757059AbYKIViI@vger.kernel.org>
In-Reply-To: <20081109125522.b5266352.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@infradead.org>, JosephChan@via.com.tw, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 09 November 2008 Andrew Morton wrote:
> On Sun, 9 Nov 2008 21:38:11 +0100 Bruno Pr=C3=A9mont wrote:
> > On Sun, 09 November 2008 Arjan van de Ven wrote:
> > > On Sun, 9 Nov 2008 Andrew Morton wrote:
> > > > On Sun, 9 Nov 2008 Bruno Pr__mont wrote:
> > > >=20
> > > > > The function viafb_cursor() uses 2 stack-variables of
> > > > > CURSOR_SIZE bits; CURSOR_SIZE is defined as (8 * 1024). Using
> > > > > up twice 1k on stack is too much for 4k-stack (though it
> > > > > works with 8k-stacks).
> > > >=20
> > > > > =20
> > > > >  	if (viacursor.enable)
> > > >=20
> > > > Is the ->fb_cursor handler allowed to perform GFP_KERNEL memory
> > > > allocations?  It's never called from atomic contexts?
> > >=20
> > > if it's allowed to do GFP_KERNEL memory allocations the statement
> > > that it works with 8k stacks is a bit overstated... since irq's
> > > can come in and take several KB of stack as well ;)
> > I don't know if it can be called from atomic contexts or not :(

Ok scanned under drivers/video/ for users of fb_cursor() and all those
(under drivers/video/console/) do GPT_ATOMIC allocations before calling
fbops->fb_cursor, so my patch chooses the wrong allocation constraint.

=46ixed patch below

> > In addition I get panics some time after start-up which I'm not sur=
e
> > what to associate them with (apparently unrelated)
> > It could be some stack overflow by calling fbset (I will to more
> > testing in order to find out)
> >=20
> > First attempt: calling fbset via ssh:
> >=20
> > [ 1806.952151] BUG: unable to handle kernel NULL pointer
> > dereference at 00000123 [ 1806.952601] IP: [<c03d2737>]
> > icmpv6_send+0x387/0x580
> >=20
> > ...
> >
> > Second attempt, delayed after calling fbset from console:
> >=20
> > [  217.260426] BUG: unable to handle kernel NULL pointer
> > dereference at 000000c7 [  217.260915] IP: [<c0380b46>]
> > rt_worker_func+0xb6/0x160
>=20
> gack.  Your kernel was destroyed.
>=20
> Stack overflow might well explain this.  Does it work OK with 8k
> stacks?
My last attempt with 8k stacks is a bit dated (2.6.27-rc) but back then
I saw the same kind of behavior than now with viafb, crash with 4k-stac=
k
but running system with 8k-stack. Running system does of course not mea=
n
that stack cannot overflow :)

> scripts/checkstack.pl should help find the problems.

Thanks for the pointer!

It show a nice candidate, viafb_ioctl in top-6:
0xc011612b identity_mapped [vmlinux]:                   4096
0xc017896b do_sys_poll [vmlinux]:                       888
0xc0178bdd do_sys_poll [vmlinux]:                       888
0xc024506b sha256_transform [vmlinux]:                  752
0xc024768b sha256_transform [vmlinux]:                  752
0xc027d933 viafb_ioctl [vmlinux]:                       728
0xc01783c8 do_select [vmlinux]:                         708
0xc0178853 do_select [vmlinux]:                         708


On a new attempt the box survived fbset "1280x1024-60" though
I did wait some time after boot up before calling it.
So it's pretty probable that either it gets near the limit of stack
or this time the neighborhood of the stack was not just as critical :/

Shall I trim down that function's stack usage as well?
(many structs allocated from stack)

What is preferred, allocating a big block of memory and point various
variables inside that block or do multiple individual allocations?

e.g.
  u8 data[CURSOR_SIZE/8]
  u32 data_bak[CURSOR_SIZE/32]
 =3D>
  u8 *data =3D kzalloc(...)
  u32 *data_bak =3D kzalloc(...)
 or
  u8 *data =3D kzalloc(CURSOR_SIZE/8 + CURSOR_SIZE/32, ...)
  u32 *data_bak =3D (u32*)(data+CURSOR_SIZE/8);

=46irst option is more readable, second should be more efficient...

The end result readability would suffer even more in case of viafb_ioct=
l()
with the big amount of different structs that could be allocated from h=
eap
instead of stack...

Bruno



---
--- linux-2.6.28-rc3.orig/drivers/video/via/viafbdev.c	2008-11-09 19:22=
:15.000000000 +0100
+++ linux-2.6.28-rc3/drivers/video/via/viafbdev.c	2008-11-09 21:25:47.0=
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
+		u8 *data =3D kzalloc(CURSOR_SIZE / 8, GFP_ATOMIC);
+		u32 *data_bak =3D kzalloc(CURSOR_SIZE / 32, GFP_ATOMIC);
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
