From: Ondrej Zajicek <santiago@mail.cz>
Subject: Re: Bug in vga16fb?
Date: Thu, 6 Apr 2006 09:37:13 +0200
Message-ID: <20060406073713.GA3051@localhost.localdomain>
References: <20060404204002.GB2251@localhost.localdomain> <44344950.9090703@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRP3S-0002fi-Ur
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 00:37:22 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FRP3S-0005JU-Gc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 00:37:23 -0700
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.1/8.13.1) with ESMTP id k367bG1n043060
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 6 Apr 2006 09:37:17 +0200 (CEST)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1FRP3J-0000p0-PF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Apr 2006 09:37:13 +0200
Content-Disposition: inline
In-Reply-To: <44344950.9090703@vc.cvut.cz>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2006 at 12:48:48AM +0200, Petr Vandrovec wrote:
> Ondrej Zajicek wrote:
> >Hello
> >
> >I tried vga16fb driver in 320x200x4 nonstd mode (on i386 - little endian=
).=20
> >In
> >this mode framebuffer reports PACKED PIXELS type. Drawing through=20
> >framebuffer
> >is OK, but console is broken - it looks like that even and odd columns a=
re
> >exchanged.
> >
> >Framebuffer structure of this mode is that even pixel is in high nibble =
and
> >odd pixel is in low nibble.
> >
> >It looks like vga16fb use cfbimgblt.c/slow_imageblit in this mode for
> >image-blit and this function in CFB4 writes even pixel in low nibble and
> >odd pixel in high nibble.
> >
> >What is correct framebuffer structure for CFB4 mode?
>=20
> Unfortunately there is no standard, as CFB4 itself is quite non-standard=
=20
> VGA mode.  Some videocards first output low nibble, followed by high, and=
=20
> some do otherwise.  I've experimented with this back in 2000, and I've=20
> found that Matrox Millennium does exactly opposite than some ATI Mach64=
=20
> card I had in another box at that time.
>=20
> So your only option is providing two CFB4 modes.  Unfortunately I have no=
=20
> idea how to autodetect what your hardware actually does without adding=20
> camera to the system...

Even if we find some possibility to autodetect what hardware does (or in
case of another, non-VGA hardware using CFB4 mode) there would be
problem that driver cannot say it to userspace (or generic kernel
functions like cfb_imageblit). Maybe there should be some flag in
type_aux specifying whether given packed pixel mode is LSB-first or
MSB-first (relevant only for bpp % 8 !=3D 0) ?

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.ne=
tlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkQ0xSkACgkQw1GB2RHercMewgCfTL2KJIqIGx4Uqu7co4NjkXfp
/C0An1uA0x0D7YHo6H8ZuU+Vkp6kuz6V
=2ojV
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
