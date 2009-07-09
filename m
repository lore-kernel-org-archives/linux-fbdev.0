From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 4/4] [ARM] s3c-fb: Add wait for vsync support
Date: Thu, 9 Jul 2009 19:51:45 +0200
Message-ID: <20090709195145.fde4481e.krzysztof.h1@poczta.fm>
References: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EF@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EF@bssrvexch01.BS.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Pawel Osciak <p.osciak@samsung.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "adaplas@gmail.com" <adaplas@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, =?UTF-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, 09 Jul 2009 17:09:03 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> Added VSYNC interrupt support.
> Added FBIO_WAITFORVSYNC ioctl that allows sleeping on vsync
> waitqueue.
> 
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 
> 
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 77b77a2..0c064c2 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -21,6 +21,8 @@
>  #include <linux/clk.h>
>  #include <linux/fb.h>
>  #include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/interrupt.h>
>  
>  #include <mach/map.h>
>  #include <mach/regs-fb.h>
> @@ -48,6 +50,13 @@
>  	__raw_writel(v, r); } while(0)
>  #endif /* FB_S3C_DEBUG_REGWRITE */
>  
> +/* Bit in irq_flags used to mark that interrupts are activated in device */
> +#define S3C_FB_IRQ_ENABLED_BIT	0
> +
> +#ifndef FBIO_WAITFORVSYNC
> +#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
> +#endif
> +
>  struct s3c_fb;
>  
>  /**
> @@ -59,6 +68,7 @@ struct s3c_fb;
>   * @pseudo_palette: For use in TRUECOLOUR modes for entries 0..15/
>   * @index: The window number of this window.
>   * @palette: The bitfields for changing r/g/b into a hardware palette entry.
> + * @vsync: Vsync handling helper.
>   */
>  struct s3c_fb_win {
>  	struct s3c_fb_pd_win	*windata;
> @@ -72,14 +82,27 @@ struct s3c_fb_win {
>  };
>  
>  /**
> + * struct s3c_fb_vsync - vsync information for display.
> + * @vsync_queue: A queue for processes waiting for vsync.
> + * @vsync_count: Vsync interrupt count.
> + */
> +struct s3c_fb_vsync {
> +	wait_queue_head_t	vsync_queue;
> +	unsigned long		vsync_count;
> +};
> +
> +/**
>   * struct s3c_fb - overall hardware state of the hardware
>   * @dev: The device that we bound to, for printing, etc.
>   * @regs_res: The resource we claimed for the IO registers.
>   * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
>   * @regs: The mapped hardware registers.
>   * @enabled: A bitmask of enabled hardware windows.
> + * @open_instances: How many times the driver has been opened.
>   * @pdata: The platform configuration data passed with the device.
>   * @windows: The hardware windows that have been claimed.
> + * @irq_no: IRQ number for the device (acquired from platform data).
> + * @vsync_info: VSYNC-related information (count, queues...)
>   */
>  struct s3c_fb {
>  	struct device		*dev;
> @@ -87,10 +110,16 @@ struct s3c_fb {
>  	struct clk		*bus_clk;
>  	void __iomem		*regs;
>  
> -	unsigned char		 enabled;
> +	unsigned char		enabled;
> +	atomic_t		open_instances;
>  
>  	struct s3c_fb_platdata	*pdata;
>  	struct s3c_fb_win	*windows[S3C_FB_MAX_WIN];
> +
> +	unsigned int		irq_no;
> +	unsigned long		irq_flags;
> +
> +	struct s3c_fb_vsync	vsync_info;
>  };
>  
>  /**
> @@ -643,6 +672,104 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  }
>  
>  /**
> + * s3c_fb_enable_irq() - enable interrupts in hardware.
> + * @sfb: The base resources for the hardware.
> + */
> +static int s3c_fb_enable_irq(struct s3c_fb *sfb)
> +{
> +	u32	     irq_ctrl_reg;
> +	void __iomem *regs = sfb->regs;
> +
> +	if (!test_and_set_bit(S3C_FB_IRQ_ENABLED_BIT, &sfb->irq_flags)) {
> +		/* IRQ was disabled, enable it */
> +		irq_ctrl_reg = readl(regs + VIDINTCON0);
> +
> +		irq_ctrl_reg |= VIDINTCON0_INT_ENABLE;
> +		irq_ctrl_reg |= VIDINTCON0_INT_FRAME;
> +
> +		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL0_MASK;
> +		irq_ctrl_reg |= VIDINTCON0_FRAMESEL0_VSYNC;
> +		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL1_MASK;
> +		irq_ctrl_reg |= VIDINTCON0_FRAMESEL1_NONE;
> +
> +		writel(irq_ctrl_reg, regs + VIDINTCON0);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * s3c_fb_disable_irq() - disable interrupts in hardware.
> + * @sfb: The base resources for the hardware.
> + */
> +static int s3c_fb_disable_irq(struct s3c_fb *sfb)
> +{
> +	u32	     irq_ctrl_reg;
> +	void __iomem *regs = sfb->regs;
> +
> +	if (test_and_clear_bit(S3C_FB_IRQ_ENABLED_BIT, &sfb->irq_flags)) {
> +		/* IRQ was enabled, disable it */
> +		irq_ctrl_reg = readl(regs + VIDINTCON0);
> +
> +		irq_ctrl_reg &= ~VIDINTCON0_INT_FRAME;
> +		irq_ctrl_reg &= ~VIDINTCON0_INT_ENABLE;
> +
> +		writel(irq_ctrl_reg, regs + VIDINTCON0);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t s3c_fb_interrupt(int irq, void *dev_id)
> +{
> +	u32	      irq_sts_reg;
> +	struct s3c_fb *sfb = dev_id;
> +	void __iomem  *regs = sfb->regs;
> +
> +	irq_sts_reg = readl(regs + VIDINTCON1);
> +
> +	if (irq_sts_reg & VIDINTCON1_INT_FRAME) {
> +
> +		/* VSYNC interrupt, accept it */
> +		writel(VIDINTCON1_INT_FRAME, regs + VIDINTCON1);
> +
> +		sfb->vsync_info.vsync_count++;
> +		wake_up_interruptible(&sfb->vsync_info.vsync_queue);
> +	}
> +
> +	/* We support only waiting for VSYNC interrupt for now,
> +	 * so it's safe to disable irqs here. */
> +	s3c_fb_disable_irq(sfb);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * s3c_fb_wait_for_vsync() - sleep until next VSYNC interrupt or timeout.
> + * @sfb: The base resources for the hardware.
> + * @crtc: Head index.
> + */
> +static int s3c_fb_wait_for_vsync(struct s3c_fb *sfb, u32 crtc)
> +{
> +	unsigned long count;
> +	int ret;
> +
> +	if (crtc != 0)
> +		return -ENODEV;
> +
> +	s3c_fb_enable_irq(sfb);
> +	count = sfb->vsync_info.vsync_count;
> +	ret = wait_event_interruptible_timeout(sfb->vsync_info.vsync_queue,
> +				       count != sfb->vsync_info.vsync_count,
> +				       HZ / 10);
> +	if (ret == 0)
> +		return -ETIMEDOUT;
> +
> +

If you disable the irq here there is no need for open and release functions.
You can also remove this disabling from all other places. Much less code then.

> +	return 0;
> +}
> +

Regards,
Krzysztof

----------------------------------------------------------------------
Sprawdz promocje ubezpieczen komunikacyjnych w Ergo  Hestia
http://link.interia.pl/f222c


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
