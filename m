From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH] fbdev: fix the fb_find_nearest_mode() function
Date: Fri, 14 Oct 2005 17:04:08 +0200
Message-ID: <20051014150408.GA9296@spock.one.pl>
References: <20051009092949.GA9610@spock.one.pl> <434A249F.4060503@gmail.com> <20051013193650.GA17760@spock.one.pl> <434EF940.9020608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQR6h-0003e9-0E
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 08:04:27 -0700
Received: from ipp23-131.piekary.net ([80.48.23.131])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EQR6Z-0002Ik-F6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 08:04:23 -0700
Content-Disposition: inline
In-Reply-To: <434EF940.9020608@gmail.com>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2005 at 08:18:08AM +0800, Antonino A. Daplas wrote:

> > In case you're wondering why would anyone ever need to have
> > var->pixclock set to 0 -- I was using it to denote modes with a default
> > refresh rate set by the hardware (well, the Video BIOS to be more
> > specific). Please let me know is this is very wrong, but I just didn't
> > see any other way of doing it.
>=20
> No, it's not wrong. But it is preferrable to have a nonzero value in
> var->pixclock (whether calculated or via a VBE function call).
>=20
> Still, I agree with you to initialize mode->refresh to zero (or perhaps
> -1 to to denote a divide by zero) for these cases.

OK, nice. I'd say that 0 might be a little cleaner (we're avoiding
<nn>x<nn>-4294967295 entries in the sysfs nodes without having to
write any additional code). Also, no one should be dividing anything by
mode->refresh without checking its contents first, so having a zero
there doesn't seem like something dangerous. But, ultimately it's
up to you to decide, of course.

--=20
Michal Januszewski                                Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDT8joaQ0HSaOUe+YRAucDAJwO/gd9ccNSIl/38PgjXgYvQlIA6QCgpzDo
qj1zStOq4YkdyuIJ0+wcp1g=
=KJNm
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
