From: Yuval Kogman <nothingmuch@woobling.org>
Subject: Matrox G450 etv, matroxfb_base not loading
Date: Sat, 28 Aug 2004 16:26:13 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040828132613.GA11996@woobling.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C13Dp-0003va-GV
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 06:26:21 -0700
Received: from smtp3.actcom.co.il ([192.114.47.65])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C13Dn-0005gf-IR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 Aug 2004 06:26:21 -0700
Received: from pasta.woobling.org ([192.117.109.142])
	by smtp3.actcom.co.il (8.12.11/8.12.11) with ESMTP id i7SDQDax010134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 Aug 2004 16:26:14 +0300
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi...

I've got a matrox g450 etv card. For some reason I'm unable to get the
framebuffer drivers loaded, and thus cannot capture video with the mgatv
v4l driver.

Here is what I get in the syslog when matroxfb_base is loaded:

Aug 28 16:09:40 pasta ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level,=
 low) -> IRQ 16
Aug 28 16:09:40 pasta matroxfb: Matrox G450 detected
Aug 28 16:09:40 pasta matroxfb: probe of 0000:01:00.0 failed with error -1

The modules do remain loaded though.


This is what lspci -v has to say:

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP =
(rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Marvel G450 eTV
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at ee000000 (32-bit, prefetchable)
        Memory at e8000000 (32-bit, non-prefetchable) [size=3D16K]
        Memory at e9000000 (32-bit, non-prefetchable) [size=3D8M]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0


Here is my kernel info:

Linux pasta 2.6.8.1 #4 Sat Aug 21 18:43:24 IDT 2004 i686 AMD Athlon(tm) XP =
2400+ AuthenticAMD GNU/Linux

The kernel is a vanilla tree. Gentoo's dev sources, which have some
patches, also had the same issues and I thought that they were to
blame initially.


So far I've found no mention of a similar problem via google or on
the mailing lists. The card is from ebay. Could it be a hardware
problem? VGA output works well, with the XFree mga driver. I don't
have the output breakout cable braid (replacement on the way), so
i can't say much about tv out, etc.


Well, that's about all the info I know to give you in advance.

Thanks,

--=20
 ()  Yuval Kogman <nothingmuch@woobling.org> 0xEBD27418  perl hacker &
 /\  kung foo master: MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM: neeyah!


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBMIf1VCwRwOvSdBgRAgloAJ4+xIsn0fCB054WCSwhc587gQGKdACguSNn
/ts/kF5f/jaVIzYGMUJMajk=
=mcNP
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
