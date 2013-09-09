From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 09 Sep 2013 11:19:19 +0000
Subject: Re: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378725559.4082.28.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
 <522BAED9.4020301@gmail.com>
In-Reply-To: <522BAED9.4020301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 2013-09-07 at 23:55 +0100, Sylwester Nawrocki wrote:
> H --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
> > @@ -0,0 +1,87 @@
> > +* ARM PrimeCell Color LCD Controller (CLCD) PL110/PL111
> 
> nit: Shouldn't the abbreviation be CLCDC ?

The commonly used acronym for this cell is CLCD. For what its worth, I
can make the line read:

ARM PrimeCell Color LCD (CLCD) Controller PL110/PL111

> > +- video-ram: phandle to a node describing specialized video memory
> > +		(that is *not* described in the top level "memory" node)
> > +                that must be used as a framebuffer, eg. due to restrictions
> > +		of the system interconnect; the node must contain a
> > +		standard reg property describing the address and the size
> > +		of the memory area
> 
> It seems the "specialized video memory" is described by some vendor specific
> DT binding ? Is it documented ? It sounds like you are unnecessarily 
> repeating the memory node details here.

I appreciate this property being the hardest to swallow, but the problem
it is trying to solve is quite simple, really. System can be designed in
such a way that CLCD is *not* able to read data from the main memory. In
such case there will be a separate block of (usually static) memory
"next" to CLCD, which *must* be used for the framebuffer. And I've got
two choices here: to simply define an address and size, or to define a
phandle to a node with standard reg property. I'll be really grateful
for ideas how to describe the situation better.

> Perhaps this binding/driver should use the common reserved memory bindings,
> see thread http://www.spinics.net/lists/devicetree/msg02880.html

No, not really - as I said, this is *not* the main RAM of the system.
CMA doesn't even know about its existence.

> > +- max-framebuffer-size: maximum size in bytes of the framebuffer the
> > +			system can handle, eg. in terms of available
> > +			memory bandwidth
> > +
> > +In the simplest case of a display panel being connected directly to the
> > +CLCD, it can be described in the node:
> > +
> > +- panel-dimensions: (optional) array of two numbers (width and height)
> > +			describing physical dimension in mm of the panel
> > +- panel-type: (required) must be "tft" or "stn", defines panel type
> > +- panel-tft-interface: (for "tft" panel type) array of 3 numbers defining
> > +			widths in bits of the R, G and B components
> > +- panel-tft-rb-swapped: (for "tft" panel type) if present means that
> > +			the R&  B components are swapped on the board
> > +- panel-stn-color: (for "stn" panel type) if present means that
> > +			the panel is a colour STN display, if missing
> > +			is a monochrome display
> > +- panel-stn-dual: (for "stn" panel type) if present means that there
> > +			are two STN displays connected
> > +- panel-stn-4bit: (for monochrome "stn" panel) if present means
> > +			that the monochrome display is connected
> > +			via 4 bit-wide interface
> 
> Are this vendor specific or common properties ? Shouldn't those be prefixed
> with the vendor name ?

I have no answer to this question. My guts are telling me - nope. TFT is
TFT, STN is STN, nothing to do with "arm,". But I welcome other
opinions.

> Anyway I think we need an RFC to possibly standardize properties that are
> common across multiple panels and have them listed in a common DT binding.
> 
> It sounds a bit disappointing that for same class devices there are being
> introduced custom DT properties for each available device. For instance,
> the first 3 properties above look like they could apply to various display
> panels and controllers.

No argument from here. The Common Display Framework was supposed to
address this issue. And the first version of this patch used it:

http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/63417

But you'll notice that it's been almost 10 months since the last version
of CDF saw the daylight, and Laurent seems to be too busy with other
duties to carry on with this. Additionally the KMS/DRM guys don't look
too kindly on it. The bottom line is: there are 3 different platform
suffering from lack of DT bindings for CLCD and I've got fed up with
waiting. Anyway, I've intentionally kept the panel properties in a
separate section and wrote "can be described", to keep an open way for
future "display bindings", if and when they appear.

