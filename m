From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: New API and X option UseFBDev
Date: Tue, 09 Sep 2003 11:21:55 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063099315.1407.43.camel@thor.holligenstrasse29.lan>
References: <XFMail.20030909074955.jim.hague@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wehR-0008LY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 02:22:13 -0700
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wehQ-0003AD-3u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 02:22:12 -0700
In-Reply-To: <XFMail.20030909074955.jim.hague@acm.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2003-09-09 at 08:49, Jim Hague wrote:
>=20
> I have a problem when I try and run X (Debian 4.2.1-11 20030829103906). My
> config uses the Glint driver with UseFBDev true, and works fine on 2.4.22=
. It
> fails on 2.6 like this:
>=20
> (II) Setting vga for screen 0.
> (**) GLINT(0): Depth 16, (--) framebuffer bpp 16
> (=3D=3D) GLINT(0): RGB weight 565
> (=3D=3D) GLINT(0): Default visual is TrueColor
> (=3D=3D) GLINT(0): Using gamma correction (1.0, 1.0, 1.0)
> (**) GLINT(0): Option "UseFBDev" "true"
> (=3D=3D) GLINT(0): Using HW cursor
> (II) Loading sub module "fbdevhw"
> (II) LoadModule: "fbdevhw"
> (II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
> (II) Module fbdevhw: vendor=3D"The XFree86 Project"
>         compiled for 4.2.1.1, module version =3D 0.0.2
>         ABI class: XFree86 Video Driver, version 0.5
> (**) GLINT(0): Using Linux framebuffer device
> (--) GLINT(0): Chipset: "ti_pm2"
> (--) GLINT(0): Linear framebuffer at 0xCE800000
> (--) GLINT(0): MMIO registers at 0xCFFE0000
> (EE) GLINT(0): mmap mmio: Invalid argument
> (EE) GLINT(0): mmap mmio: Invalid argument
> =20
> Fatal server error:
> Caught signal 11.  Server aborting
>=20
> The lfb and MMIO addresses are correct. Now, I've new to this game and ma=
y have
> missed filling out a structure field somewhere. But I'm dammed if I can s=
ee
> what.
>=20
> It's occurred to me that maybe this just doesn't work and I need an updat=
ed
> fbdevhw. Do I? Or should it really Just Work?

It should just work, certainly does here with the radeon driver and
radeonfb. I'd add some debugging output to the framebuffer device and/or
fbdevHW.


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
