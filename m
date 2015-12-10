From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 15:24:10 +0000
Subject: Re: [PATCH RESEND] fbdev: Make fb-notify a no-op if CONFIG_FB=n
Message-Id: <5669991A.3050301@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MI0pQWR7pogOhTrjNBLaoCE5t3tFllqWJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <1448421108-3437-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-fbdev@vger.kernel.org

--MI0pQWR7pogOhTrjNBLaoCE5t3tFllqWJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 07/12/15 18:14, Ezequiel Garcia wrote:

>> Actually, looks like fb_notify.c was originally made to solve the same=

>> problem as your patch solves, but by separating the notify code from t=
he
>> main fbdev code. So I still wonder, was there some reason to keep the
>> notification code built instead of having stub functions.
>>
>> Any thoughts?
>>
>=20
> I can't see any valid reason to keep the code around, since there's no
> way it can be used.
> Let's see if Ccing Antonino and Andrew -as per that commit- helps.

Ok. This looks fine to me, so I'll queue it for 4.5.

 Tomi


--MI0pQWR7pogOhTrjNBLaoCE5t3tFllqWJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWaZkaAAoJEPo9qoy8lh71qsoQAI2WW2jXaRslhEMbMnVSdN9t
oT9hi4UDp5K/y9hJC6s2zmfpPgSQG1w2yZtCmNM2of3rkZbE3m9rwW4qMH3u/9Ul
SOSa4PvMWpB0DD2d0ty2NPMNjQfmJKnpFKu3uzRsEn1Hvw4cn8xQMLZ0AWKQitPG
NtpCfvLsSnmsmwWmiQQovYDWc3aGDli7d4fTq8IwJVpms9G/VKevhCXv6QyMWJMD
Y9Bx1H9Xp7Yu95qE8B7rvGokvWgIHaX81FL6/pbXuZdkhJJ6xx5Go9MBn9J5s0wI
SDQdjDD4SS+zq2S/XBmUIweDfJ58O4+FunSRpkYc2GzMk236TuVou16DYwLWdCEq
wPd2pHJRhTWPgYc2awC1re+FhI+8IH0U/PDWz/3O9A0QfChAM0TYPIb/koDNa6di
xVtmfkwQjOYZZxUuVGt7FF41WZfYZ4cZo/w/P9lffZH1fqDDP4n1LWSJ9n8rYCj1
QqIWSm3eT1Ls0QoIFfUmPW0wloul38d3hQo5ec8IzL/Lxh2vk6aK8DBgqmh5u0S9
vBAfbpfyb+soQ4ir89AgupqYEJwm6bVRPQzERlbBihjPnOFu9Jgj/2RX15xyGGSd
d7AzI9TmNiEDKfqUmpDgcdLdvLylS5O0C8DMhCPygLZC0/Wx6SyVaOxNzvkIWoZd
jZVTHcUk+xjurlZ9fFKo
=vOhX
-----END PGP SIGNATURE-----

--MI0pQWR7pogOhTrjNBLaoCE5t3tFllqWJ--
