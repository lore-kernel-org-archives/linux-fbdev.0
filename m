From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Sep 2014 10:24:55 +0000
Subject: Re: [PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on resume
Message-Id: <542A84F7.5020005@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="v154cAeMOHxB4umUJfjHwMu4nFGANxmso"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1411474918-2955-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org

--v154cAeMOHxB4umUJfjHwMu4nFGANxmso
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Geert, Ulf,

On 23/09/14 15:21, Geert Uytterhoeven wrote:
> When the PM domain containing the HDMI hardware block is powered down,
> the HDMI register values (incl. interrupt polarity settings) are lost.
> During resume, after powering up the PM domain, interrupts are
> re-enabled, and an interrupt storm happens due to incorrect interrupt
> polarity settings:
>=20
>     irq 163: nobody cared (try booting with the "irqpoll" option)
>     ...
>     Disabling IRQ #163
>=20
> To fix this, re-initialize the interrupt polarity settings, and the
> htop1 register block (if present), during resume.
>=20
> As the .suspend_noirq() and .resume_noirq() callbacks are not called
> when using the generic PM domain, the normal .resume() callback is used=
,
> and the device interrupt needs to be disabled/enabled manually.
>=20
> This fixes resume from s2ram with power down of the A4MP PM domain on
> r8a7740/Armadillo.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is there a specific reason why the .suspend_noirq() and .resume_noirq()=

> callbacks are not called when using genpd, unlike .suspend(),
> .suspend_late(), .resume_early(), and .resume()?
> ---
>  drivers/video/fbdev/sh_mobile_hdmi.c | 44 ++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)

Should I queue this version for 3.18, or is there some modifications you
think needs to be done first?

 Tomi



--v154cAeMOHxB4umUJfjHwMu4nFGANxmso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKoT3AAoJEPo9qoy8lh71egEQAKOC5PJR9VjvDlY1ZWsnpcgD
fh/PZHdAKEdaAPHfz2OBmK516GABAmK4vhbSNWC70MXewQt0PEObeAUb8AolpbTd
SgN/F56MFBZbfNMPtKLLXix6qb0DrDu8qLnmHyyelNyIGYGcREQuF2B+SFPjBeJn
oxdq3NwQMg0JTqKZbm7YO6lc+35nqSwkH1NdIYVMcbIhM9uqqn2XIJkoP6kIRHV6
fH4ou2NW+rnmZ0vTa7bJmYgWD+I90dnTVsNNyqtsouAd5AcTheDsw1SE6PD+4wqA
K8Z0ZjAWZeHSrZgY5Zfv7w1EoInVnAfbEjMVMrS35L8kCJfvJuufDkTcpGe7fSZ4
nzY/MpLy0Xcu2hiO+blcAkkVOtSXfao7YVLEsY5xoCZ5EHqQPVHs/owl6DsYpxzD
m/HExjLym5WIUoqpzwZJ5pubwgVvRbDWKsevwNreiGst+FyOIsok1YipSW6MH0n/
steywthE2rxYRsfvd1UzwfXVYNlMjd/t3K3dszuRWXzCxzP9i/dc0u9rzMAoJ+u7
3kjfCUeuq5hu14bDqXguHbFLdi4sdrSjFa1mSAoCLdLH4tj/eg4m0I7vlmZ3uE1N
sxfFbElXOL86H1mZ4XaA3VuMXRXwVpiS2hyt4KpDsQl0lqLWuMi9D5btDuh1OQeA
TRKl0JLQ4kj4u67n8k6X
=YGgW
-----END PGP SIGNATURE-----

--v154cAeMOHxB4umUJfjHwMu4nFGANxmso--
