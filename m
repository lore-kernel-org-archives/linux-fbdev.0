From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Framebuffer drivers in kernel 2.6.x
Date: Wed, 18 Aug 2004 07:36:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040818053646.GC16935@lug-owl.de>
References: <412238E7.C4A7ED2D@orpatec.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UD4WyN0VgQ3kz1Eq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxJAH-0006ZJ-Jp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 17 Aug 2004 22:39:13 -0700
Received: from dvmwest.gt.owl.de ([62.52.24.140])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BxJAG-0008AT-To
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 17 Aug 2004 22:39:13 -0700
Content-Disposition: inline
In-Reply-To: <412238E7.C4A7ED2D@orpatec.ch>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Otto Wyss <otto.wyss@orpatec.ch>
Cc: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>


--UD4WyN0VgQ3kz1Eq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-17 18:57:10 +0200, Otto Wyss <otto.wyss@orpatec.ch>
wrote in message <412238E7.C4A7ED2D@orpatec.ch>:
> I tried to use kernel 2.6.7 but there are almost no framebuffer drivers.

Uh? There are quite a lot of them...

> Why is this, can't the drivers from 2.4.x easily be ported to 2.7.x?
> What are the obstacles?

The API changed, but it isn't too hard to port old-style drivers to the
new API. If this hasn't happened yet, it's just because nobody yet
really missed that particular driver. However, there are a lot of
drivers available...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--UD4WyN0VgQ3kz1Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIuruHb1edYOZ4bsRAoz6AJ9BO4+Y+JD7NT+nJfr+S5I6dGZVFQCeMP0v
h0GUTv6dfO1pP2Lqivt/x7c=
=VHgy
-----END PGP SIGNATURE-----

--UD4WyN0VgQ3kz1Eq--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
