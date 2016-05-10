From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 10:30:52 +0000
Subject: Re: [PATCHv2] fbdev: ssd1307fb: Fix charge pump setting
Message-Id: <5731B85C.7060304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="csrXIVHkJbXHis5aUa14D28SIP3UcDPO0"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--csrXIVHkJbXHis5aUa14D28SIP3UcDPO0
Content-Type: multipart/mixed; boundary="Xw3QR3MXUoiaAum6pVUh2qQnxcA6kEHco"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Julian Scheel <julian@jusst.de>, linux-fbdev@vger.kernel.org,
 plagnioj@jcrosoft.com, niederp@physik.uni-kl.de
Message-ID: <5731B85C.7060304@ti.com>
Subject: Re: [PATCHv2] fbdev: ssd1307fb: Fix charge pump setting
References: <1458854063-9118-1-git-send-email-julian@jusst.de>
In-Reply-To: <1458854063-9118-1-git-send-email-julian@jusst.de>

--Xw3QR3MXUoiaAum6pVUh2qQnxcA6kEHco
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/03/16 23:14, Julian Scheel wrote:
> Make sure bit 4 is set for the charge pump setting. It is required acco=
rding
> to SSD1306 App Note.
>=20
> Signed-off-by: Julian Scheel <julian@jusst.de>
> ---
> Changes in v2:
> - Simplify commit message
> - Use BIT macros to increase readability
> ---
>  drivers/video/fbdev/ssd1307fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index 1611215..3b9ee0c 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -389,7 +389,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par=
)
>  		return ret;
> =20
>  	ret =3D ssd1307fb_write_cmd(par->client,
> -		(par->device_info->need_chargepump & 0x1 << 2) & 0x14);
> +		BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
>  	if (ret < 0)
>  		return ret;

Thanks, queued for 4.7.

 Tomi


--Xw3QR3MXUoiaAum6pVUh2qQnxcA6kEHco--

--csrXIVHkJbXHis5aUa14D28SIP3UcDPO0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbhcAAoJEPo9qoy8lh71kYsQAJi3ENGY+zk5Tl9k7HiPqi+j
UGAMeRamrcrlguUFsR3Be0q6OIzT9WvnWbSsVFD3aSBfDhk6t0RqN9VOWMr1X08L
VGZjRJAX9dul+mhlh9fvmXro5ZJdp0pWLf6dNeBmPZUrVJsqFpdVyJ9X1B7ZbFpw
xFB0cVrgYtrnEgBd8fDkhCG3hxUBXgsdzwJErDx/1BBIjXlXFJ3zFQy/I/dSSV+S
AJ+dr9q0PuR6O6dzACPkB3HDl/Tsr0DGVbYg6L7rTaROdVo8os+Rfe+XvfRErt21
w2TsSEPckF0JEG6+m03CWstyqVJc5R8t3QhayIVczw6nb4SWqRRv/2+UFUAYOb1Q
BISXf4q+P8VrckMIHtFg9LvnobuRezPskotetgIikKUbSjx0EzqRhiUf3Qln1Ti0
gDPsc18egiQ40meduKbSf+Slg9/PUaRhWsx5r0BjHdhYX/ZBps51n1DlgmBqZBX0
S6yFl8C3jhLwr1cF/8rY+LJ1tfjzKH4MiT2kWYbDzvEkGOuEcCdj5weZAGFYQn1I
O9Y7z9yXF9f34vtG7EUdcCJ8/2NLjnEYR/8ERXqNZjp8YUNE56NQlyqr5c2WZ0Tn
XOJGzZWtHeYVKXcDuPXr2+KQ1oy1fg8tkYiX/qiFA4rG/bUfiHay6KfNnZqeF2Ve
hYikz52M8Z2KI1c3q5am
=0pz0
-----END PGP SIGNATURE-----

--csrXIVHkJbXHis5aUa14D28SIP3UcDPO0--
