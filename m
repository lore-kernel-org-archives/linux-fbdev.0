From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: framebuffer general questions
Date: Mon, 16 Nov 2009 01:06:20 +0100
Message-ID: <20091116000619.GA27314@localhost>
References: <20091113200759.GA5379@localhost>
	<938.2731-16809-9592867-1258327686@seznam.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7654007517402218626=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <santiago@crfreenet.org>) id 1N9p5t-0005LL-Os
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Nov 2009 00:05:21 +0000
Received: from gateway.crfreenet.org ([81.92.146.254] helo=mail.crfreenet.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9p5n-0007Bj-W0
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Nov 2009 00:05:21 +0000
In-Reply-To: <938.2731-16809-9592867-1258327686@seznam.cz>
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


--===============7654007517402218626==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2009 at 12:28:06AM +0100, Ren=C3=A9 Kola=C5=99=C3=ADk wrote:
> Thanks for your answer, but it implied some other questions :-)
>=20

> You said, that accelerated functions are called from console - so
> programs wich are drawing directly to FB (like QT embedded in my case)
> have no profit from them? Or do they?

They have no profit from them.

> What is actually the best technique of using FB (for achieving the
> best performance) - should i malloc a piece of RAM, draw to it and then
> memmove it to FB mapped address as a whole frame or draw directly to FB?
> Or it doesnt matter?

Depends on hardware and style of drawing. Dedicated graphics cards have
slower write (compared to main memory speed) and very slow read, so you
really don't want to do alpha-blending directly on mmaped framebuffer.

> When i greped through drivers sources i was expecting that accelerated
> drivers will use mmap only for registers and that the imageblit function
> would be implemented as some DMA fetching from system memory. But i was
> wrong, there are still mmaps to video memory. So i want to ask, if that
> idea is completely wrong and why drivers of GPUs use mmap to video mem,
> when they have DMA controller.

You mean fbdev drivers? FBdev API is designed to just allow mmap
framebuffer to userspace. It is not a good way to use modern GPU with
DMA transfers. Perhaps you could use DRI for that.

--=20
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksAl3sACgkQw1GB2RHercPaCACdFoHLw85itumRxeQDkR8wMa9i
JBwAn29UjUkIu/92sed2uP4pS1ccg/vn
=o/ys
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


--===============7654007517402218626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7654007517402218626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============7654007517402218626==--
