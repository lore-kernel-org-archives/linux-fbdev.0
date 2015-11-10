From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 10 Nov 2015 17:34:16 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20151110173416.GB21727@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego>
In-Reply-To: <2341981.a79ioYM9Es@diego>
To: linux-arm-kernel@lists.infradead.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 12:12:12PM +0200, Heiko St=C3=BCbner wrote:
> Hi Thierry,
>=20
> Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> > Hello,
> >=20
> > This series adds support for atomic PWM update, or IOW, the capability
> > to update all the parameters of a PWM device (enabled/disabled, period,
> > duty and polarity) in one go.
>=20
> is anything more blocking this series? It's now sitting on the lists for=
=20
> nearly a month and everybody seems happy with it, so it would be really n=
ice=20
> to have in mainline :-) .
>=20
> Especially as this also makes it possible for Rockchip Chromebooks to act=
ually=20
> control the logic-regulator that is implemented as pwm-regulator there.

Last time I tried to put this into linux-next I got immediately
bombarded by a number of build failures, so I backed things out. The
current plan is to give this another try after v4.4-rc1.

Thierry

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQiqYAAoJEN0jrNd/PrOhXB8QAKiDQLBn34IqmLnCArNIwIs7
bSYy8AS8Zk60nIIf3a08UGJ0wY45T7zKpfkbKHvMIr7yKO3PfrbwRnaF7oCcYS4I
oVPrXQjIFN4sge7YV8sNIhr0yDKpcR/dTMlpu+oQmEgRIWyZv5qDtgYcyeiEMmtV
MQB8Tro7kMCju3YMRs7gLQ1n7Rv5WA2u5WP2I1bDw/wLA4WX1d7HRbL1MmCrFSXf
qvEL8s+Oj2NUjNNal95KqIMmwv1VlT821mOu/qv3xDJ2hoHk30wmnv/W9Dz0K8Xi
JOOcj0JJCzXGOSAbEWVbNLY0t4NcL+y5fC5O1uAUp9y1yhNoN0NcVA7invPMEZNz
EqFB/KnnKnDTWTo8wjrLgZQ9ZCpocVXE4QIKu98MhpXkNycaDXi2HPFGVbaNrWGn
cnZlNv3eXFK0J886l9ceEMVqTl9EtZRCstC1WMZWOBJ6vMaTnLt2X5ogoruu22oT
TW31cMIY88vLgF8PRwBo8tKjLGoym73loLwsYOaLs1kJruaf/w/J2NV3CYlG4Xq8
rbCMiGgEblSksxBhYCTjDTKB9NBPnDAezNul4GCZ/Ry1XVRngZdWpjzleokwpp9U
S7yVSosarAi487rWfG1Mc1nuvJtvZOwH8XQQbmru/oz3UrC9WX9PTdZUY8lF3ITy
Ghu9X0RQlSMJpsx5mlof
=77fz
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
