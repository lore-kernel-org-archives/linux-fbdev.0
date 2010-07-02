From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 02 Jul 2010 14:39:38 +0000
Subject: RE: [PATCH v3 06/12] s3c-fb: Add wait for VSYNC ioctl
Message-Id: <004301cb19f4$66453f80$32cfbe80$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-7-git-send-email-p.osciak@samsung.com>
	<4C2DCF5C.4020600@simtec.co.uk>
In-Reply-To: <4C2DCF5C.4020600@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>Ben Dooks <mailto:ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:
>> @@ -801,6 +825,124 @@ static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
>>  	return 0;
>>  }
>>
>> +/**
>> + * s3c_fb_enable_irq() - enable framebuffer interrupts
>> + * @sfb: main hardware state
>> + */
>> +static void s3c_fb_enable_irq(struct s3c_fb *sfb)
>> +{
>> +	void __iomem *regs = sfb->regs;
>> +	u32 irq_ctrl_reg;
>> +
>> +	if (!test_and_set_bit(S3C_FB_VSYNC_IRQ_EN, &sfb->irq_flags)) {
>> +		/* IRQ disabled, enable it */
>> +		irq_ctrl_reg = readl(regs + VIDINTCON0);
>> +
>> +		irq_ctrl_reg |= VIDINTCON0_INT_ENABLE;
>> +		irq_ctrl_reg |= VIDINTCON0_INT_FRAME;
>> +
>> +		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL0_MASK;
>> +		irq_ctrl_reg |= VIDINTCON0_FRAMESEL0_VSYNC;
>> +		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL1_MASK;
>> +		irq_ctrl_reg |= VIDINTCON0_FRAMESEL1_NONE;
>> +
>> +		writel(irq_ctrl_reg, regs + VIDINTCON0);
>> +	}
>> +}
>
>there should probably be some form of locking so that an irq
>doesn't come through and disable this. possibly in the call
>that queues the request to reduce the likelyhood of any races.
>

Swapping the count and enable_irq below will fix this.

>> +
>> +/**
>> + * s3c_fb_disable_irq() - disable framebuffer interrupts
>> + * @sfb: main hardware state
>> + */
>> +static void s3c_fb_disable_irq(struct s3c_fb *sfb)
>> +{
>> +	void __iomem *regs = sfb->regs;
>> +	u32 irq_ctrl_reg;
>> +
>> +	if (test_and_clear_bit(S3C_FB_VSYNC_IRQ_EN, &sfb->irq_flags)) {
>> +		/* IRQ enabled, disable it */
>> +		irq_ctrl_reg = readl(regs + VIDINTCON0);
>> +
>> +		irq_ctrl_reg &= ~VIDINTCON0_INT_FRAME;
>> +		irq_ctrl_reg &= ~VIDINTCON0_INT_ENABLE;
>> +
>> +		writel(irq_ctrl_reg, regs + VIDINTCON0);
>> +	}
>> +}
>> +
>> +static irqreturn_t s3c_fb_irq(int irq, void *dev_id)
>> +{
>> +	struct s3c_fb *sfb = dev_id;
>> +	void __iomem  *regs = sfb->regs;
>> +	u32 irq_sts_reg;
>> +
>> +	irq_sts_reg = readl(regs + VIDINTCON1);
>> +
>> +	if (irq_sts_reg & VIDINTCON1_INT_FRAME) {
>> +
>> +		/* VSYNC interrupt, accept it */
>> +		writel(VIDINTCON1_INT_FRAME, regs + VIDINTCON1);
>> +
>> +		sfb->vsync_info.count++;
>> +		wake_up_interruptible(&sfb->vsync_info.wait);
>> +	}
>> +
>> +	/* We only support waiting for VSYNC for now, so it's safe
>> +	 * to always disable irqs here.
>> +	 */
>> +	s3c_fb_disable_irq(sfb);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * s3c_fb_wait_for_vsync() - sleep until next VSYNC interrupt or timeout
>> + * @sfb: main hardware state
>> + * @crtc: head index.
>> + */
>> +static int s3c_fb_wait_for_vsync(struct s3c_fb *sfb, u32 crtc)
>> +{
>> +	unsigned long count;
>> +	int ret;
>> +
>> +	if (crtc != 0)
>> +		return -ENODEV;
>> +
>> +	s3c_fb_enable_irq(sfb);
>> +	count = sfb->vsync_info.count;
>
>possibly doing count before enabling the irq.
>

yes... can't get my head around to what I've been thinking when writing this,
it's been a year ago... I remember being quite sure that it'd work that way
then though, as ridiculous as it looks right now...
Will swap them.

>> +	ret = wait_event_interruptible_timeout(sfb->vsync_info.wait,
>> +				       count != sfb->vsync_info.count,
>> +				       msecs_to_jiffies(VSYNC_TIMEOUT_MSEC));
>> +	if (ret = 0)
>> +		return -ETIMEDOUT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
>> +			unsigned long arg)
>> +{
>> +	struct s3c_fb_win *win = info->par;
>> +	struct s3c_fb *sfb = win->parent;
>> +	int ret;
>> +	u32 crtc;
>> +
>> +	switch (cmd) {
>> +	case FBIO_WAITFORVSYNC:
>> +		if (get_user(crtc, (u32 __user *)arg)) {
>> +			ret = -EFAULT;
>> +			break;
>> +		}
>
>can't find any info on what the argument is meant to be.
>

Head number, i.e. crt no I believe. Not sure though.

>> +
>> +		ret = s3c_fb_wait_for_vsync(sfb, crtc);
>> +		break;
>> +	default:
>> +		ret = -ENOTTY;
>
>Can someone else confirm this is the correct err?
>

Linux Device Drivers 3, page 140, or see the online version here:
http://www.makelinux.net/ldd3/chp-6-sect-1.shtml
section 6.1.2. The Return Value

man ioctl:
ENOTTY 
The specified request does not apply to the kind of object that the
descriptor d references.

>> @@ -1370,6 +1534,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210
>__devinitdata = {
>>  			[3] = 0x3000,
>>  			[4] = 0x3400,
>>  		},
>> +
>>  	},
>
>oops, added whitespace.
>

will fix.


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center






