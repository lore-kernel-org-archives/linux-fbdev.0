From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 20 Dec 2011 08:36:09 +0000
Subject: Re: [PATCH V2 0/2] OMAPDSS: DISPC: Peformance improvement of DISPC
Message-Id: <1324370169.2042.2.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-WPFDQwu8dAtvXcOrbPcW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324283602-6383-1-git-send-email-cmahapatra@ti.com>
In-Reply-To: <1324283602-6383-1-git-send-email-cmahapatra@ti.com>
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-WPFDQwu8dAtvXcOrbPcW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-19 at 14:03 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> the following patch set directs to improve the scaling performance of DIS=
PC
> module which consists of two pacthes.
>=20
> The first patch is based on code of Lajos Molnar <lajos@ti.com> from Andr=
oid
> Kernel, which updates the code with new set of coefficients to improve th=
e
> scaling performance.
>=20
> The second patch is based on some very valuable suggestions by=20
> Sebastien Fagard <s-fagard@ti.com> and directs to modify the clock=20
> requirements for scaling to support OMAP4 and avoid clock failure issues.
>=20
> I have tested these patches on OMAP2, OMAP3 AND OMAP4. To test on 2430SDP
> board I have created a patch to enable the display which will follow late=
r.
>=20
> All your comments and suggestions are welcome.

Thanks, this looks good. Applied to DSS master branch. There was a minor
conflict with the Makefile, but I fixed that.

Btw, when doing new versions of a patch series, it would be good to have
a short history of the series in the introduction email, so that the
reviewers can easily see what's new in each version.

 Tomi


--=-WPFDQwu8dAtvXcOrbPcW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO8Ej1AAoJEPo9qoy8lh71a4QQALDcBQhyGwWFp2aCPlWcP22O
sfK+YcbZYtC/gQP6UNTRtsz/OaJoCWpsRZtDyBwhved0iyexm8QF/6j4+Ozp0oCu
pozU1oQE4hxXQNDOuDCksWZKHlFqpgfiB80a/UAva/W4NDL1GLaRgzk6kgmD4Scp
KXdafQyelTg3v4sdG+pVYrOx/Dt/3pua/FtTvkwO8VniOC5GB6i/h8j+eie1ImOp
/gol0IQrIpZkj+7VabrrM4aB9d2+kSbOPEvJlkJheFoTp8v8XMI5OdMN6OLlt8P9
r4Z4yt2IekSdsHmEhNBQKElOGI8bXbQmCCXZigFMnhXDf61GMvdmOD2sX5ym+QQN
Kk8iFOWjkWMcDq+mcDrHfLs1cJ+MOJxX62SL/MK8nM2qz9m45cIifapPIsksgcYx
yJ6KRamwTQM0GO7m+O4b7i5OcyBeRrImMANtX7ewDgya97k/cO9uSvWIncpFSw4E
85UrrArkKaFuKyThVbL37Tqam5AsQniD1QpHUjGDzBu/LLKhAH6Q7nTRTXNSn1rf
Hs/Rlglbn67hQnqHOPr2ZvtzbpnSYUax7PQ/Yl5EGaGMnOpVYM+kR8Ie1WTC1Bl/
97I/6jW17tRvQKmUXi/ib8nX8n+0csChptF+rYX9EZTb8IG4+4BPQ1hjcHHe3ufA
QLHgHQCklACrW/TKaIwg
=bv6M
-----END PGP SIGNATURE-----

--=-WPFDQwu8dAtvXcOrbPcW--

