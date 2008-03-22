From: Frans Pop <elendil@planet.nl>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p notebook
Date: Sat, 22 Mar 2008 20:35:08 +0100
Message-ID: <200803222035.08897.elendil@planet.nl>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<1206204017.26934.554.camel@koto.keithp.com>
	<20080322165817.GD13703@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1351599557=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jd9Ur-0005VB-Pj for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 12:35:19 -0700
Received: from hpsmtp-eml20.kpnxchange.com ([213.75.38.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jd9Ur-0004kK-6R
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 12:35:17 -0700
In-Reply-To: <20080322165817.GD13703@deprecation.cyrius.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Keith Packard <keith.packard@intel.com>

--===============1351599557==
Content-Type: multipart/signed; boundary="nextPart1511059.F64jBLpMXB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1511059.F64jBLpMXB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 22 March 2008, Martin Michlmayr wrote:
> > Can you use vesafb instead of vga16fb? That should be far more
> > reliable.
>
> vesafb is built into the Debian kernel, so presumably that works.
> I've no idea why debian-installer loads vga16fb.  Frans, any idea?

=46or the graphical installer we force the use of vesafb by directfb, but w=
e=20
don't do anything like that for the regular installer. So you could try=20
booting installgui and see if that does work.

Other option could be to boot with 'install video=3Dvga16fb:off', but I'm n=
ot=20
sure if that's supported.

Cheers,
=46JP

--nextPart1511059.F64jBLpMXB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH5V9sgm/Kwh6ICoQRAgSeAJ9c18DeCmDhhP8Hvql6heYUxmMF+wCfca65
PDIXvQn7JO/WCUjWKKMJd88=
=ocee
-----END PGP SIGNATURE-----

--nextPart1511059.F64jBLpMXB--


--===============1351599557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1351599557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1351599557==--
