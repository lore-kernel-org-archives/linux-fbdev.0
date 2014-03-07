From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Fri, 07 Mar 2014 17:54:33 +0000
Subject: Re: [PATCH] video: atmel_lcdfb: ensure the hardware is initialized with the correct mode
Message-Id: <20140307175433.GA2918@piout.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1394209254-23797-1-git-send-email-antoine.tenart@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 07/03/2014 at 17:20:54 +0100, Antoine T=E9nart wrote :
> If no driver takeover the atmel_lcdfb, the lcd won't be in a working state
> since atmel_lcdfb_set_par() will never be called. Enabling a driver which=
 does,
> like fbcon, will call the function and put atmel_lcdfb in a working state.
>=20
> Fixes: b985172b328a (video: atmel_lcdfb: add device tree suport)
>=20
> Signed-off-by: Antoine T=E9nart <antoine.tenart@free-electrons.com>
> Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/video/atmel_lcdfb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index cd96162..b74e5f5d 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -1298,6 +1298,12 @@ static int __init atmel_lcdfb_probe(struct platfor=
m_device *pdev)
>  		goto unregister_irqs;
>  	}
> =20
> +	ret =3D atmel_lcdfb_set_par(info);
> +	if (ret < 0) {
> +		dev_err(dev, "set par failed: %d\n", ret);
> +		goto unregister_irqs;
> +	}
> +
>  	dev_set_drvdata(dev, info);
> =20
>  	/*
> --=20
> 1.8.3.2
>=20

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
