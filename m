From: Luigi Gangitano <luigi@debian.org>
Subject: Re: Re: [Fwd: AtyFB in 2.6.10, still not
	perfect]
Date: Tue, 22 Mar 2005 21:06:00 +0100
Message-ID: <1111521961.6402.4.camel@willis>
References: <200503151826.46073.adaplas@hotpop.com>
	 <1110928841.6491.0.camel@willis> <200503160749.19151.adaplas@hotpop.com>
	 <200503191615.32610.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ndFqd47PDCbagsVRJsWG"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpe3-0003pT-6l
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 12:06:31 -0800
Received: from [193.205.140.229] (helo=localhost.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DDpdj-0001X0-79
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 12:06:31 -0800
In-Reply-To: <200503191615.32610.alex.kern@gmx.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Alexander Kern <alex.kern@gmx.de>


--=-ndFqd47PDCbagsVRJsWG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Il giorno sab, 19-03-2005 alle 16:15 +0100, Alexander Kern ha scritto:
> Copyed from oldest mail...=20
>=20
> > (as known) with 2.6.10. Latest 2.6.10 source in
> > debian adds the fix that
> > was integrated in 2.6.11, from
> >=20
> > =20
> > http://lists.debian.org/debian-sparc/2005/02/msg00063.html
>=20
> It's mean you run 2.6.10 + "always hsync on SPARC" patch ?

Right. Same behaviour with 2.6.11, however.

> And if you try any fixes from Tony, you see mclk 100 xclk 100 in your dme=
sg,=20
> bur screen is steel garbage?

Yes. dmesg reports the setting passed on cmdline and screen is still
garbled. Setting xclk to 100 makes things worse.

Regards,

--=20
 Luigi Gangitano -- <luigi@debian.org> -- <gangitano@lugroma3.org>
 GPG: 1024D/924C0C26: 12F8 9C03 89D3 DB4A 9972  C24A F19B A618 924C 0C26

--=-ndFqd47PDCbagsVRJsWG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCQHqo8ZumGJJMDCYRAn9cAJ9Vjj1s9rYwsISe5AxA8K6FssjCNQCeL9Jo
0tZQu8IBjYhPeXlD2mN4qJI=
=AeOa
-----END PGP SIGNATURE-----

--=-ndFqd47PDCbagsVRJsWG--


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
