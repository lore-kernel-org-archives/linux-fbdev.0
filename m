From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: How to test virtual resolution
Date: Wed, 6 Aug 2008 23:00:52 +0200
Message-ID: <20080806210052.GA32021@localhost.localdomain>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
	<Pine.LNX.4.64.0808062116260.17614@anakin>
	<1218052776.25178.5.camel@oslab.mtwk.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0633919256=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQq83-0003oE-Tf for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 14:01:07 -0700
Received: from smtp.etmail.cz ([194.228.41.67])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQq82-0004By-Gi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 14:01:07 -0700
In-Reply-To: <1218052776.25178.5.camel@oslab.mtwk.freescale.net>
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
To: York Sun <yorksun@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>


--===============0633919256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2008 at 02:59:36PM -0500, York Sun wrote:
> Fbset can definitely change the resolution but it doesn't pan the
> screen. I looked around but didn't find an application takes advantage
> of the virtual resolution.

You can also test panning by writing to /sys/class/graphics/fb0/pan .

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkiaEQQACgkQw1GB2RHercNZgACghL826g59G+y7B6xnJWBJiHek
mWwAn1WlwdppqqrZtvIhNiQosDDc9ruN
=D5kc
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


--===============0633919256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0633919256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0633919256==--
