From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Framebuffers and VC setup (via fbcon.c)
Date: Tue, 9 Mar 2004 15:39:51 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040309143950.GS17857@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B0ifG-0005mc-5n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Mar 2004 06:57:02 -0800
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B0iOl-0006nc-6L
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Mar 2004 06:39:59 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've got some trouble getting a local FB console to work, maybe you've
got some suggestions...

This all happens on a VAX 4000 Model 46. I've already done the FB driver
(http://cvs.sourceforge.net/viewcvs.py/linux-vax/kernel-2.5/drivers/video/v=
axlcgfb.c)
which basically works - cat'ting a properly prepared image to it
produces a proper display output.

Now I tried to bring CONFIG_VT and CONFIG_FRAMEBUFFER_CONSOLE into the
game. However, I end up with no working FB console. No penguin image, no
login prompt. This is because vc->vc_bottom ends up being 0, while it
should be at around 60.

Adding some printk()s and initcall_debug, here is what happens:

  tty_class_init()
  chr_dev_init()
    vaxlcgfb_init()
  tty_init()
    vty_init()
      fb_console_init()
			"fbcon_startup: mode: VAX LCGfb"
			"fbcon_startup: visual: 3"
			"fbcon_startup: res: 1280x1024-8"
			"Console: switching to frame buffer device"
  pty_init()
  fb_console_init()
  			"Console: switching to frame buffer device"
  ...
  vc_init():
  			currcons=3D0, rows=3D64, cols=3D160, clear=3D1
			then colors 0..15 are set

Two things look odd to me:

	- fb_console_init is called twice. Once from
	  tty_init() -> vty_init() -> fb_console_init(), second time
	  directly as a "normal" __init / module_init() call.
	- Despite the fact that (quite late in the boot process)
	  vc_init() is called (with correct looking arguments), I think
	  it should have been called quite some time earlier. With other
	  (PC based) graphic cards, the machine just switches to FB mode
	  after the FB driver is initialized. All further output is put
	  there. But not here...

I haven't yet really understood how FB and console code work together,
so it would be nice to have some hints there :)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATdc2Hb1edYOZ4bsRAluGAKCCf4d6HqFuRzgTdubkQfHpiYiCdACfUMJn
pAYia4qt4wMUPXWpe7PXYyo=
=wyKT
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
