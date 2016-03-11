From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 11 Mar 2016 11:22:40 +0000
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <56E2AA80.4050908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Bwe8spj5H64vH8Nuhk1PDMfK5Ld22SOBi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--Bwe8spj5H64vH8Nuhk1PDMfK5Ld22SOBi
Content-Type: multipart/mixed; boundary="7QVNLagiHdB2O2X82SnUrRmjmPro0K3nB"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <56E2AA80.4050908@ti.com>
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>

--7QVNLagiHdB2O2X82SnUrRmjmPro0K3nB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 07/03/16 21:53, Uwe Kleine-K=C3=B6nig wrote:
> This asserts that the display is on after the driver is initialized.
> Otherwise, depending on how the boot loader handled the display, it is
> either disabled as the regulator doesn't seem in use, or it stays off.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/imxfb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index c5fcedde2a60..3dd2824e6773 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -979,8 +979,17 @@ static int imxfb_probe(struct platform_device *pde=
v)
>  	imxfb_enable_controller(fbi);
>  	fbi->pdev =3D pdev;
> =20
> +	if (!IS_ERR(fbi->lcd_pwr)) {
> +		ret =3D regulator_enable(fbi->lcd_pwr);
> +		if (ret)
> +			goto failed_regulator;
> +	}
> +
>  	return 0;
> =20
> +failed_regulator:
> +	imxfb_disable_controller(fbi);
> +
>  failed_lcd:
>  	unregister_framebuffer(info);

So I didn't go through the code in detail, but this doesn't look correct
to me.

Where is the regulator disabled which now gets enabled in probe?

imxfb_lcd_set_power() handles the regulator enable/disable, so doesn't
this mean the regulator would always be enabled? You first enable it in
probe, then imxfb_lcd_set_power() enables it at some point (?), so the
enable-count is two then.

To be honest, I've never used 'struct lcd_ops', but I think the enabling
of the regulator should happen somehow via that. If the regulator needs
to be enabled at probe time, then the probe should somehow cause
lcd_ops->set_power to get called.

Why does the regulator need to be enabled at probe? Or are you saying
imxfb_lcd_set_power() is never called in your case?

 Tomi


--7QVNLagiHdB2O2X82SnUrRmjmPro0K3nB--

--Bwe8spj5H64vH8Nuhk1PDMfK5Ld22SOBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4qqAAAoJEPo9qoy8lh71Fk4P/0Qv2mKPUOTSN3Oeg41EzdcP
L8s0AxUX1dyUXBJMOlOv3uND0zyd80GoUfCY5WQw84J/3NvOx2RjANTKkWBlnier
nNI5S3CrWdf0k+FEeUYhdknEcOoel120Gqylfb3FEqfU5zAJKCLV1khxTwi2Y2M6
oTtRTlSwhvfW1Yn633L8TP+87Ay2qnudUSP64AGn/ERilf1ssSXs+ohcnoa1WDLX
AVTa3QzMbuB7Z5NCbMmvKeBFaAZAUgrV010dbbcDBWRZOcVLx/pqIVw4jibWLz3q
lmwLrwZ3Pfp8MjGN50ZHLpSj5fHHnoGYj11BT5kXsAZJQi3z6Gh/PpaPiylNLHeq
0mFPbqcaiIvrdp9OSw1leLfTEToVE6VbS0HUgHIKossooiJCYJnKyp0+3ll6A6hj
lBzxcBuuy+urIyBFPeUZL+HGONMyQqZE/mXMvBh4n1x2Yeqn/UU4XHVlGSvY3qdv
84es3A5HA1/jawCxH7rueO5qLN13G4zRWwtsVL4NMQaS7ddTvkpiKOir4pWbCK5b
5igU77Qt2ssoJD9ZoLCqwAAIXAmPAT+oD589AmUF53HCAhpfbnjajiwSkKerkWbZ
b/5Co7TmnDG9BvKFwUI6x3fblyE/zA23wnTo12AzBkvSSy/YybxHcX3znf42rBc3
sZx2+khauTxF/s4aWTFQ
=NXJ9
-----END PGP SIGNATURE-----

--Bwe8spj5H64vH8Nuhk1PDMfK5Ld22SOBi--
