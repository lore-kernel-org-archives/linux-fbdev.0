From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: tty-related oops in latest kernel(s)?
Date: Wed, 30 May 2007 09:09:45 -0700
Message-ID: <20070530090945.ab9d51d9.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0705271200360.4955@jalava.cc.jyu.fi>
	<84144f020705280022lf3902caj1def02ed56e0bff@mail.gmail.com>
	<84144f020705280234g39aa04b3hfe369f4477e6043d@mail.gmail.com>
	<Pine.LNX.4.64.0705291900001.32656@jalava.cc.jyu.fi>
	<84144f020705291157k465ec6c4sb81081844bb57514@mail.gmail.com>
	<Pine.LNX.4.64.0705300654493.5241@jalava.cc.jyu.fi>
	<84144f020705292254o319f6619m787bf29491c92509@mail.gmail.com>
	<Pine.LNX.4.64.0705301458400.4634@jalava.cc.jyu.fi>
	<20070530083953.9909bcef.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0705301857370.29485@jalava.cc.jyu.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757920AbXE3QLl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0705301857370.29485@jalava.cc.jyu.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Tero Roponen <teanropo@jyu.fi>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andy Whitcroft <apw@shadowen.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>

On Wed, 30 May 2007 19:01:09 +0300 (EEST) Tero Roponen <teanropo@jyu.fi=
> wrote:

> On Wed, 30 May 2007, Andrew Morton wrote:
>=20
> > On Wed, 30 May 2007 15:02:49 +0300 (EEST) Tero Roponen <teanropo@jy=
u.fi> wrote:
> >=20
> > > On Wed, 30 May 2007, Pekka Enberg wrote:
> > >=20
> > > > On 5/30/07, Tero Roponen <teanropo@jyu.fi> wrote:
> > > > > Hmmm, I just found something interesting. In 2.6.21.3 the /sb=
in/init
> > > > > gets corrupted when I watch the video!
> > > > >
> > > > > $ cp /sbin/init init.before
> > > > > $ mplayer kiwi.flv
> > > > > $ cp /sbin/init init.after
> > > > >
> > > > > The sha1sums are here:
> > > > >
> > > > > 52c8d643057619cbe137b8e69d4709ce3bdd832d  init.after
> > > > > 8efc7864a5b535a9e336fa82e9d7f112f3d956c1  init.before
> > > > >
> > > > > It seems that something corrupts memory somewhere...
> > > >=20
> > > > To debug this a bit further:
> > > >=20
> > > > $ od -a -t x1 -v init.after > init.after.dump
> > > > $ od -a -t x1 -v init.before > init.before.dump
> > > > $ diff -u init.before.dump init.after.dump | less
> > > >=20
> > > > -0011340  nul nul nul  e9  f0  fe  ff  ff  ff   %   < soh enq  =
bs   h  80
> > > > -           00  00  00  e9  f0  fe  ff  ff  ff  25  3c  01  05 =
 08  68  80
> > > > +0010000    y ack nul nul   y ack nul nul   y ack nul nul   y a=
ck nul nul
> > > > +           79  06  00  00  79  06  00  00  79  06  00  00  79 =
 06  00  00
> > > > +0010020    y ack nul nul   y ack nul nul   y ack nul nul   y a=
ck nul nul
> > > > +           79  06  00  00  79  06  00  00  79  06  00  00  79 =
 06  00  00
> > > > +0011340    y ack nul nul   y ack nul nul  ff   %   < soh enq  =
bs   h  80
> > > > +           79  06  00  00  79  06  00  00  ff  25  3c  01  05 =
 08  68  80
> > > >=20
> > > > The file at offset 0010000 - 0011348 is overwritten with the by=
te
> > > > pattern 79 06 00 00.
> > > >=20
> > > > Do you see anything in the logs or is this a silent corruption?=
 Did
