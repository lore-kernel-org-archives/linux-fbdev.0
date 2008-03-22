From: Keith Packard <keith.packard@intel.com>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p	notebook
Date: Sat, 22 Mar 2008 09:40:17 -0700
Message-ID: <1206204017.26934.554.camel@koto.keithp.com>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<1206119016.26934.516.camel@koto.keithp.com>
	<20080322112548.GB3022@deprecation.cyrius.com>
Reply-To: keith.packard@intel.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0188039377=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jd6mW-0003Wx-4A for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 09:41:20 -0700
Received: from mga02.intel.com ([134.134.136.20])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jd6mS-0002b0-Sw
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 09:41:20 -0700
In-Reply-To: <20080322112548.GB3022@deprecation.cyrius.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, keith.packard@intel.com


--===============0188039377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TKB+N4gzFfYobDeKaHHF"


--=-TKB+N4gzFfYobDeKaHHF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Sat, 2008-03-22 at 12:25 +0100, Martin Michlmayr wrote:

> I don't see anything in the BIOS that would be obviously related to
> VGA.  Any idea what to look for?

Its very unlikely that you'll find any configuration related to this,
but the BIOS programs the video chip at POST time, and a lot of that
programming is relevant even when you use the vga16fb driver.

> The BIOS is ROM F.0A 02/16/2008 and Video BIOS 1471

That's newer than the one I have; one wonders if they broke something...

Can you use vesafb instead of vga16fb? That should be far more reliable.

--=20
keith.packard@intel.com

--=-TKB+N4gzFfYobDeKaHHF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH5TZxQp8BWwlsTdMRAkyuAJ0Z6xb+3QB2H9S5csBV2VSreXqhAgCfbPrZ
gFKnPrKMu+p7JdnKQHmpjD0=
=MSS1
-----END PGP SIGNATURE-----

--=-TKB+N4gzFfYobDeKaHHF--



--===============0188039377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0188039377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0188039377==--
