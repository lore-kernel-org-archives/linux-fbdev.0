From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:16:16 +0000
Subject: Re: [PATCH 1/8] pxa: support pxa168 LCD controller SPI operation
Message-Id: <7c34ac520911111816q22dcf293r98d67a588bf83913@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001636e8ffcfd5f5e704782320c8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012s3504b2ek75670ecb057692a7@mail.gmail.com>
In-Reply-To: <7c34ac520911100012s3504b2ek75670ecb057692a7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--001636e8ffcfd5f5e704782320c8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From fbdcfdc7877f2e6030a0ae5f6738a07e35fc6757 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 10:01:03 +0800
> Subject: [PATCH] pxa: support pxa168 LCD controller SPI operation
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0drivers/video/pxa168fb.c | =A0 81 ++++++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/video/pxa168fb.h | =A0 24 +-------------
> =A0include/video/pxa168fb.h | =A0 44 +++++++++++++++++++++++++
> =A03 files changed, 126 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 84d8327..e1f1c5f 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -27,12 +27,90 @@
> =A0#include <linux/clk.h>
> =A0#include <linux/err.h>
> =A0#include <linux/uaccess.h>
> +#include <linux/gpio.h>
> =A0#include <video/pxa168fb.h>
>
> +#include <mach/gpio.h>
> =A0#include "pxa168fb.h"
>
> =A0#define DEFAULT_REFRESH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A060 =A0 =A0 =A0/=
* Hz */
>
> +static inline void spi_gpio_assert(int spi_gpio_cs, int val)
> +{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(spi_gpio_cs))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 gpio_set_value(spi_gpio_cs, val);
> +}
> +
> +int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int spi_gpio_cs, unsigned int cs_a=
ctive, unsigned int interval_us)
> +{
> + =A0 =A0 =A0 u32 x, spi_byte_len;
> + =A0 =A0 =A0 u8 *cmd =3D (u8 *)value;
> + =A0 =A0 =A0 int i, isr, iopad, ret =3D 0;
> +
> + =A0 =A0 =A0 if (gpio_is_valid(spi_gpio_cs)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_direction_output(spi_gpio_cs, =
!cs_active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto spi_exit;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spi_byte_len =3D readl(fbi->reg_base + LCD_SPU_SPI_CTRL);
> + =A0 =A0 =A0 spi_byte_len =3D (spi_byte_len >> 8) & 0xff;
> + =A0 =A0 =A0 /* Alignment should be (spi_byte_len + 7) >> 3, but
> + =A0 =A0 =A0 =A0* spi controller request set one less than bit length */
> + =A0 =A0 =A0 spi_byte_len =3D (spi_byte_len + 8) >> 3;
> + =A0 =A0 =A0 /* spi command provided by platform should be 1, 2, or 4 by=
te aligned */
> + =A0 =A0 =A0 if(3 =3D=3D spi_byte_len)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_byte_len =3D 4;
> +
> + =A0 =A0 =A0 iopad =3D readl(fbi->reg_base + SPU_IOPAD_CONTROL);
> + =A0 =A0 =A0 if ((iopad & CFG_IOPADMODE_MASK) !=3D PIN_MODE_DUMB_18_SPI)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(PIN_MODE_DUMB_18_SPI, fbi->reg_base =
+ SPU_IOPAD_CONTROL);
> + =A0 =A0 =A0 isr =3D readl(fbi->reg_base + SPU_IRQ_ISR);
> + =A0 =A0 =A0 writel((isr & ~SPI_IRQ_ENA_MASK), fbi->reg_base + SPU_IRQ_I=
SR);
> + =A0 =A0 =A0 for (i =3D 0; i < count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_gpio_assert(spi_gpio_cs, cs_active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(interval_us);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (spi_byte_len){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(*cmd, fbi->reg_base =
+ LCD_SPU_SPI_TXDATA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(*(u16*)cmd, fbi->reg=
_base + LCD_SPU_SPI_TXDATA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(*(u32*)cmd, fbi->reg=
_base + LCD_SPU_SPI_TXDATA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(fbi->dev, "Wrong sp=
i bit length\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_gpio_assert(spi_gpio_cs=
, !cs_active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto spi_exit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd +=3D spi_byte_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D readl(fbi->reg_base + LCD_SPU_SPI_CTR=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x |=3D CFG_SPI_START_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr =3D readl(fbi->reg_base + SPU_IRQ_ISR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while(!(isr & SPI_IRQ_ENA_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr =3D readl(fbi->reg_base=
 + SPU_IRQ_ISR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D readl(fbi->reg_base + LCD_SPU_SPI_CTR=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x &=3D ~CFG_SPI_START_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_gpio_assert(spi_gpio_cs, !cs_active);
> + =A0 =A0 =A0 }
> +
> +spi_exit:
> + =A0 =A0 =A0 if (gpio_is_valid(spi_gpio_cs))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(spi_gpio_cs);
> + =A0 =A0 =A0 if ((iopad & CFG_IOPADMODE_MASK) !=3D PIN_MODE_DUMB_18_SPI)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(iopad, fbi->reg_base + SPU_IOPAD_CON=
TROL);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(pxa168fb_spi_send);
> +
> =A0static int determine_best_pix_fmt(struct fb_var_screeninfo *var)
> =A0{
> =A0 =A0 =A0 =A0/*
> @@ -728,6 +806,9 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0writel(0, fbi->reg_base + LCD_SPU_SRAM_PARA0);
> =A0 =A0 =A0 =A0writel(CFG_CSB_256x32(0x1)|CFG_CSB_256x24(0x1)|CFG_CSB_256=
x8(0x1),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fbi->reg_base + LCD_SPU_SRAM_PARA1);
> + =A0 =A0 =A0 if ((mi->spi_ctrl !=3D -1) && (mi->spi_ctrl & CFG_SPI_ENA_M=
ASK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(mi->spi_ctrl, fbi->reg_base + LCD_SP=
U_SPI_CTRL);
> +
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Allocate color map.
> diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
> index eee0927..55ec4dc 100644
> --- a/drivers/video/pxa168fb.h
> +++ b/drivers/video/pxa168fb.h
> @@ -170,29 +170,7 @@
> =A0#define =A0 =A0 DMA_FRAME_CNT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000003 =A0/* Video */
>
> =A0/* SPI Control Register. */
> -#define LCD_SPU_SPI_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
180
> -#define =A0 =A0 CFG_SCLKCNT(div) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((d=
iv) << 24) =A0/* 0xFF~0x2 */
> -#define =A0 =A0 CFG_SCLKCNT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xF=
F000000
> -#define =A0 =A0 CFG_RXBITS(rx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
(rx) << 16) =A0 /* 0x1F~0x1 */
> -#define =A0 =A0 CFG_RXBITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00FF0000
> -#define =A0 =A0 CFG_TXBITS(tx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
(tx) << 8) =A0 =A0/* 0x1F~0x1 */
> -#define =A0 =A0 CFG_TXBITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x0000FF00
> -#define =A0 =A0 CFG_CLKINV(clk) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
(clk) << 7)
> -#define =A0 =A0 CFG_CLKINV_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00000080
> -#define =A0 =A0 CFG_KEEPXFER(transfer) =A0 =A0 =A0 =A0 =A0 =A0 ((transfe=
r) << 6)
> -#define =A0 =A0 CFG_KEEPXFER_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
0000040
> -#define =A0 =A0 CFG_RXBITSTO0(rx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((r=
x) << 5)
> -#define =A0 =A0 CFG_RXBITSTO0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00020
> -#define =A0 =A0 CFG_TXBITSTO0(tx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((t=
x) << 4)
> -#define =A0 =A0 CFG_TXBITSTO0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00010
> -#define =A0 =A0 CFG_SPI_ENA(spi) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((s=
pi) << 3)
> -#define =A0 =A0 CFG_SPI_ENA_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000008
> -#define =A0 =A0 CFG_SPI_SEL(spi) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((s=
pi) << 2)
> -#define =A0 =A0 CFG_SPI_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000004
> -#define =A0 =A0 CFG_SPI_3W4WB(wire) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0((wire) << 1)
> -#define =A0 =A0 CFG_SPI_3W4WB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00002
> -#define =A0 =A0 CFG_SPI_START(start) =A0 =A0 =A0 =A0 =A0 =A0 =A0 (start)
> -#define =A0 =A0 CFG_SPI_START_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00001
> +/* For SPI register, please refer to include/video/pxa168fb.h */
>
> =A0/* SPI Tx Data Register */
> =A0#define LCD_SPU_SPI_TXDATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
184
> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> index b5cc72f..024767c 100644
> --- a/include/video/pxa168fb.h
> +++ b/include/video/pxa168fb.h
> @@ -14,6 +14,31 @@
> =A0#include <linux/fb.h>
> =A0#include <linux/interrupt.h>
>
> +/* SPI Control Register. */
> +#define LCD_SPU_SPI_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
180
> +#define =A0 =A0 CFG_SCLKCNT(div) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((d=
iv) << 24) =A0/* 0xFF~0x2 */
> +#define =A0 =A0 CFG_SCLKCNT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xF=
F000000
> +#define =A0 =A0 CFG_RXBITS(rx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (=
(rx - 1) << 16) =A0 /* 0x1F~0x1, 0x1:
> 2bits ... 0x1F: 32bits */
> +#define =A0 =A0 CFG_RXBITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00FF0000
> +#define =A0 =A0 CFG_TXBITS(tx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0((tx - 1) << 8) =A0 =A0/*
> 0x1F~0x1, 0x1: 2bits ... 0x1F: 32bits */
> +#define =A0 =A0 CFG_TXBITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x0000FF00
> +#define =A0 =A0 CFG_CLKINV(clk) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
(clk) << 7)
> +#define =A0 =A0 CFG_CLKINV_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00000080
> +#define =A0 =A0 CFG_KEEPXFER(transfer) =A0 =A0 =A0 =A0 =A0 =A0 ((transfe=
r) << 6)
> +#define =A0 =A0 CFG_KEEPXFER_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
0000040
> +#define =A0 =A0 CFG_RXBITSTO0(rx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((r=
x) << 5)
> +#define =A0 =A0 CFG_RXBITSTO0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00020
> +#define =A0 =A0 CFG_TXBITSTO0(tx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((t=
x) << 4)
> +#define =A0 =A0 CFG_TXBITSTO0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00010
> +#define =A0 =A0 CFG_SPI_ENA(spi) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((s=
pi) << 3)
> +#define =A0 =A0 CFG_SPI_ENA_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000008
> +#define =A0 =A0 CFG_SPI_SEL(spi) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((s=
pi) << 2) =A0 =A0/* 1: port1; 0: port0 */
> +#define =A0 =A0 CFG_SPI_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000004
> +#define =A0 =A0 CFG_SPI_3W4WB(wire) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((wi=
re)<<1) =A0/* 1:
> 3-wire; 0: 4-wire */
> +#define =A0 =A0 CFG_SPI_3W4WB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00002
> +#define =A0 =A0 CFG_SPI_START(start) =A0 =A0 =A0 =A0 =A0 =A0 =A0 (start)
> +#define =A0 =A0 CFG_SPI_START_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00001
> +
> =A0/* Dumb interface */
> =A0#define PIN_MODE_DUMB_24 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> =A0#define PIN_MODE_DUMB_18_SPI =A0 =A0 =A0 =A0 =A0 1
> @@ -122,6 +147,25 @@ struct pxa168fb_mach_info {
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0panel_rbswap:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0active:1;
> =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0enable_lcd:1;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* SPI control
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 unsigned int =A0 =A0spi_ctrl;
> + =A0 =A0 =A0 unsigned int =A0 =A0spi_gpio_cs;
> + =A0 =A0 =A0 unsigned int =A0 =A0spi_gpio_reset;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* power on/off function.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int (*pxa168fb_lcd_power)(struct pxa168fb_info *, unsigned =
int,
> unsigned int, int);
> =A0};
>
> +/* SPI utility for configure panel SPI command.
> + * value: command array, element should be 1, 2 or 4 byte aligned.
> + * count: command array length
> + * spi_gpio_cs: gpio number for spi chip select
> + * cs_active: CS active polarity for SPI transaction
> + * interval_us: time interval between two commands, us as unit */
> +int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int spi_gpio_cs,unsigned int cs_ac=
tive, unsigned int interval_us);
> +
> =A0#endif /* __ASM_MACH_PXA168FB_H */
> --
> 1.5.4.3
>

