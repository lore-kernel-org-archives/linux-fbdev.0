From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: framebuffer general questions
Date: Fri, 13 Nov 2009 21:08:00 +0100
Message-ID: <20091113200759.GA5379@localhost>
References: <1023.2945-18821-2123977998-1258121508@seznam.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7469815326049442991=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N92h6-00014S-8I
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Nov 2009 20:24:32 +0000
Received: from gateway.crfreenet.org ([81.92.146.254] helo=mail.crfreenet.org)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N92h2-0004Ob-8A
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Nov 2009 20:24:32 +0000
In-Reply-To: <1023.2945-18821-2123977998-1258121508@seznam.cz>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: =?utf-8?B?UmVuw6kgS29sYcWZw61r?= <rene.kolarik@seznam.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net


--===============7469815326049442991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2009 at 03:11:48PM +0100, Ren=C3=A9 Kola=C5=99=C3=ADk wrote:
> Hi
>=20
> i am trying to customize framebuffer drivers and i have some questions...
>=20
> Please can you give me an advice?=20
>=20
> 1) If I define my own imageblit function, how do I call it? Or is it call=
ed automatically?

It is called automatically (if it is registered in fb_ops structure)
=66rom kernel console. It is not possible to call it from userspace.

> 2) I have gpu connected via pci to cpu. I did mmap and have
> framebuffer mapped in for example "uchar * data". I have loop and
> iterating through some pixel data and do data[i] =3D pixel[i]. Does this
> lead to transmitting via PCI in style - transmit byte ... end ...
> transmit byte ... end ... etc?

Probably yes, perhaps there is some write combining according to MTRR
registers.

> 3)what is the difference bethween mmap framebuffer and write to mapped
> pointer and calling write() to descriptor previously obtained by open()?

The first variant is much faster - video RAM is directly mapped to userspac=
e=20
address space, therefore there is no kernel interaction during writes (in
usual fbdev drivers).

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr9vJ8ACgkQw1GB2RHercOeXQCeLi8UQrhk/hkB0v+OdwK4NqHf
oF4An09SLS3EUYoLJhHcbbhHw4BT9DAb
=aWxd
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--


--===============7469815326049442991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7469815326049442991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============7469815326049442991==--
