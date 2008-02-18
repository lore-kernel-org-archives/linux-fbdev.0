From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 1/2] fb: add support for foreign
	endianness
Date: Mon, 18 Feb 2008 12:30:11 -0500
Message-ID: <19805.1203355811@turing-police.cc.vt.edu>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912825083=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JR9p0-0006kp-5s for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 09:30:30 -0800
Received: from turing-police.cc.vt.edu ([128.173.14.107])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JR9ow-0002SN-N8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 09:30:30 -0800
In-Reply-To: Your message of "Mon, 18 Feb 2008 08:18:47 +0100."
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, avorontsov@ru.mvista.com

--===============0912825083==
Content-Type: multipart/signed; boundary="==_Exmh_1203355811_2991P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1203355811_2991P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> Both resolve endianess at driver level. Actually, both handle it by setting special
> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> I understand that this patch is for chips which cannot reorder bytes by themselves.

Does anybody know of such a chip that's actually available in the wild?  Or are
we writing drivers for speculative possible chips?

--==_Exmh_1203355811_2991P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHucCjcC3lWbTT17ARAs3WAJsF9CsHmgfsLvqldWPilbhoVFS5NACfTFrJ
i5E2PGuWzLogM8fqDx25xCo=
=be6Y
-----END PGP SIGNATURE-----

--==_Exmh_1203355811_2991P--


--===============0912825083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0912825083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0912825083==--
