From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] s3fb: mode selection fixes
Date: Mon, 1 Oct 2007 22:49:44 +0200
Message-ID: <20071001204943.GA2017@localhost.localdomain>
References: <20070930161020.e6a01fa0.krzysztof.h1@poczta.fm>
	<20070930203136.GA1829@localhost.localdomain>
	<20071001194345.cd5d609d.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0576214670=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcSDZ-0000k4-1T for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 13:50:17 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IcSDU-0006D7-M7
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 13:50:15 -0700
In-Reply-To: <20071001194345.cd5d609d.krzysztof.h1@poczta.fm>
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
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>


--===============0576214670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2007 at 07:43:45PM +0200, Krzysztof Helt wrote:
> > > - sets r,g,b length field from the bits_per_pixel value otherwise
> > >   the fbset fails in simple case like switching depths:=20
> > >   8bpp ->32bpp -> 8bpp
> >=20
> > When some depth and some color lengths are requested then this driver
> > (or precisely svga_match_format() ) only changes them up (which is corr=
ect
> > behavior according to some previous email from A. Daplas).
> >=20
> > But if you do some partial change of mode using fbset, then fbset uses
> > previous values for unspecified values of var structure in
> > FBIOPUT_VSCREENINFO call. For example if you use 32bpp and do
> > fbset -depth 16, then fbset calls FBIOPUT_VSCREENINFO with arguments
> > requesting depth 16 but color length 8 for each channel. Better way
> > is to put zeroes to color lengths (which is what fbset does when you
> > do something like 'fbset 640x480-60 -depth 16') - workaround is to use
> > argument -rgba 0,0,0,0  with -depth change using fbset.
> >=20
>=20
> What is a difference if certain color depths allow only specific color le=
ngths?

No difference. svga_match_format() interprets color lengths in
FBIOPUT_VSCREENINFO as minimal requests.

Perhaps svga_match_format() could be changed to choose any mode with
matching depth in case there is no mode with matching depth and color
lengths. I will send patch.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@=
njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkcBXWcACgkQw1GB2RHercOfewCfWXD4lPRV3BX9T0L6ZS1NSZ/k
44kAn3OVaxYpFuJRVVL4NNK8RDfruGu3
=izqo
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


--===============0576214670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0576214670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0576214670==--