patch attached.

--001636e8ffcfd5f5e704782320c8
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-pxa-support-pxa168-LCD-controller-SPI-operation.patch"
Content-Disposition: attachment; 
	filename="0001-pxa-support-pxa168-LCD-controller-SPI-operation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1wvznz30

RnJvbSBmYmRjZmRjNzg3N2YyZTYwMzBhMGFlNWY2NzM4YTA3ZTM1ZmM2NzU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDEwOjAxOjAzICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBzdXBwb3J0
IHB4YTE2OCBMQ0QgY29udHJvbGxlciBTUEkgb3BlcmF0aW9uCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYyB8ICAg
ODEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVy
cy92aWRlby9weGExNjhmYi5oIHwgICAyNCArLS0tLS0tLS0tLS0tLQogaW5jbHVkZS92aWRlby9w
eGExNjhmYi5oIHwgICA0NCArKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5n
ZWQsIDEyNiBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpZGVvL3B4YTE2OGZiLmMgYi9kcml2ZXJzL3ZpZGVvL3B4YTE2OGZiLmMKaW5kZXggODRk
ODMyNy4uZTFmMWM1ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9weGExNjhmYi5jCisrKyBi
L2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuYwpAQCAtMjcsMTIgKzI3LDkwIEBACiAjaW5jbHVkZSA8
bGludXgvY2xrLmg+CiAjaW5jbHVkZSA8bGludXgvZXJyLmg+CiAjaW5jbHVkZSA8bGludXgvdWFj
Y2Vzcy5oPgorI2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4KICNpbmNsdWRlIDx2aWRlby9weGExNjhm
Yi5oPgogCisjaW5jbHVkZSA8bWFjaC9ncGlvLmg+CiAjaW5jbHVkZSAicHhhMTY4ZmIuaCIKIAog
I2RlZmluZSBERUZBVUxUX1JFRlJFU0gJCTYwCS8qIEh6ICovCiAKK3N0YXRpYyBpbmxpbmUgdm9p
ZCBzcGlfZ3Bpb19hc3NlcnQoaW50IHNwaV9ncGlvX2NzLCBpbnQgdmFsKQoreworCSAgICAgICBp
ZiAoZ3Bpb19pc192YWxpZChzcGlfZ3Bpb19jcykpCisJCSAgICAgICAgICAgICAgICAgICAgICBn
cGlvX3NldF92YWx1ZShzcGlfZ3Bpb19jcywgdmFsKTsKK30KKworaW50IHB4YTE2OGZiX3NwaV9z
ZW5kKHN0cnVjdCBweGExNjhmYl9pbmZvICpmYmksIHZvaWQgKnZhbHVlLCBpbnQgY291bnQsCisJ
CXVuc2lnbmVkIGludCBzcGlfZ3Bpb19jcywgdW5zaWduZWQgaW50IGNzX2FjdGl2ZSwgdW5zaWdu
ZWQgaW50IGludGVydmFsX3VzKQoreworCXUzMiB4LCBzcGlfYnl0ZV9sZW47CisJdTggKmNtZCA9
ICh1OCAqKXZhbHVlOworCWludCBpLCBpc3IsIGlvcGFkLCByZXQgPSAwOworCisJaWYgKGdwaW9f
aXNfdmFsaWQoc3BpX2dwaW9fY3MpKSB7CisJCXJldCA9IGdwaW9fZGlyZWN0aW9uX291dHB1dChz
cGlfZ3Bpb19jcywgIWNzX2FjdGl2ZSk7CisJCWlmKHJldCkKKwkJCWdvdG8gc3BpX2V4aXQ7CisJ
fQorCXNwaV9ieXRlX2xlbiA9IHJlYWRsKGZiaS0+cmVnX2Jhc2UgKyBMQ0RfU1BVX1NQSV9DVFJM
KTsKKwlzcGlfYnl0ZV9sZW4gPSAoc3BpX2J5dGVfbGVuID4+IDgpICYgMHhmZjsKKwkvKiBBbGln
bm1lbnQgc2hvdWxkIGJlIChzcGlfYnl0ZV9sZW4gKyA3KSA+PiAzLCBidXQgCisJICogc3BpIGNv
bnRyb2xsZXIgcmVxdWVzdCBzZXQgb25lIGxlc3MgdGhhbiBiaXQgbGVuZ3RoICovCisJc3BpX2J5
dGVfbGVuID0gKHNwaV9ieXRlX2xlbiArIDgpID4+IDM7CisJLyogc3BpIGNvbW1hbmQgcHJvdmlk
ZWQgYnkgcGxhdGZvcm0gc2hvdWxkIGJlIDEsIDIsIG9yIDQgYnl0ZSBhbGlnbmVkICovCisJaWYo
MyA9PSBzcGlfYnl0ZV9sZW4pCisJCXNwaV9ieXRlX2xlbiA9IDQ7CisKKwlpb3BhZCA9IHJlYWRs
KGZiaS0+cmVnX2Jhc2UgKyBTUFVfSU9QQURfQ09OVFJPTCk7CisJaWYgKChpb3BhZCAmIENGR19J
T1BBRE1PREVfTUFTSykgIT0gUElOX01PREVfRFVNQl8xOF9TUEkpCisJCXdyaXRlbChQSU5fTU9E
RV9EVU1CXzE4X1NQSSwgZmJpLT5yZWdfYmFzZSArIFNQVV9JT1BBRF9DT05UUk9MKTsKKwlpc3Ig
PSByZWFkbChmYmktPnJlZ19iYXNlICsgU1BVX0lSUV9JU1IpOworCXdyaXRlbCgoaXNyICYgflNQ
SV9JUlFfRU5BX01BU0spLCBmYmktPnJlZ19iYXNlICsgU1BVX0lSUV9JU1IpOworCWZvciAoaSA9
IDA7IGkgPCBjb3VudDsgaSsrKSB7CisJCXNwaV9ncGlvX2Fzc2VydChzcGlfZ3Bpb19jcywgY3Nf
YWN0aXZlKTsKKwkJdWRlbGF5KGludGVydmFsX3VzKTsKKwkJc3dpdGNoIChzcGlfYnl0ZV9sZW4p
eworCQljYXNlIDE6CisJCQl3cml0ZWwoKmNtZCwgZmJpLT5yZWdfYmFzZSArIExDRF9TUFVfU1BJ
X1RYREFUQSk7CisJCQlicmVhazsKKwkJY2FzZSAyOgorCQkJd3JpdGVsKCoodTE2KiljbWQsIGZi
aS0+cmVnX2Jhc2UgKyBMQ0RfU1BVX1NQSV9UWERBVEEpOworCQkJYnJlYWs7CisJCWNhc2UgNDoK
KwkJCXdyaXRlbCgqKHUzMiopY21kLCBmYmktPnJlZ19iYXNlICsgTENEX1NQVV9TUElfVFhEQVRB
KTsKKwkJCWJyZWFrOworCQlkZWZhdWx0OgorCQkJZGV2X2VycihmYmktPmRldiwgIldyb25nIHNw
aSBiaXQgbGVuZ3RoXG4iKTsKKwkJCXNwaV9ncGlvX2Fzc2VydChzcGlfZ3Bpb19jcywgIWNzX2Fj
dGl2ZSk7CisJCQlyZXQgPSAtRUlOVkFMOworCQkJZ290byBzcGlfZXhpdDsKKwkJfQorCQljbWQg
Kz0gc3BpX2J5dGVfbGVuOworCQl4ID0gcmVhZGwoZmJpLT5yZWdfYmFzZSArIExDRF9TUFVfU1BJ
X0NUUkwpOworCQl4IHw9IENGR19TUElfU1RBUlRfTUFTSzsKKwkJd3JpdGVsKHgsIGZiaS0+cmVn
X2Jhc2UgKyBMQ0RfU1BVX1NQSV9DVFJMKTsKKwkJaXNyID0gcmVhZGwoZmJpLT5yZWdfYmFzZSAr
IFNQVV9JUlFfSVNSKTsKKwkJd2hpbGUoIShpc3IgJiBTUElfSVJRX0VOQV9NQVNLKSkgeworCQkJ
dWRlbGF5KDEpOworCQkJaXNyID0gcmVhZGwoZmJpLT5yZWdfYmFzZSArIFNQVV9JUlFfSVNSKTsK
KwkJfQorCQl4ID0gcmVhZGwoZmJpLT5yZWdfYmFzZSArIExDRF9TUFVfU1BJX0NUUkwpOworCQl4
ICY9IH5DRkdfU1BJX1NUQVJUX01BU0s7CisJCXdyaXRlbCh4LCBmYmktPnJlZ19iYXNlICsgTENE
X1NQVV9TUElfQ1RSTCk7CisJCXNwaV9ncGlvX2Fzc2VydChzcGlfZ3Bpb19jcywgIWNzX2FjdGl2
ZSk7CisJfQorCitzcGlfZXhpdDoKKwlpZiAoZ3Bpb19pc192YWxpZChzcGlfZ3Bpb19jcykpCisJ
CWdwaW9fZGlyZWN0aW9uX2lucHV0KHNwaV9ncGlvX2NzKTsKKwlpZiAoKGlvcGFkICYgQ0ZHX0lP
UEFETU9ERV9NQVNLKSAhPSBQSU5fTU9ERV9EVU1CXzE4X1NQSSkKKwkJd3JpdGVsKGlvcGFkLCBm
YmktPnJlZ19iYXNlICsgU1BVX0lPUEFEX0NPTlRST0wpOworCisJcmV0dXJuIHJldDsKK30KK0VY
UE9SVF9TWU1CT0wocHhhMTY4ZmJfc3BpX3NlbmQpOworCiBzdGF0aWMgaW50IGRldGVybWluZV9i
ZXN0X3BpeF9mbXQoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIpCiB7CiAJLyoKQEAgLTcy
OCw2ICs4MDYsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBweGExNjhmYl9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogCXdyaXRlbCgwLCBmYmktPnJlZ19iYXNlICsgTENEX1NQVV9T
UkFNX1BBUkEwKTsKIAl3cml0ZWwoQ0ZHX0NTQl8yNTZ4MzIoMHgxKXxDRkdfQ1NCXzI1NngyNCgw
eDEpfENGR19DU0JfMjU2eDgoMHgxKSwKIAkJZmJpLT5yZWdfYmFzZSArIExDRF9TUFVfU1JBTV9Q
QVJBMSk7CisJaWYgKChtaS0+c3BpX2N0cmwgIT0gLTEpICYmIChtaS0+c3BpX2N0cmwgJiBDRkdf
U1BJX0VOQV9NQVNLKSkKKwkJd3JpdGVsKG1pLT5zcGlfY3RybCwgZmJpLT5yZWdfYmFzZSArIExD
RF9TUFVfU1BJX0NUUkwpOworCiAKIAkvKgogCSAqIEFsbG9jYXRlIGNvbG9yIG1hcC4KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIuaCBiL2RyaXZlcnMvdmlkZW8vcHhhMTY4ZmIu
aAppbmRleCBlZWUwOTI3Li41NWVjNGRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL3B4YTE2
OGZiLmgKKysrIGIvZHJpdmVycy92aWRlby9weGExNjhmYi5oCkBAIC0xNzAsMjkgKzE3MCw3IEBA
CiAjZGVmaW5lICAgICBETUFfRlJBTUVfQ05UX01BU0sJCQkweDAwMDAwMDAzICAvKiBWaWRlbyAq
LwogCiAvKiBTUEkgQ29udHJvbCBSZWdpc3Rlci4gKi8KLSNkZWZpbmUgTENEX1NQVV9TUElfQ1RS
TAkJCTB4MDE4MAotI2RlZmluZSAgICAgQ0ZHX1NDTEtDTlQoZGl2KQkJCSgoZGl2KSA8PCAyNCkg
IC8qIDB4RkZ+MHgyICovCi0jZGVmaW5lICAgICBDRkdfU0NMS0NOVF9NQVNLCQkJMHhGRjAwMDAw
MAotI2RlZmluZSAgICAgQ0ZHX1JYQklUUyhyeCkJCQkoKHJ4KSA8PCAxNikgICAvKiAweDFGfjB4
MSAqLwotI2RlZmluZSAgICAgQ0ZHX1JYQklUU19NQVNLCQkJMHgwMEZGMDAwMAotI2RlZmluZSAg
ICAgQ0ZHX1RYQklUUyh0eCkJCQkoKHR4KSA8PCA4KSAgICAvKiAweDFGfjB4MSAqLwotI2RlZmlu
ZSAgICAgQ0ZHX1RYQklUU19NQVNLCQkJMHgwMDAwRkYwMAotI2RlZmluZSAgICAgQ0ZHX0NMS0lO
VihjbGspCQkJKChjbGspIDw8IDcpCi0jZGVmaW5lICAgICBDRkdfQ0xLSU5WX01BU0sJCQkweDAw
MDAwMDgwCi0jZGVmaW5lICAgICBDRkdfS0VFUFhGRVIodHJhbnNmZXIpCQkoKHRyYW5zZmVyKSA8
PCA2KQotI2RlZmluZSAgICAgQ0ZHX0tFRVBYRkVSX01BU0sJCQkweDAwMDAwMDQwCi0jZGVmaW5l
ICAgICBDRkdfUlhCSVRTVE8wKHJ4KQkJCSgocngpIDw8IDUpCi0jZGVmaW5lICAgICBDRkdfUlhC
SVRTVE8wX01BU0sJCQkweDAwMDAwMDIwCi0jZGVmaW5lICAgICBDRkdfVFhCSVRTVE8wKHR4KQkJ
CSgodHgpIDw8IDQpCi0jZGVmaW5lICAgICBDRkdfVFhCSVRTVE8wX01BU0sJCQkweDAwMDAwMDEw
Ci0jZGVmaW5lICAgICBDRkdfU1BJX0VOQShzcGkpCQkJKChzcGkpIDw8IDMpCi0jZGVmaW5lICAg
ICBDRkdfU1BJX0VOQV9NQVNLCQkJMHgwMDAwMDAwOAotI2RlZmluZSAgICAgQ0ZHX1NQSV9TRUwo
c3BpKQkJCSgoc3BpKSA8PCAyKQotI2RlZmluZSAgICAgQ0ZHX1NQSV9TRUxfTUFTSwkJCTB4MDAw
MDAwMDQKLSNkZWZpbmUgICAgIENGR19TUElfM1c0V0Iod2lyZSkJCQkoKHdpcmUpIDw8IDEpCi0j
ZGVmaW5lICAgICBDRkdfU1BJXzNXNFdCX01BU0sJCQkweDAwMDAwMDAyCi0jZGVmaW5lICAgICBD
RkdfU1BJX1NUQVJUKHN0YXJ0KQkJKHN0YXJ0KQotI2RlZmluZSAgICAgQ0ZHX1NQSV9TVEFSVF9N
QVNLCQkJMHgwMDAwMDAwMQorLyogRm9yIFNQSSByZWdpc3RlciwgcGxlYXNlIHJlZmVyIHRvIGlu
Y2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaCAqLwogCiAvKiBTUEkgVHggRGF0YSBSZWdpc3RlciAqLwog
I2RlZmluZSBMQ0RfU1BVX1NQSV9UWERBVEEJCQkweDAxODQKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dmlkZW8vcHhhMTY4ZmIuaCBiL2luY2x1ZGUvdmlkZW8vcHhhMTY4ZmIuaAppbmRleCBiNWNjNzJm
Li4wMjQ3NjdjIDEwMDY0NAotLS0gYS9pbmNsdWRlL3ZpZGVvL3B4YTE2OGZiLmgKKysrIGIvaW5j
bHVkZS92aWRlby9weGExNjhmYi5oCkBAIC0xNCw2ICsxNCwzMSBAQAogI2luY2x1ZGUgPGxpbnV4
L2ZiLmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiAKKy8qIFNQSSBDb250cm9sIFJl
Z2lzdGVyLiAqLworI2RlZmluZSBMQ0RfU1BVX1NQSV9DVFJMCQkJMHgwMTgwCisjZGVmaW5lICAg
ICBDRkdfU0NMS0NOVChkaXYpCQkJKChkaXYpIDw8IDI0KSAgLyogMHhGRn4weDIgKi8KKyNkZWZp
bmUgICAgIENGR19TQ0xLQ05UX01BU0sJCQkweEZGMDAwMDAwCisjZGVmaW5lICAgICBDRkdfUlhC
SVRTKHJ4KQkJCSgocnggLSAxKSA8PCAxNikgICAvKiAweDFGfjB4MSwgMHgxOiAyYml0cyAuLi4g
MHgxRjogMzJiaXRzICovCisjZGVmaW5lICAgICBDRkdfUlhCSVRTX01BU0sJCQkweDAwRkYwMDAw
CisjZGVmaW5lICAgICBDRkdfVFhCSVRTKHR4KSAgICAgICAgICAgICAgICAgICAgICAoKHR4IC0g
MSkgPDwgOCkgICAgLyogMHgxRn4weDEsIDB4MTogMmJpdHMgLi4uIDB4MUY6IDMyYml0cyAqLwor
I2RlZmluZSAgICAgQ0ZHX1RYQklUU19NQVNLCQkJMHgwMDAwRkYwMAorI2RlZmluZSAgICAgQ0ZH
X0NMS0lOVihjbGspCQkJKChjbGspIDw8IDcpCisjZGVmaW5lICAgICBDRkdfQ0xLSU5WX01BU0sJ
CQkweDAwMDAwMDgwCisjZGVmaW5lICAgICBDRkdfS0VFUFhGRVIodHJhbnNmZXIpCQkoKHRyYW5z
ZmVyKSA8PCA2KQorI2RlZmluZSAgICAgQ0ZHX0tFRVBYRkVSX01BU0sJCQkweDAwMDAwMDQwCisj
ZGVmaW5lICAgICBDRkdfUlhCSVRTVE8wKHJ4KQkJCSgocngpIDw8IDUpCisjZGVmaW5lICAgICBD
RkdfUlhCSVRTVE8wX01BU0sJCQkweDAwMDAwMDIwCisjZGVmaW5lICAgICBDRkdfVFhCSVRTVE8w
KHR4KQkJCSgodHgpIDw8IDQpCisjZGVmaW5lICAgICBDRkdfVFhCSVRTVE8wX01BU0sJCQkweDAw
MDAwMDEwCisjZGVmaW5lICAgICBDRkdfU1BJX0VOQShzcGkpCQkJKChzcGkpIDw8IDMpCisjZGVm
aW5lICAgICBDRkdfU1BJX0VOQV9NQVNLCQkJMHgwMDAwMDAwOAorI2RlZmluZSAgICAgQ0ZHX1NQ
SV9TRUwoc3BpKQkJCSgoc3BpKSA8PCAyKQkvKiAxOiBwb3J0MTsgMDogcG9ydDAgKi8KKyNkZWZp
bmUgICAgIENGR19TUElfU0VMX01BU0sJCQkweDAwMDAwMDA0CisjZGVmaW5lICAgICBDRkdfU1BJ
XzNXNFdCKHdpcmUpICAgICAgICAgICAgICAgICAoKHdpcmUpPDwxKSAgLyogMTogMy13aXJlOyAw
OiA0LXdpcmUgKi8KKyNkZWZpbmUgICAgIENGR19TUElfM1c0V0JfTUFTSwkJCTB4MDAwMDAwMDIK
KyNkZWZpbmUgICAgIENGR19TUElfU1RBUlQoc3RhcnQpCQkoc3RhcnQpCisjZGVmaW5lICAgICBD
RkdfU1BJX1NUQVJUX01BU0sJCQkweDAwMDAwMDAxCisKIC8qIER1bWIgaW50ZXJmYWNlICovCiAj
ZGVmaW5lIFBJTl9NT0RFX0RVTUJfMjQJCTAKICNkZWZpbmUgUElOX01PREVfRFVNQl8xOF9TUEkJ
CTEKQEAgLTEyMiw2ICsxNDcsMjUgQEAgc3RydWN0IHB4YTE2OGZiX21hY2hfaW5mbyB7CiAJdW5z
aWduZWQJcGFuZWxfcmJzd2FwOjE7CiAJdW5zaWduZWQJYWN0aXZlOjE7CiAJdW5zaWduZWQJZW5h
YmxlX2xjZDoxOworCS8qCisJICogU1BJIGNvbnRyb2wKKwkgKi8KKwl1bnNpZ25lZCBpbnQJc3Bp
X2N0cmw7CisJdW5zaWduZWQgaW50CXNwaV9ncGlvX2NzOworCXVuc2lnbmVkIGludCAJc3BpX2dw
aW9fcmVzZXQ7CisJLyoKKwkgKiBwb3dlciBvbi9vZmYgZnVuY3Rpb24uCisJICovCisJaW50ICgq
cHhhMTY4ZmJfbGNkX3Bvd2VyKShzdHJ1Y3QgcHhhMTY4ZmJfaW5mbyAqLCB1bnNpZ25lZCBpbnQs
IHVuc2lnbmVkIGludCwgaW50KTsKIH07CiAKKy8qIFNQSSB1dGlsaXR5IGZvciBjb25maWd1cmUg
cGFuZWwgU1BJIGNvbW1hbmQuIAorICogdmFsdWU6IGNvbW1hbmQgYXJyYXksIGVsZW1lbnQgc2hv
dWxkIGJlIDEsIDIgb3IgNCBieXRlIGFsaWduZWQuCisgKiBjb3VudDogY29tbWFuZCBhcnJheSBs
ZW5ndGgKKyAqIHNwaV9ncGlvX2NzOiBncGlvIG51bWJlciBmb3Igc3BpIGNoaXAgc2VsZWN0Cisg
KiBjc19hY3RpdmU6IENTIGFjdGl2ZSBwb2xhcml0eSBmb3IgU1BJIHRyYW5zYWN0aW9uCisgKiBp
bnRlcnZhbF91czogdGltZSBpbnRlcnZhbCBiZXR3ZWVuIHR3byBjb21tYW5kcywgdXMgYXMgdW5p
dCAqLworaW50IHB4YTE2OGZiX3NwaV9zZW5kKHN0cnVjdCBweGExNjhmYl9pbmZvICpmYmksIHZv
aWQgKnZhbHVlLCBpbnQgY291bnQsCisJCXVuc2lnbmVkIGludCBzcGlfZ3Bpb19jcyx1bnNpZ25l
ZCBpbnQgY3NfYWN0aXZlLCB1bnNpZ25lZCBpbnQgaW50ZXJ2YWxfdXMpOworCiAjZW5kaWYgLyog
X19BU01fTUFDSF9QWEExNjhGQl9IICovCi0tIAoxLjUuNC4zCgo=
--001636e8ffcfd5f5e704782320c8--
