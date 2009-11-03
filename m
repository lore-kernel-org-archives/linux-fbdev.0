From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 1/6] pxa: support pxa168 LCD controller SPI operation
Date: Tue, 3 Nov 2009 15:28:49 +0800
Message-ID: <7c34ac520911022328m1c456413s6a3505fe3a4646f0@mail.gmail.com>
References: <7c34ac520911022245x2845e5dex1311bd74a08606db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c34ac520911022245x2845e5dex1311bd74a08606db@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org

2009/11/3 Jun Nie <niej0001@gmail.com>:
> pxa: support pxa168 LCD controller SPI operation
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/mach-mmp/include/mach/pxa168fb.h | =A0 29 +++++++++
> =A0drivers/video/pxa168fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 92 +=
++++++++++++++++++++++++++++
> =A0drivers/video/pxa168fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +=
-------
> =A0include/video/pxa168fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 18 +=
+++++
> =A04 files changed, 140 insertions(+), 23 deletions(-)
> =A0create mode 100644 arch/arm/mach-mmp/include/mach/pxa168fb.h
>
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168fb.h
> b/arch/arm/mach-mmp/include/mach/pxa168fb.h
> new file mode 100644
> index 0000000..897cc3e
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/pxa168fb.h
> @@ -0,0 +1,29 @@
> +#ifndef __PXA168FBSPI_H__
> +#define __PXA168FBSPI_H__
> +
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
> +#endif /* __PXA168FBSPI_H__ */
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 84d8327..27bdf2b 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -29,10 +29,91 @@
> =A0#include <linux/uaccess.h>
> =A0#include <video/pxa168fb.h>
>
> +#include <mach/pxa168fb.h>
> +#include <mach/gpio.h>
> =A0#include "pxa168fb.h"
>
> =A0#define DEFAULT_REFRESH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A060 =A0 =A0 =A0/=
* Hz */
>
> +static inline void spi_gpio_assert_set(int spi_gpio_cs, int val)
> +{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0if (gpio_is_valid(spi_gpio_cs))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 gpio_set_value(spi_gpio_cs, val);
> +}
> +
> +int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int spi_gpio_cs, unsigned int inte=
rval_us)
> +{
> + =A0 =A0 =A0 u32 x, spi_byte_len;
> + =A0 =A0 =A0 u8 *cmd =3D (u8 *)value;
> + =A0 =A0 =A0 int i, err, isr, iopad, ret =3D 0;
> +
> + =A0 =A0 =A0 if (gpio_is_valid(spi_gpio_cs)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(spi_gpio_cs, "LCD_SPI_=
CS");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(fbi->dev, "failed t=
o request GPIO for LCD CS\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(spi_gpio_cs, 1);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_gpio_assert_set(spi_gpio_cs, 0);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_gpio_assert_set(spi_gpi=
o_cs, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto spi_exit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd +=3D spi_byte_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D readl(fbi->reg_base + LCD_SPU_SPI_CTR=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x |=3D 0x1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr =3D readl(fbi->reg_base + SPU_IRQ_ISR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while(!(isr & SPI_IRQ_ENA_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 isr =3D readl(fbi->reg_base=
 + SPU_IRQ_ISR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D readl(fbi->reg_base + LCD_SPU_SPI_CTR=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x &=3D ~0x1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(x, fbi->reg_base + LCD_SPU_SPI_CTRL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_gpio_assert_set(spi_gpio_cs, 1);
> + =A0 =A0 =A0 }
> +
> +spi_exit:
> + =A0 =A0 =A0 if (gpio_is_valid(spi_gpio_cs))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(spi_gpio_cs);
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
> @@ -687,6 +768,7 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0info->fix.smem_start =3D (unsigned long)fbi->fb_start_dma;
> + =A0 =A0 =A0 set_graphics_start(info, 0, 0);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Set video mode according to platform data.
> @@ -728,6 +810,9 @@ static int __init pxa168fb_probe(struct
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
> @@ -764,6 +849,13 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, fbi);
> + =A0 =A0 =A0 if (mi->pxa168fb_lcd_power){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(mi->pxa168fb_lcd_power(fbi, mi->spi_gpio=
_cs, mi->spi_gpio_reset, 1)){
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed=
 to power up pxa168-fb\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev_info(fbi->dev, "frame buffer detected\n");
> =A0 =A0 =A0 =A0return 0;
>
> =A0failed_free_irq:
> diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
> index eee0927..1e4859e 100644
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
> +/* For SPI register, please refer to
> arch/arm/mach-mmp/include/mach/pxa168fb.h */
>
> =A0/* SPI Tx Data Register */
> =A0#define LCD_SPU_SPI_TXDATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
184
> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> index b5cc72f..f0497ae 100644
> --- a/include/video/pxa168fb.h
> +++ b/include/video/pxa168fb.h
> @@ -122,6 +122,24 @@ struct pxa168fb_mach_info {
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
> + * interval_us: time interval between two commands, us as unit */
> +int pxa168fb_spi_send(struct pxa168fb_info *fbi, void *value, int count,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int spi_gpio_cs, unsigned int inte=
rval_us);
> +
> =A0#endif /* __ASM_MACH_PXA168FB_H */
> --
> 1.5.4.3
>

add linux-fbdev@vger.kernel.org
