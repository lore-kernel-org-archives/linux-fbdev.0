From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [Linux-fbdev-devel] [Qemu-devel] Re: [PATCH] Add VirtIO Frame
	Buffer Support
Date: Tue, 3 Nov 2009 17:53:03 +0100
Message-ID: <20091103165302.GA10561@localhost>
References: <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de> <4AEFCEDA.4030308@redhat.com> <87F51670-CB3F-431C-87B4-A8746F996C6F@suse.de> <20091103112543.GA24834@snarc.org> <4AEFFA0A.4040105@redhat.com> <20091103152911.GA8266@localhost> <4AF054B9.9060204@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4AF054B9.9060204@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: Avi Kivity <avi@redhat.com>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, Vincent Hanquez <tab@snarc.org>, Alexander Graf <agraf@suse.de>, linux-fbdev-devel@lists.sourceforge.net, kvm@vger.kernel.org, qemu-devel@nongnu.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2009 at 06:05:13PM +0200, Avi Kivity wrote:
>>> cirrus has pretty good 2d acceleration.  3D is a mega-project though.
>>>     =20
>> Cirrus has no blending/compositing hardware support.
>> Paravirtualized graphics can easily support full XRender-style
>> 2D acceleration.
>
> What do that entail? 3/4 operand raster ops?

Yes, basically three operand render/composite operation and rendering of
some 2D primitives (trapezoids).

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrwX+4ACgkQw1GB2RHercP9sgCfRh9nFMn7JgHfAX9EXvJOgu9q
4scAnA09vhzZ3feIeah4b39obfRMh9kq
=aatA
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
