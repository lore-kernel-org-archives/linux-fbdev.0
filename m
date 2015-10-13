From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 13 Oct 2015 08:15:35 +0000
Subject: Re: [PATCH 1/5] backlight: 88pm860x_bl: add missing of_node_put
Message-Id: <20151013081535.GB17172@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-2-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1444480254-14399-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jingoo Han <jingoohan1@gmail.com>, kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>

On Sat, 10 Oct 2015, Julia Lawall wrote:

> for_each_child_of_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
>=20
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>=20
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> iterator name for_each_child_of_node;
> @@
>=20
>  for_each_child_of_node(root, child) {
>    ... when !=3D of_node_put(child)
>        when !=3D e =3D child
> +  of_node_put(child);
> ?  break;
>    ...
> }
> ... when !=3D child
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/video/backlight/88pm860x_bl.c |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backli=
ght/88pm860x_bl.c
> index 2da5862..6d8dc2c 100644
> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -180,6 +180,7 @@ static int pm860x_backlight_dt_init(struct platform_d=
evice *pdev,
>  			data->iset =3D PM8606_WLED_CURRENT(iset);
>  			of_property_read_u32(np, "marvell,88pm860x-pwm",
>  					     &data->pwm);
> +			of_node_put(np);
>  			break;
>  		}
>  	}
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
