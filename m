From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Fri, 07 Jul 2006 10:19:26 +0800
Message-ID: <44ADC4AE.2040903@gmail.com>
References: <44AD2B75.6050302@compulab.co.il>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyfwZ-0007bj-N1 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 19:19:48 -0700
Received: from wx-out-0102.google.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FyfwY-00034J-VP
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 19:19:47 -0700
Received: by wx-out-0102.google.com with SMTP id t5so2491035wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 06 Jul 2006 19:19:45 -0700 (PDT)
In-Reply-To: <44AD2B75.6050302@compulab.co.il>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Mike Rapoport wrote:
> This patch adds frame buffer driver for 2700G LCD controller present on
> CompuLab CM-X270 computer module.
> This pacth is versus current Linus git tree.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
> 

> +#include <linux/config.h>

config.h is not needed, remove that particular line.

> +
> +static struct fb_var_screeninfo mbxfb_default = {

__devinitdata or __initdata

> +
> +static struct fb_fix_screeninfo mbxfb_fix = {

__devinitdata or __initdata

> +	.id =		"MBX",
> +	.type =		FB_TYPE_PACKED_PIXELS,
> +	.visual =	FB_VISUAL_TRUECOLOR,
> +	.xpanstep =	0,
> +	.ypanstep =	0,
> +	.ywrapstep =	0,
> +	.accel =	FB_ACCEL_NONE,
> +};
> +
> +struct pixclock_div {
> +	u8 m;
> +	u8 n;
> +	u8 p;
> +};
> +
> +static unsigned int mbxfb_get_pixclock(unsigned int pixclock_ps, struct pixclock_div *div)

80-column limit

> +{
> +	u8  m, n, p;
> +	unsigned int err = 0;
> +	unsigned int min_err = ~0x0;
> +	unsigned int clk;
> +	unsigned int best_clk = 0;
> +	unsigned int ref_clk = 13000; /* FIXME: take from platform data */
> +	unsigned int pixclock;
> +
> +	/* convert pixclock to KHz */
> +	pixclock = PICOS2KHZ(pixclock_ps);
> +
> +	for ( m = 1; m < 64; m++ ) {

Coding style, no space after "(" and before ")".

> +		for ( n = 1; n < 8; n++ ) {
> +			for ( p = 0; p < 8; p++ ) {
> +				clk = (ref_clk * m) / (n * (1 << p));
> +				err = (clk > pixclock) ? (clk - pixclock) : 
> +					(pixclock - clk);
> +				if ( err < min_err ) {
> +					min_err = err;
> +					best_clk = clk;
> +					div->m = m;
> +					div->n = n;
> +					div->p = p;
> +				}
> +			}
> +		}
> +	}
> +	return KHZ2PICOS(best_clk);
> +}
> +
> +static int
> +mbxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
> +		   u_int trans, struct fb_info *info)

Coding style, "static int" and "mbxfb_setcolreg" in one line.

> +{
> +	uint val, ret = 1;

If you can, avoid u_int and family and just use u32 and family.

> +
> +	if ( regno < 255 ) {
> +		val = (red & 0xff) << 16;
> +		val |= (green & 0xff) << 8;
> +		val |= (blue & 0xff) << 0;
> +		GPLUT = Gplut_Lutadr(regno) | Gplut_Lutdata(val);
> +		udelay(1000);
> +		ret = 0;

If you want this to work as a console driver, make sure you also
write 'val' to info->pseudo_palette (for bpp 16 and above) and only
for regno's 0-15.

> +		switch ( info->var.bits_per_pixel ) {
> +			case 16:

Kernel coding style. the "case" statements must begin at the same column
as the "switch", ie:

		 switch (info->var.bits_per_pixel) {
		 case 16:
			if (info->var.green.length == 5)
				GSCTRL |= GSCTRL_GPIXFMT_ARGB1555;
			else
				GSCTRL |= GSCTRL_GPIXFMT_RGB565;
			break;

> +static void enable_clocks(struct fb_info* fbi)
> +{
> +	/* enable clocks */
> +	SYSCLKSRC = SYSCLKSRC_PLL_2; udelay(1000);

No multiple statements in one line.

> +static int mbxfb_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	/* make frame buffer memory enter self-refresh mode */
> +	LMPWR = LMPWR_MC_PWR_SRM;
> +	while ( LMPWRSTAT != LMPWRSTAT_MC_PWR_SRM );

Linus hates this style, do it like this:

	while (LMPWRSTAT != LMPWRSTAT_MC_PWR_SRM)
	      ; /* empty statement */


> +#include "mbxsysfs.c"
> +
> +#define res_size(_r) (((_r)->end - (_r)->start) + 1)

No arch-specific function/macro's to determine the resource length?

> +
> +static int mbxfb_probe(struct platform_device *dev)

__init or __devinit. And that includes other functions that are
called only during init.

> +static int mbxfb_remove(struct platform_device *dev)

__exit or __devexit.

> +static struct platform_driver mbxfb_driver = {
> +	.probe		= mbxfb_probe,
> +	.remove		= mbxfb_remove,
> +
> +#ifdef CONFIG_PM

Redundant #ifdef, suspend and resume are already defined as NULL if
CONFIG_PM is false.

> +	.suspend	= mbxfb_suspend,
> +	.resume		= mbxfb_resume,
> +#endif
> +	.driver		= {
> +		.name	= "mbx-fb",
> +	},
> +};
> +
> diff --git a/drivers/video/mbx/mbxsysfs.c b/drivers/video/mbx/mbxsysfs.c
> new file mode 100644
> index 0000000..4b9571a
> --- /dev/null
> +++ b/drivers/video/mbx/mbxsysfs.c
> @@ -0,0 +1,129 @@

Most of the attributes violate the "one file, one value" rule. GregKH won't
like it. Try using debugfs if you cannot separate them.

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
