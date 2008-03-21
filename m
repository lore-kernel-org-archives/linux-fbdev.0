From: Keith Packard <keith.packard@intel.com>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p	notebook
Date: Fri, 21 Mar 2008 10:03:36 -0700
Message-ID: <1206119016.26934.516.camel@koto.keithp.com>
References: <20080321163944.GA22068@deprecation.cyrius.com>
Reply-To: keith.packard@intel.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1559396411=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JckhE-0000Ql-OB for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Mar 2008 10:06:24 -0700
Received: from mga03.intel.com ([143.182.124.21])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JckhB-0000B1-BR
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Mar 2008 10:06:24 -0700
In-Reply-To: <20080321163944.GA22068@deprecation.cyrius.com>
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


--===============1559396411==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7rEaIMjyFWrfe5lkvhO1"


--=-7rEaIMjyFWrfe5lkvhO1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2008-03-21 at 17:39 +0100, Martin Michlmayr wrote:
> When I start debian-installer on my HP 2510p notebook the screen
> becomes blank when it tries to start the frame buffer.

I have the same machine and the debian install worked for me. Perhaps
your BIOS has configured the chip in a way that prevents VGA graphics
mode from working?

--=20
keith.packard@intel.com

--=-7rEaIMjyFWrfe5lkvhO1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH4+poQp8BWwlsTdMRAoASAKDFquALHOJH9dp9GVXZqsHNgDj0YwCePu82
sIrXusqS54M+ci77RR5iHUw=
=Ey2h
-----END PGP SIGNATURE-----

--=-7rEaIMjyFWrfe5lkvhO1--



--===============1559396411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1559396411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1559396411==--
