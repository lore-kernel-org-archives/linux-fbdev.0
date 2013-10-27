From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sun, 27 Oct 2013 14:21:50 +0000
Subject: Re: [PATCH 1/1] backlight: hx8357: Remove redundant of_match_ptr
Message-Id: <20131027142150.GA16856@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382702373-19573-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382702373-19573-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sachin,

On Fri, Oct 25, 2013 at 05:29:33PM +0530, Sachin Kamat wrote:
> 'hx8357_dt_ids' is always compiled in. Hence of_match_ptr is
> not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSbSF+AAoJEBx+YmzsjxAgOS0QAJCkZ1J8qr3I5uQ4js6LDPM2
NVH6vPfkL1A2p38SIav/OomQroo0Dw03QYXF5K/Wx/YyQGJVHKqVqdISJ5WDNPhU
qFou5aY83EpXNv6gHdTA4OI27lLhGDQHpuplVrEdbYVRff5BvkbmpNScn3qIrN7o
WI02vESw0u9E0dY41AcHsdnOO1+6Lr4aSQlAfC327ePsYUXBSfxKgp+qnmLtTcQ5
9s4klqtRGg/W5GZrrtryEhIZKxkjc8txb9lrXi8KFD6nGi2mk/rC344uMoqnvNqz
vkmvwu8XWxEZWx1Ow9nBopfti9ftaN5gtzqre8AMBH7hK1f3WbPy2cPNZBTBcP8U
0r2HH8YH50EnQgwfKek31WKKCnO63XUPb1nAb7kKZ0dGwO/p7+GRAbc0Nv5/mKl0
/b+GCEaNSYkGqDCLrxpuF4gTGoCpR+8nVghCgGtSdgcn9R+xCGSPeu5G4T4athTq
2Mjfwyd5CbSSkZCHWpxH66xRgK4mKQ0WKqnUWb6siHg0CoG393Yr+dU2BQBmqDsx
dh6DBRDQIK7/dsAhGbvZqv7bKEeggsUYuw8CexJlH989JnjuViqw2y/HOuAFC7D8
xG8YLzSpuuDBdWSiNhyIWA+x5k8KA2eyT8RtXA99qf8nA3/0VRnhmTMCceeKFfm1
0p9DxeVSQyj+e0p4m5uu
=5M2I
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
