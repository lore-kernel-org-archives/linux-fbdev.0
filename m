From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] fbdev: find mode with highest
	refresh rate in fb_find_mode()
Date: Wed, 18 Jul 2007 16:38:03 +0200
Message-ID: <20070718143803.GA5787@localhost.localdomain>
References: <20070718084102.GA22694@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0789386814=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBAfL-0002Nv-AF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 07:38:11 -0700
Received: from users.crfreenet.org ([81.92.145.1] helo=mail.crfreenet.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBAfK-00047t-Lq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 07:38:11 -0700
In-Reply-To: <20070718084102.GA22694@spock.one.pl>
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
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--===============0789386814==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2007 at 10:41:02AM +0200, Michal Januszewski wrote:
> Currently if the refresh rate is not specified fb_find_mode() returns
> the first known video mode with the requested resoluion, which provides
> no guarantees wrt the refresh rate.  Change this so that the mode with
> the highest refresh rate is returned instead.

What refresh rate it sets when used on card or monitor without DDC?

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@=
njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkaeJcsACgkQw1GB2RHercMfpACfb5jkqTVOaFcZYW8s0dKLMRUq
fl8An1eKj5cq3cZ3L3LutKUTHUwKDf2F
=a1NI
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


--===============0789386814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0789386814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0789386814==--
