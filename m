From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: linux-2.6.21-rc1-g9654640d build #241
	failed with WARNING: "aty_st_lcd"
	[drivers/video/aty/atyfb.ko] undefined!
Date: Mon, 26 Feb 2007 14:22:00 +0100
Message-ID: <200702261422.02802.toralf.foerster@gmx.de>
References: <200702261143.28770.toralf.foerster@gmx.de>
	<1172493351.20842.1.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0785164800=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLfo2-0004XR-5M for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 05:22:18 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HLfo1-0004Cv-Jc
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 05:22:18 -0800
In-Reply-To: <1172493351.20842.1.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============0785164800==
Content-Type: multipart/signed; boundary="nextPart7672934.gbbvuZhikh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7672934.gbbvuZhikh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag, 26. Februar 2007 13:35 schrieb Antonino A. Daplas:
> On Mon, 2007-02-26 at 11:43 +0100, Toralf F=F6rster wrote:
> >   MODPOST 327 modules
> > WARNING: "aty_st_lcd" [drivers/video/aty/atyfb.ko] undefined!
> > WARNING: "aty_ld_lcd" [drivers/video/aty/atyfb.ko] undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2=20
>=20
> Try the attached patch:
>=20
> Tony
>=20

compiles fine now :-)

=2D-=20
MfG/Sincerely

Toralf F=F6rster

--nextPart7672934.gbbvuZhikh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF4t76hyrlCH22naMRAli/AKCrM2LtvPUvfBNmb7kEXbGfh6CkjQCeNP3n
REOz/6pirXIyRvdkKJlFGMM=
=BiUD
-----END PGP SIGNATURE-----

--nextPart7672934.gbbvuZhikh--


--===============0785164800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0785164800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0785164800==--
