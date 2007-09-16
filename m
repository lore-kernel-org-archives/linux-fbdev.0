From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: Best way to support mulitple planes?
Date: Sun, 16 Sep 2007 19:12:05 +0200
Message-ID: <20070916171205.GA8459@localhost.localdomain>
References: <46E9949E.30908@freescale.com> <20070913211025.GB18714@sci.fi>
	<46E9ABBB.4040008@freescale.com> <1189910310.5344.18.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1051078619=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWxfU-0006lh-4K for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Sep 2007 10:12:25 -0700
Received: from gateway.crfreenet.org
	([81.92.146.254] helo=mail.crfreenet.org ident=postfix)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IWxfS-0008Os-0q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Sep 2007 10:12:23 -0700
Received: from localhost.localdomain (feanor.newtown.crfreenet.org
	[81.92.145.132])
	by mail.crfreenet.org (Postfix) with ESMTP id 0138C1033B
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 16 Sep 2007 19:12:15 +0200 (CEST)
Received: from santiago by localhost.localdomain with local (Exim 4.63)
	(envelope-from <zajio1am@artax.karlin.mff.cuni.cz>)
	id 1IWxfC-0002UB-1g for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 16 Sep 2007 19:12:06 +0200
In-Reply-To: <1189910310.5344.18.camel@daplas>
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
To: linux-fbdev-devel@lists.sourceforge.net


--===============1051078619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2007 at 10:38:30AM +0800, Antonino A. Daplas wrote:
> On Thu, 2007-09-13 at 16:29 -0500, Timur Tabi wrote:
> > Ville Syrj=E4l=E4 wrote:
> >=20
> > Would it be correct to say that applications expect the separate device=
s=20
> > (/dev/fb0, /dev/fb1, etc) to represent different monitors?
>=20
> That's not necessarily true. In the strictest sense, each /dev/fbx
> device represents one memory region.  Whether that memory region is
> attached to zero, one or more monitors is up to the driver.

I always perceived fb device as a representation of a sequencer/scanner -
probably because almost all ioctls on a fbdev device make sense for
sequencer (and associated CRT controller and DAC).

> We do not have the infrastructure yet to separate output devices from
> the framebuffer so multi-head/mergefb implementations will still be
> driver specific.

I think it can be done with (almost) present infrastructure -=20
one fb device per sequencer (sharing all memory of a card). We can
do  most of multi-head/mergedfb configurations using appropriate vxyres/pan
setting. Perhaps one new ioctl to assign output ports to sequencers and
one new sysfs option for optional memory split (separate parts of memory
accessible through each fb device instead of all memory accessible through
both fb devices).

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@=
njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkbtY+UACgkQw1GB2RHercPaggCeNhiLV5tHNR6zUAEMeSwmefQG
a80AnA0RryNWCqdi+WqbuMcjU+VFTqJP
=GX3K
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--


--===============1051078619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1051078619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1051078619==--