> > > > you see this corruption with 2.6.19 or 2.6.22-rc3?
> > > >=20
> > >=20
> > > I recompiled 2.6.22-rc3 and booted it with slub_debug. Now I can'=
t oops
> > > the kernel, but ./slab_info -v gives me a warning:
> > >=20
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > neofb: no support for 32bpp
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1024x768) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1152x864) larger than the LCD panel (800x600)
> > > Mode (1024x1024) larger than the LCD panel (800x600)
> > > Mode (1024x1024) larger than the LCD panel (800x600)
> > > Mode (1024x1024) larger than the LCD panel (800x600)
> > > Mode (1024x1024) larger than the LCD panel (800x600)
> > > Mode (1280x1024) larger than the LCD panel (800x600)
> > > Mode (1280x1024) larger than the LCD panel (800x600)
> > > Mode (1280x1024) larger than the LCD panel (800x600)
> > > Mode (1280x1024) larger than the LCD panel (800x600)
> > > *** SLUB kmalloc-1024: Redzone Active@0xc10be860 slab 0xc10217c0
> > >     offset=3D2144 flags=3D0x80004082 inuse=3D7 freelist=3D0x00000=
000
> > >   Bytes b4 0xc10be850:  00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a=
 5a 5a ........ZZZZZZZZ
> > >     Object 0xc10be860:  00 00 00 00 00 20 00 00 20 03 00 00 58 02=
 00 00 ............X...
> > >     Object 0xc10be870:  20 03 00 00 58 02 00 00 00 00 00 00 00 00=
 00 00 ....X...........
> > >     Object 0xc10be880:  10 00 00 00 00 00 00 00 0b 00 00 00 05 00=
 00 00 ................
> > >     Object 0xc10be890:  00 00 00 00 05 00 00 00 06 00 00 00 00 00=
 00 00 ................
> > >     Object 0xc10be8a0:  00 00 00 00 05 00 00 00 00 00 00 00 00 00=
 00 00 ................
> > >     Object 0xc10be8b0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 ................
> > >     Object 0xc10be8c0:  ff ff ff ff ff ff ff ff 00 00 00 00 a8 61=
 00 00 =FF=FF=FF=FF=FF=FF=FF=FF....=A8a..
