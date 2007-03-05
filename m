From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Mon, 5 Mar 2007 07:59:12 +0100
Message-ID: <20070305065911.GA1017@code-monkey.de>
References: <200703021053.00955.hjk@linutronix.de>
	<200703021610.58188.hjk@linutronix.de>
	<20070302152414.GC907@code-monkey.de>
	<200703042247.21590.hjk@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0591808832=="
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <200703042247.21590.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: =?iso-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org


--===============0591808832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hans-J=FCrgen Koch [2007-03-04 22:47]:
> @matroxfb developers: Thanks a lot, guys! Well done! Most people I asked =
about=20
> having a dual-head framebuffer console at 1680x1050 thought it would be=
=20
> impossible.
>=20
> @mga xorg developers: Well... Can you tell me why the kernel guys can=20
> initialize and use the second head and you can't? If you can give me hint=
s=20
> where in the source I can start to look for the bug, I'm willing to spend=
=20
> some time there. Is there something I could try in my configuration?

matroxfb is much better organized wrt dual-head configurations. It also
has support for some hardware that xf86-video-mga doesn't support yet.
I'm working on that.

I think you might be hitting this bug:
https://bugs.freedesktop.org/show_bug.cgi?id=3D9854

I just attached a temporary fix that you could try.

Regards,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)

iD8DBQFF67+/27uLisrW2w8RAp1WAKCHK5kgiEYMeWoP7j2ZiCNmRMSjwgCfYqTw
qJ9UAIaJy9xhFOjif5pPkk0=
=aK8D
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--===============0591808832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============0591808832==--
