From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 02 Jul 2015 07:17:00 +0000
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Message-Id: <5594E56C.3010908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150702070343.GD11824@pengutronix.de>
In-Reply-To: <20150702070343.GD11824@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/07/15 10:03, Uwe Kleine-K=F6nig wrote:
> Hello Boris,
>=20
> On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
>> This series adds support for atomic PWM update, or ITO, the capability=

>> to update all the parameters of a PWM device (enabled/disabled, period=
,
>> duty and polarity) in one go.
> on first reading the subject of your series I thought it was about
> asserting that the newly set config is active before the call to
> pwm_config (et al) returns. That's a problem I addressed a few times in=

> the past. I wonder if it's only me or if a different wording should be
> used for "update all parameters with a single function call".

In my vocabulary "blocking" means that the work is done before the
function returns, and "atomic" means the work is done in one step.

 Tomi


--M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVlOVvAAoJEPo9qoy8lh71/8IP/2NdbFL57DIjU27RPVnL8MZ3
tVVRIpo9hnYjmcp0SGspsO6eh4PRk+tCSDmNEHInngaEYktxbQwk3+WwN164ltgV
rCmTDr+hcmFWKfkLooJcG/CSMJb8EKux2qBY/CPLYo6mEMvEyffW4hBLfNePAGUW
aHz+lBwzTk98yje2zzl1XjYqJYJQtKmhQxG0uNviq/LU+GJW/OrwQfNFFCh5hHLC
jpCcRlGCHzOBzRja+yWDQXYMXa48dtTVtE0hITJYW4k2uJ/CQi3Mroq40MQz1Lkr
+hPSucpp/uhB8IjWhFJljuzAnLQeMTVYJHXQ+R8Z1v6556arlo6Pe7qVuIWxf2JO
YK170kSw6wI0Zyzn5QMyf98R6k1uHehc4ifmvqWt76XPA/n2vWIdAjS/gvgE0zrZ
l4iIEItCcJ7UQU+ZjPOkHTS8rZNlS/rkGg3Tq9bfwmkniZtvp3jlj7z9YyRU7fC4
6nULgHfj4S6iwKOJq7FsydtfTGhCE/lN57DHHK6D9pK90zmHBMjcuuiCzYYMaxsA
JcFIpZm+GMDkwqXUCUpGgA3tBwx2b0zM67RbRmeWSiUROPcTQg1MVgtlrHK0BBEE
kcL8Y+QQSKjtczgXyxAciucv93Fyo4OEi4uI3oCxCoSK0X9fC03a1Kbw4KZ9DP0U
Cs+3IcAuZRT2+HbXGC8e
=vGlj
-----END PGP SIGNATURE-----

--M9k8jUt8ru3AkjibFGQ7g8jL4uIcQugIR--
