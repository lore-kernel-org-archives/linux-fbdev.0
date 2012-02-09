From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Feb 2012 12:02:04 +0000
Subject: Re: [PATCH] OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
Message-Id: <1328788924.1909.67.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-lBzljEpljla+Kribb0U0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1328769888-24790-1-git-send-email-archit@ti.com>
In-Reply-To: <1328769888-24790-1-git-send-email-archit@ti.com>
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org


--=-lBzljEpljla+Kribb0U0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-02-09 at 12:14 +0530, Archit Taneja wrote:
> For DSS clock domain to transition from idle to active state, it's necess=
ary
> to enable the optional clock DSS_FCLK before we enable the module using t=
he
> MODULEMODE bits in the DSS clock domain's CM_DSS_DSS_CLKCTRL register.
>=20
> This sequence was not followed correctly for the 'dss_hdmi' hwmod and it =
led
> to DSS clock domain not getting out of idle when pm_runtime_get_sync() wa=
s
> called for hdmi's platform device.
>=20
> Since the clock domain failed to change it's state to active, the hwmod c=
ode
> disables any clocks it had enabled before for this hwmod. This led to the=
 clock
> 'dss_48mhz_clk' getting disabled.
>=20
> When hdmi's runtime_resume() op is called, the call to dss_runtime_get()
> correctly enables the DSS clock domain this time. But the clock 'dss_48mh=
z_clk'
> disabled before is needed for HDMI's PHY to function. Hence, the driver f=
ails

There's something wrong with the "But the clock..." sentence above.

The patch looks good, but I think it'd be better to add brief HACK
comments in the code also. Otherwise it's too easy to forget about this.

 Tomi


--=-lBzljEpljla+Kribb0U0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPM7W8AAoJEPo9qoy8lh715iEP/iKincJFzdbym6nXvpPQUAMh
p01V9DZ9Rn7sir2BVUjSRh22PX/NUWTUGohFtGKOvCWMwS4rbnhaOgyWMnki/NEu
DljAB8qMnPv5d6boH6Py63Li8cB7M9N+pxxLXfXeaj91EhPhIkjAXm9100+iGt6X
oeFAGBalq6K7UGRJbHkxohd79NJOmwBv3UguzovbPPWt7OVv06TtOtSdNpQ6TnPW
zZ2EHkQzLRNRCOCwLAbX7zaIj67Do634joT3b5jWa9Cv/8af6eJEYtf5b6Ruz7xG
Nb9YWMmb6T5DV+oX+OQ05xROStfjPxmSqxQ7e1eABqd5aDtHJQS8medjII0yvVyF
h5LsUE9OG7YSmW76LVLRockI896rropj4lHMYQQ5qMYn+lgBNsjgY208hdZozzmu
MyPAdb4qCRnhkmpkCRxzG+2aCsdT2BX7xexfWH3rLxXPGkRnRdAmFmQWKSVOdYnD
uM3GouFTHrYPGklbEABV7ojj4rC96iifU2wO0SSnl41K9LdvBOH0UCU/yo+9TZSr
sIjMOGMbmtGG0m3+hTmg05y/wtav0QQWkbazDaQU8EOeOBuHYp6abwVqb9nkLYgx
HSnqmglLvgpEl8CuXq7mBrIHP+R+ebxTg2JxudloC93Vr/Cju3kS9Geby/UyF+r6
wh6CIJYywY+muutEVJLR
=4ryc
-----END PGP SIGNATURE-----

--=-lBzljEpljla+Kribb0U0--

