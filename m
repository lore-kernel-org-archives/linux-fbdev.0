From: Ondrej Zajicek <santiago@mail.cz>
Subject: Bug in vga16fb?
Date: Tue, 4 Apr 2006 22:40:02 +0200
Message-ID: <20060404204002.GB2251@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQsJz-0002Fw-8i
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 13:40:15 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FQsJx-0005cQ-Qm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 13:40:15 -0700
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.1/8.13.1) with ESMTP id k34Ke4mg065532
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 4 Apr 2006 22:40:06 +0200 (CEST)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1FQsJm-0000eX-OS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 22:40:02 +0200
Content-Disposition: inline
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


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

I tried vga16fb driver in 320x200x4 nonstd mode (on i386 - little endian). =
In
this mode framebuffer reports PACKED PIXELS type. Drawing through framebuff=
er
is OK, but console is broken - it looks like that even and odd columns are
exchanged.

Framebuffer structure of this mode is that even pixel is in high nibble and
odd pixel is in low nibble.

It looks like vga16fb use cfbimgblt.c/slow_imageblit in this mode for
image-blit and this function in CFB4 writes even pixel in low nibble and
odd pixel in high nibble.

What is correct framebuffer structure for CFB4 mode?

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.ne=
tlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkQy2aIACgkQw1GB2RHercOoOwCeJuNMpft8T5VJFIOwFvkOEp2V
VrQAn04iE8bb8UvtdyTOjwqPjFR+k+43
=QQfo
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
