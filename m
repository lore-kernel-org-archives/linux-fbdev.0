From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
Subject: radeonfb not working in 2.6-kernel
Date: Wed, 15 Oct 2003 11:57:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031015115747.3a101cd3.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__15_Oct_2003_11_57_47_+0200_HgdRFX5BmV.Hb+Ju"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9k8R-0007QJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 04:48:11 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9k8Q-00056v-L4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 04:48:10 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net

--Signature=_Wed__15_Oct_2003_11_57_47_+0200_HgdRFX5BmV.Hb+Ju
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I recently started using the 2.6-kernels, however the radeonfb is the
only thing that doesn't work.
I tried the main (linus) kernel and the linuxppc-2.5-benh tree.
Below is the dmesg-output from benh's kernel.


bus pci: add driver radeonfb
radeonfb_pci_register BEGIN
radeonfb: probed DDR SGRAM 8192k videoram
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Used default PLL infos
radeonfb: Reference=3D27.00 MHz (RefDiv=3D67) Memory=3D166.00 Mhz,
System=3D166.00 MHz Starting monitor auto detection...
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
Guessing panel info...
radeonfb: Asssuming panel size 1024x768
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon LY  DDR SGRAM 8 MB
radeonfb_pci_register END
bound device '0000:01:00.0' to driver 'radeonfb'


--=20
Hanno B=F6ck - hanno@gmx.de

--Signature=_Wed__15_Oct_2003_11_57_47_+0200_HgdRFX5BmV.Hb+Ju
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jRoer2QksT29OyARAgkKAJ9PaszDoS2+m0PmlBxRghzmAXAQaQCggzEg
FFauIlSHvqL0AVJ1NMFgE8c=
=1wPA
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Oct_2003_11_57_47_+0200_HgdRFX5BmV.Hb+Ju--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
