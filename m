From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 01 Sep 2015 13:55:26 +0000
Subject: Re: [PATCH v2 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <20150901135514.GB15833@sudip-pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437192539-14150-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55E5A7BC.8060003@ti.com>
In-Reply-To: <55E5A7BC.8060003@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org

On Tue, Sep 01, 2015 at 04:27:24PM +0300, Tomi Valkeinen wrote:
> 
> 
> On 18/07/15 07:08, Sudip Mukherjee wrote:
> > Now since all cleanups are done and the code is ready to be merged lets
> > move it out of staging into fbdev location.
> 
> Have you considered writing a DRM driver for this? I'm not happy at all
> adding new fbdev drivers, as the DRM framework is much better,
> supported, and continuously improved. With fbdev you end up with things
> like module parameters used to define video modes etc, which is just ugly.
Yes, I am working on a DRM driver, but since these are all voluntary
work it is taking time. And Greg has already merged it.
> 
> Anyway, some comments below.
Some replies inline and remaining I will fix and send patches to you.
> 
<snip>
> > +
> > +extern void __iomem *smtc_regbaseaddress;
> 
> Uh, what is that?
I guess all of us missed seeing it. :(
As you said in another comments smtc_regbaseaddress will be included in
the per-device data and this will be removed.
> 
<snip>
> > +static inline unsigned int smtc_seqr(int reg)
> > +{
> > +	smtc_mmiowb(reg, 0x3c4);
> > +	return smtc_mmiorb(0x3c5);
> > +}
> 
> There's quite a lot of magic numbers there, and the same continues
> through the driver. You should use defines to assign symbolic names for
> most of the numbers.
will do.
> 
<snip>
> > +
> > +void __iomem *smtc_regbaseaddress;	/* Memory Map IO starting address */
> 
> You can't have globals like this in the driver, they must be inside the
> per-device data. Just think what happens if someone has two of these
> devices.
will do.
> 
<snip>
> > +
> > +static struct fb_fix_screeninfo smtcfb_fix = {
> > +	.id             = "smXXXfb",
> > +	.type           = FB_TYPE_PACKED_PIXELS,
> > +	.visual         = FB_VISUAL_TRUECOLOR,
> > +	.line_length    = 800 * 3,
> > +	.accel          = FB_ACCEL_SMI_LYNX,
> > +	.type_aux       = 0,
> > +	.xpanstep       = 0,
> > +	.ypanstep       = 0,
> > +	.ywrapstep      = 0,
> > +};
> 
> These should be const.
ok.
> 
<snip>
> > +static const struct vesa_mode vesa_mode_table[] = {
> > +	{"0x301", 640,  480,  8},
> > +	{"0x303", 800,  600,  8},
> > +	{"0x305", 1024, 768,  8},
> > +	{"0x307", 1280, 1024, 8},
> > +
> > +	{"0x311", 640,  480,  16},
> > +	{"0x314", 800,  600,  16},
> > +	{"0x317", 1024, 768,  16},
> > +	{"0x31A", 1280, 1024, 16},
> > +
> > +	{"0x312", 640,  480,  24},
> > +	{"0x315", 800,  600,  24},
> > +	{"0x318", 1024, 768,  24},
> > +	{"0x31B", 1280, 1024, 24},
> > +};
> 
> We have "vesa_modes" in include/linux/fb.h. What is the above table for?
The resolutions that are supported along with the kernel boot parameter
to point to the resolution to boot with.
> 
> > +
> > +/**********************************************************************
> > +			 SM712 Mode table.
> > + **********************************************************************/
> > +static const struct modeinit vgamode[] = {
> > +	{
<snip>	
> > +		{	/*  Init_CR90_CRA7 */
> > +			0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
> > +			0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
> > +			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
> > +		},
> > +	},
> > +};
> 
> What are these tables above for?
Different register settings based on the display resolution. Do you want
me to do anything with these vgamode table and the vesa_mode_table?

regards
sudip
