From: Nico Schottelius <schottelius@wdt.de>
Subject: Re: atyfb: 2.5.54
Date: Thu, 9 Jan 2003 09:38:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030109083828.GA251@schottelius.org>
References: <20030105115507.GC167@schottelius.org> <Pine.LNX.4.44.0301072154010.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dialin-145-254-167-040.arcor-ip.net ([145.254.167.40] helo=schottelius.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WgpL-0006tb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 09:50:50 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301072154010.17129-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

James Simmons [Tue, Jan 07, 2003 at 09:54:51PM +0000]:
>=20
> > With 2.5.54 there is something like success with my hardware.
> > Now I get a cursor at the right position. I can't see what I type,
> > but I see the cursor moving correctly.
> > After unloading atyfb the console still behaves this way, nothing
> > changes.
> >=20
> > Are there some options I should set ? I am currently just loading
> > atyfb (with recognizes my card as PCI although it's AGP; seen in dmesg).
>=20
> Can do post your dmesg.

!dmesg

atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTA=
L, 230 MHz PLL, 50 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI

Just tell me, if you need more information.

Nico


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+HTUEtnlUggLJsX0RArCyAJ9VmegMiMkbXgtrsRYD7mflzfcmPACfc3V8
v0wUDu2yKynDggbv6hu1iUE=
=HaS7
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
