From: Nico Schottelius <schottelius@wdt.de>
Subject: aty support
Date: Sun, 1 Dec 2002 22:35:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021201213508.GJ338@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dialin-145-254-148-098.arcor-ip.net ([145.254.148.98] helo=schottelius.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18IblZ-0004VF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 01 Dec 2002 13:36:41 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guys!

I tried to get my notebook running with a framebuffer device,but
after hours trying around I got only vesa-fb running.

Which is in fact nice, but _slow_.

I tried to use aty128fb and atyfb with Linux 2.4.19 and 2.5.47-50.
I never achieved something 'displayable'.

Can you tell me,=20

   a) is my chipset compatible with the atyfb/aty128fb driver ?
   b) what todo exactly to get it working ?
   (i know howto compile kernel, patch around code,...
   what I need are informations, whether
   append=3D"video=3Daty128fb:accel,<640x480@8bpp>"
   or=20
   append=3D"video=3Datyfb:<800x600-16bpp>"

   are correct, whether to pass vga=3D options to the kernel
   is senseful and so on...)


If possible I would like to use the 1024x768x24 framebuffer device,
perhaps loadable via module.

My chipset:

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobilit=
y AGP 2x (rev 64)
01:00.0 Class 0300: 1002:4c4d (rev 64)

Please tell me whether I should sent more informations or if you
need to see .config and so on.

Sincerly,

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE96oCMtnlUggLJsX0RAn7kAKCdkG/xIwsq3sKeB55wvHGeWQtIYQCgmdya
G0SlMw8ogaQncfITwEXNLjY=
=tBDV
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
