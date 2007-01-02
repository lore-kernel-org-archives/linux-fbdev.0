From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: intelfb driver on 945GM chipset
Date: Tue, 2 Jan 2007 14:11:10 +0300
Message-ID: <20070102111110.GA7689@procyon.home>
References: <20061228135302.52101.qmail@web90402.mail.mud.yahoo.com>
	<21d7e9970701011827q714656belf91904fa9ebd63c6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1679649181=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1hYZ-0005U7-Qq for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 03:11:48 -0800
Received: from master.altlinux.org ([62.118.250.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H1hYY-0006YH-C0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 03:11:47 -0800
In-Reply-To: <21d7e9970701011827q714656belf91904fa9ebd63c6@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


--===============1679649181==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2007 at 01:27:57PM +1100, Dave Airlie wrote:
> On 12/29/06, rami jiossy <sramij@yahoo.com> wrote:
> > here is my dmesg output.
> > as you can see below intelfb claims no video mode configured at boot ti=
me
> > inspit is does.
>=20
> Intelfb doesn't support mode switching on non-CRT devices, I've
> contemplated doing the work, but I really don't have a requirement for
> it and it is a lot of work..

I have seen a board (Kontron CP306 3U CompactPCI) with which intelfb
always claims that there is a non-CRT device connected - but the board
has only a VGA output.  Probably this is just another broken BIOS...

> I'm not sure how you can get the mode set to 1024x768 before intelfb runs=
=2E.

Building intelfb into the kernel and using the vga=3D... parameter like
with vesafb used to work in this case.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFmj3OW82GfkQfsqIRAiCnAJ0dpOmACHc4/lceIEBSpA6xdSBH2gCeKqNy
prTnF5ITIoSWwV+JCVeZba4=
=Smt2
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


--===============1679649181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1679649181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1679649181==--