> > >     Object 0xc10be8d0:  58 00 00 00 28 00 00 00 17 00 00 00 01 00=
 00 00 X...(...........
> > >    Redzone 0xc10bec60:  4d 6b 00 00                              =
       Mk..           =20
> > > FreePointer 0xc10bec64 -> 0x00006b4d
> > > Last alloc: 0x6b4d jiffies_ago=3D4294923792 cpu=3D27469 pid=3D274=
69
> > > Last free : 0x6b4d jiffies_ago=3D4294923792 cpu=3D27469 pid=3D274=
69
> > >     Filler 0xc10bec88:  4d 6b 00 00 4d 6b 00 00                  =
       Mk..Mk..       =20
> > >  [<c013f717>] check_object+0x64/0x23d
> > >  [<c0141371>] validate_slab+0xff/0x12a
> > >  [<c01413aa>] validate_slab_slab+0xe/0x51
> > >  [<c0141488>] validate_store+0x9b/0xe8
> > >  [<c01343d1>] __handle_mm_fault+0x370/0x68b
> > >  [<c01413ed>] validate_store+0x0/0xe8
> > >  [<c013eaa6>] slab_attr_store+0x1e/0x22
> > >  [<c016e470>] sysfs_write_file+0xad/0xd6
> > >  [<c016e3c3>] sysfs_write_file+0x0/0xd6
> > >  [<c0143341>] vfs_write+0x8a/0x10c
> > >  [<c01437d7>] sys_write+0x41/0x67
> > >  [<c01022c2>] sysenter_past_esp+0x5f/0x85
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > @@@ SLUB kmalloc-1024: Restoring redzone (0xcc) from 0xc10bec60-0=
xc10bec63
> > >=20
> >=20
> > So something did an overwrite of a 1024-byte kmalloc.  Unfortunatel=
y that
> > overwrite seems to have trashed our last-alloc info, so we don't kn=
ow who
> > allocated that memory.  Darn.
> >=20
> > Does the problem go away if you disable CONFIG_SLUB and enable CONF=
IG_SLAB?
> >=20
> >=20
>=20
> Hi,
>=20
> after some trial and error I found a simple way to trigger the
> corruption:
>=20
> [root@terrop ~]# ./slabinfo -v
> [root@terrop ~]# ./oops
> [root@terrop ~]# ./slabinfo -v

Whoa.  Impressed.

> *** SLUB kmalloc-1024: Redzone Active@0xc10be860 slab 0xc10217c0
>     offset=3D2144 flags=3D0x80004082 inuse=3D7 freelist=3D0x00000000
>   Bytes b4 0xc10be850:  00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a =
5a ........ZZZZZZZZ
>     Object 0xc10be860:  00 00 00 00 00 20 00 00 20 03 00 00 58 02 00 =
00 ............X...
>     Object 0xc10be870:  20 03 00 00 58 02 00 00 00 00 00 00 00 00 00 =
00 ....X...........
>     Object 0xc10be880:  18 00 00 00 00 00 00 00 10 00 00 00 08 00 00 =
00 ................
>     Object 0xc10be890:  00 00 00 00 08 00 00 00 08 00 00 00 00 00 00 =
00 ................
>     Object 0xc10be8a0:  00 00 00 00 08 00 00 00 00 00 00 00 00 00 00 =
00 ................
>     Object 0xc10be8b0:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 ................
>     Object 0xc10be8c0:  ff ff ff ff ff ff ff ff 00 00 00 00 a8 61 00 =
00 =FF=FF=FF=FF=FF=FF=FF=FF....=A8a..
>     Object 0xc10be8d0:  58 00 00 00 28 00 00 00 17 00 00 00 01 00 00 =
00 X...(...........
>    Redzone 0xc10bec60:  6b 6b 6b 00                                  =
   kkk.           =20
> FreePointer 0xc10bec64 -> 0x006b6b6b
> Last alloc: 0x6b6b6b jiffies_ago=3D4287907122 cpu=3D7039851 pid=3D703=
9851
> Last free : 0x6b6b6b jiffies_ago=3D4287907122 cpu=3D7039851 pid=3D703=
9851
>     Filler 0xc10bec88:  6b 6b 6b 00 6b 6b 6b 00                      =
   kkk.kkk.       =20
>  [<c013f717>] check_object+0x64/0x23d
>  [<c0141371>] validate_slab+0xff/0x12a
>  [<c01413aa>] validate_slab_slab+0xe/0x51
>  [<c0141488>] validate_store+0x9b/0xe8
>  [<c01343d1>] __handle_mm_fault+0x370/0x68b
>  [<c01413ed>] validate_store+0x0/0xe8
>  [<c013eaa6>] slab_attr_store+0x1e/0x22
>  [<c016e470>] sysfs_write_file+0xad/0xd6
>  [<c016e3c3>] sysfs_write_file+0x0/0xd6
>  [<c0143341>] vfs_write+0x8a/0x10c
>  [<c01437d7>] sys_write+0x41/0x67
>  [<c01022c2>] sysenter_past_esp+0x5f/0x85
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@@ SLUB kmalloc-1024: Restoring redzone (0xcc) from 0xc10bec60-0xc10=
bec63
>=20
> [root@terrop ~]# cat oops.c
> #include <sys/ioctl.h>
> #include <stdio.h>
> #include <linux/fb.h>
> #include <fcntl.h>
>=20
> int main(void)
> {
>         struct fb_var_screeninfo fbinfo;
>         int fd =3D open("/dev/fb0", O_RDWR);
>         if (fd < 0)
>                 return 1;
>=20
>         /* Get screeninfo */
>         ioctl(fd, FBIOGET_VSCREENINFO, &fbinfo);
>=20
>         /* Change depth from current 16 to 24. */
>         fbinfo.bits_per_pixel =3D 24;
>         ioctl(fd, FBIOPUT_VSCREENINFO, &fbinfo);
>=20
>         return 0;
> }
>=20
> So this seems to be a framebuffer error.
>=20

cc's added ;)

Thanks.

Tony, this is with SLUB enabled, which might be detecting a
hitherto-undetected bug.

Config is at http://userweb.kernel.org/~akpm/config-tero.txt
