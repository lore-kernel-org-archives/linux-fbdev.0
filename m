From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 05 Aug 2013 10:06:30 +0000
Subject: Re: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <20130805100630.GQ26614@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <1373609276-14566-5-git-send-email-b18965@freescale.com>
 <20130729111457.GB3029@pengutronix.de>
 <81BA6E5E0BC2344391CABCEE22D1B6D83CA6F0@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <81BA6E5E0BC2344391CABCEE22D1B6D83CA6F0@039-SN1MPN1-002.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 05, 2013 at 09:51:40AM +0000, Wang Huan-B18965 wrote:
> Hi, Sascha,
> 
> > On Fri, Jul 12, 2013 at 02:07:55PM +0800, Alison Wang wrote:
> > > The Display Controller Unit (DCU) module is a system master that
> > > fetches graphics stored in internal or external memory and displays
> > > them on a TFT LCD panel. A wide range of panel sizes is supported and
> > > the timing of the interface signals is highly configurable.
> > > Graphics are read directly from memory and then blended in real-time,
> > > which allows for dynamic content creation with minimal CPU
> > intervention.
> > 
> > Only a review of the code inline.
> > 
> > Maybe the real question is whether we want to introduce another
> > framebuffer driver at all instead of making it a DRM driver.
> [Alison Wang] I think DCU module is more suitable to be designed as a framebuffer driver than a DRM driver. Just like DIU framebuffer driver for PowerPC.
> > 
> > > +
> > > +#define DRIVER_NAME			"fsl-dcu-fb"
> > > +
> > > +#define DCU_DCU_MODE			0x0010
> > > +#define DCU_MODE_BLEND_ITER(x)		(x << 20)
> > 
> > What's the result of DCU_MODE_BLEND_ITER(1 + 1)?
> [Alison Wang] Is it really necessary? I don't use this macro like DCU_MODE_BLEND_ITER(1 + 1), just use DCU_MODE_BLEND_ITER(2).

<irony>
No it's not necessary. We can just add incorrect macros everywhere and
fix them as necessary after a long bug squashing session
</irony>

YES! This is necessary.

> > > +	return 0;
> > > +}
> > > +
> > > +static int calc_div_ratio(struct fb_info *info) {
> > 
> > Use a consistent namespace for function names (fsl_dcu_)
> [Alison Wang] Is it necessary to use a consistent namespace for this generic function? I think it is necessary to use a consistent namespace (fsl_dcu_) for the function names in structure fsl_dcu_ops.

This function calculates some divider out of a struct fb_info. This is
by no means generic.

> > > +		if (copy_to_user(buf, &alpha, sizeof(alpha)))
> > > +			return -EFAULT;
> > > +		break;
> > > +	case MFB_SET_ALPHA:
> > > +		if (copy_from_user(&alpha, buf, sizeof(alpha)))
> > > +			return -EFAULT;
> > > +		mfbi->blend = 1;
> > > +		mfbi->alpha = alpha;
> > > +		fsl_dcu_set_par(info);
> > > +		break;
> > 
> > Is it still state of the art to introduce ioctls in the fb framework
> > without any kind of documentation?
> [Alison Wang] Do you mean I need to add a documentation in Documentation/fb/?

This was more a question to the fb maintainers.

> > > +static irqreturn_t fsl_dcu_irq(int irq, void *dev_id) {
> > > +	struct dcu_fb_data *dcufb = dev_id;
> > > +	unsigned int status = readl(dcufb->reg_base + DCU_INT_STATUS);
> > > +	u32 dcu_mode;
> > > +
> > > +	if (status) {
> > 
> > Save indendation level by bailing out early.
> [Alison Wang] What do you mean?


Instead of doing:

	if (bla) {
		dothis();
		dothat();
		return;
	}

	return;

it's easier to read:

	if (!bla)
		return;

	dothis();
	dothat();
	return;

Note that dothis() and dothat() are one indentation level to the left
and thus have more space per line.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
