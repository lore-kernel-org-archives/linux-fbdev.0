From: Marcelo Ramos <mramos@montevideo.com.uy>
Subject: Re: pm2fb fixes
Date: Wed, 21 Apr 2004 13:26:39 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040421132639.1d87ba1b@zerocool>
References: <20040421015118.2caa6e99@zerocool>
	<XFMail.20040421111442.jim.hague@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__21_Apr_2004_13_26_39_-0300_O6YcjhRfzCaNtH_8"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGL4G-0002yd-9z
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 09:59:24 -0700
Received: from r200-40-228-146.adinet.com.uy ([200.40.228.146] helo=mx2.montevideo.com.uy)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BGL4F-0007y9-GG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 09:59:23 -0700
In-Reply-To: <XFMail.20040421111442.jim.hague@acm.org>
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

--Signature=_Wed__21_Apr_2004_13_26_39_-0300_O6YcjhRfzCaNtH_8
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El (On) Wed, 21 Apr 2004 11:14:42 +0100 (BST)
Jim Hague <jim.hague@acm.org> escribi=F3 (wrote):

[...]
> The 2.6 version of pm2fb currently only has three possible arguments, 'mo=
de',
> 'lowvsync' and 'lowhsync'. I think I'm the only person needing the last t=
wo.
>=20
> When compiled in to the kernel, the argument syntax imitates other 2.6
> drivers. Arguments are comma separated, and any argument that isn't 'lowv=
sync'
> or'lowhsync' is assumed to be a modedb
> specification,'<hres>x<vres>-<refresh>'. You probably want:
>=20
> video=3Dpm2fb:1024x768-70

That line didn't work but using @70 instead of -70 worked like a charm. Tha=
nks
very much for you info! :)

Now i'm a happy framebuffer user again.

Keep the excellent work.

Regards.

--=20
 _____________________________________________________________
                                        _____  ____________
  Marcelo Ramos                        |     \/      __    |
  Fedora Core 1 | Linux 2.6.5          |            |_/    /
  Socio UYLUG Nro 125                  |                   \
  Linux registered user #118109        |____|\/|____|\______\

--Signature=_Wed__21_Apr_2004_13_26_39_-0300_O6YcjhRfzCaNtH_8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAhqDEKHiVwzS5rpkRAl3lAKCR+CqjLbFz0VjugAq/DVWgCXJKRwCgkncb
uwYDNz9DNm5zGb8uhCiKYkI=
=0LbG
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Apr_2004_13_26_39_-0300_O6YcjhRfzCaNtH_8--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
