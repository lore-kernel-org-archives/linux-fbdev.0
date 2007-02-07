From: Vincent Sanders <vince@arm.linux.org.uk>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Wed, 7 Feb 2007 17:38:42 +0000
Message-ID: <20070207173842.GA19261@kyllikki.org>
References: <20070206192628.GA13644@fluff.org.uk>
	<20070206210930.fc814bf6.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0256413381=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEqln-0004ZV-I6 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 09:39:47 -0800
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEqlj-0003KA-Gi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 09:39:47 -0800
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
	by mtaout03-winn.ispmail.ntl.com with ESMTP id
	<20070207173856.WUNV1468.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 7 Feb 2007 17:38:56 +0000
Received: from mail.kyllikki.org ([81.105.122.70])
	by aamtaout02-winn.ispmail.ntl.com with ESMTP id
	<20070207173856.WUGW17393.aamtaout02-winn.ispmail.ntl.com@mail.kyllikki.org>
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 7 Feb 2007 17:38:56 +0000
In-Reply-To: <20070206210930.fc814bf6.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--===============0256413381==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2007 at 09:09:30PM -0800, Andrew Morton wrote:
> On Tue, 6 Feb 2007 19:26:28 +0000 Ben Dooks <ben-linux@fluff.org> wrote:
>=20
> > This patch is an update patch, ready for merging
> > for the Silicon Motion SM501 multi-function device
> > core.
> >=20
> > This driver handles the core function of the chip,
> > including the clock, power control and allocation
> > of resources for drivers. It also exports a series
> > of platform devices for the function drivers to
> > attach to.
> >=20
> > This patch supports both platform and PCI bus
> > attached devices.
> >=20
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
>=20
> Can we get Vincent's signoff here?
>=20

Signed-off-by: Vincent Sanders <vince@arm.linux.org.uk>

hows that ;-)

--=20
Regards Vincent


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFFyg6iiUwwPOvjHvURAhksAJwIWbx5p9khTlYVKfthdPd/WRHcsACfQzLb
OxNxhM8JlIdjqqyaCSgfgWQ=
=ps2h
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


--===============0256413381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0256413381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0256413381==--
