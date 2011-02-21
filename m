From: Jason Chen <weitway@gmail.com>
Date: Mon, 21 Feb 2011 05:38:32 +0000
Subject: Re: [PATCH 1/7] Add a mfd IPUv3 driver
Message-Id: <AANLkTinQrXUwyRjehLr4YFiR66CRxT8ocEQMLXOEzHJx@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297865452-32181-1-git-send-email-s.hauer@pengutronix.de>
	<1297865452-32181-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1297865452-32181-2-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

hi, Sascha,

I have few comments for this patch.

> +#define MX51_IPU_CHANNEL_CSI0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define MX51_IPU_CHANNEL_CSI1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define MX51_IPU_CHANNEL_CSI2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
> +#define MX51_IPU_CHANNEL_CSI3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3
> +#define MX51_IPU_CHANNEL_MEM_BG_SYNC =A0 =A0 =A0 =A0 =A0 23
> +#define MX51_IPU_CHANNEL_MEM_FG_SYNC =A0 =A0 =A0 =A0 =A0 27
> +#define MX51_IPU_CHANNEL_MEM_DC_SYNC =A0 =A0 =A0 =A0 =A0 28
> +#define MX51_IPU_CHANNEL_MEM_FG_SYNC_ALPHA =A0 =A0 31
> +#define MX51_IPU_CHANNEL_MEM_DC_ASYNC =A0 =A0 =A0 =A0 =A041
> +#define MX51_IPU_CHANNEL_ROT_ENC_MEM =A0 =A0 =A0 =A0 =A0 45
> +#define MX51_IPU_CHANNEL_ROT_VF_MEM =A0 =A0 =A0 =A0 =A0 =A046
> +#define MX51_IPU_CHANNEL_ROT_PP_MEM =A0 =A0 =A0 =A0 =A0 =A047
> +#define MX51_IPU_CHANNEL_ROT_ENC_MEM_OUT =A0 =A0 =A0 48
> +#define MX51_IPU_CHANNEL_ROT_VF_MEM_OUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A049
> +#define MX51_IPU_CHANNEL_ROT_PP_MEM_OUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A050
> +#define MX51_IPU_CHANNEL_MEM_BG_SYNC_ALPHA =A0 =A0 51
Had better use MX5_IPU as prefix because it's same value in MX5X.

> +
> + =A0 =A0 =A0 ipu_idmac_reg =3D ioremap(ipu_base + IPU_IDMAC_REG_BASE, PA=
GE_SIZE);
> + =A0 =A0 =A0 if (!ipu_idmac_reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_ioremap2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D ipu_mipi_setup();
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_mipi_setup;
I dont know what's the best way to do it, but I think you had better
consider mx53 platform, so maybe this mipi_setup function and also
below ipu hw reset could be set in platform data.
> +
> + =A0 =A0 =A0 ipu_clk =3D clk_get(&pdev->dev, "ipu");
> + =A0 =A0 =A0 if (IS_ERR(ipu_clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(ipu_clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "clk_get failed with %d=
", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_clk_get;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ipu_get();
> +
> + =A0 =A0 =A0 ret =3D request_irq(irq1, ipu_irq_handler, IRQF_DISABLED, p=
dev->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pdev->dev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request irq %d failed =
with: %d\n", irq1, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_request_irq1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D request_irq(irq2, ipu_irq_handler, IRQF_DISABLED, p=
dev->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pdev->dev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request irq %d failed =
with: %d\n", irq2, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_request_irq2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ipu_reset();