> > +#ifdef CONFIG_OF
> > +static int clcdfb_of_get_tft_panel(struct device_node *node,
> > +		struct clcd_panel *panel)
> > +{
> > +	int err;
> > +	u32 rgb[3];
> > +	int r, g, b;
> 
> Couldn't these be 'unsigned int' ?

They could indeed.

> > +	err = of_property_read_u32_array(node, "panel-tft-interface", rgb, 3);
> > +	if (err)
> > +		return err;
> > +
> > +	r = rgb[0];
> > +	g = rgb[1];
> > +	b = rgb[2];
> > +
> > +	/* Bypass pixel clock divider, data output on the falling edge */
> > +	panel->tim2 = TIM2_BCD | TIM2_IPC;
> > +
> > +	/* TFT display, vert. comp. interrupt at the start of the back porch */
> > +	panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
> > +
> > +	if (r>= 4&&  g>= 4&&  b>= 4)
> > +		panel->caps |= CLCD_CAP_444;
> > +	if (r>= 5&&  g>= 5&&  b>= 5)
> > +		panel->caps |= CLCD_CAP_5551;
> > +	if (r>= 5&&  g>= 6&&  b>= 5)
> > +		panel->caps |= CLCD_CAP_565;
> > +	if (r>= 8&&  g>= 8&&  b>= 8)
> > +		panel->caps |= CLCD_CAP_888;
> > +
> > +	if (of_get_property(node, "panel-tft-rb-swapped", NULL))
> > +		panel->caps&= ~CLCD_CAP_RGB;
> > +	else
> > +		panel->caps&= ~CLCD_CAP_BGR;
> > +
> > +	return 0;
> > +}
> > +
> > +static int clcdfb_of_init_display(struct clcd_fb *fb)
> > +{
> > +	struct device_node *node = fb->dev->dev.of_node;
> > +	u32 max_size;
> > +	u32 dimensions[2];
> > +	char *mode_name;
> > +	int len, err;
> > +	const char *panel_type;
> > +
> > +	fb->panel = devm_kzalloc(&fb->dev->dev, sizeof(*fb->panel), GFP_KERNEL);
> > +	if (!fb->panel)
> > +		return -ENOMEM;
> > +
> > +	err = of_get_fb_videomode(fb->dev->dev.of_node,&fb->panel->mode,
> 
> 'node' could be reused here.

Of course, well spotted.

> > +			OF_USE_NATIVE_MODE);
> > +	if (err)
> > +		return err;
> > +
> > +	len = snprintf(NULL, 0, "%ux%u@%u", fb->panel->mode.xres,
> > +			fb->panel->mode.yres, fb->panel->mode.refresh);
> > +	mode_name = devm_kzalloc(&fb->dev->dev, len + 1, GFP_KERNEL);
> > +	snprintf(mode_name, len + 1, "%ux%u@%u", fb->panel->mode.xres,
> > +			fb->panel->mode.yres, fb->panel->mode.refresh);
> 
> Don't you want to just use kasprintf() here instead and free mode_name
> manually in the remove() callback ?

> > +static int clcdfb_of_vram_setup(struct clcd_fb *fb)
> > +{
> > +	const __be32 *prop = of_get_property(fb->dev->dev.of_node, "video-ram",
> > +			NULL);
> > +	struct device_node *node = of_find_node_by_phandle(be32_to_cpup(prop));
> 
> This looks like open coding function of_parse_phandle(), why not just:
> 
> 	struct device_node *node = of_parse_phandle(fb->dev->dev.of_node,
> 					"video-ram", 0);
> ?

I'm not sure why did I write it like this (and it's been a while since
this happened), but you're right - it should be of_parse_phandle().

Thanks!

Pawel


