From: "Etheridge, Darren" <detheridge@ti.com>
Date: Fri, 16 Aug 2013 20:11:27 +0000
Subject: RE: [RFC 1/1] video: da8xx-fb: adding dt support
Message-Id: <1A80A2FD7F34484786E5DF71F3968B6940F788CC@DLEE10.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375992936-16755-1-git-send-email-detheridge@ti.com>
 <1375992936-16755-2-git-send-email-detheridge@ti.com>
 <CA+V-a8uSd7cypG=zTPyfkdq_xSdxHeGpoRu497U8C-3ZUsfu5w@mail.gmail.com>
In-Reply-To: <CA+V-a8uSd7cypG=zTPyfkdq_xSdxHeGpoRu497U8C-3ZUsfu5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Mohammed, Afzal" <afzal@ti.com>

From: Prabhakar Lad [mailto:prabhakar.csengg@gmail.com]
> Sent: Thursday, August 08, 2013 11:07 PM
> Subject: Re: [RFC 1/1] video: da8xx-fb: adding dt support
> 
> Hi Darren,
> 
> Thanks for the patch, below are few nits!
> 
Prabhakar,

Thanks for reviewing, somehow I missed your reply so sorry about late response.

> On Fri, Aug 9, 2013 at 1:45 AM, Darren Etheridge <detheridge@ti.com>
> wrote:
> > Enhancing driver to enable probe triggered by a corresponding dt entry.
> >
<snip>
> > +
> > +       cfg = devm_kzalloc(&dev->dev, sizeof(struct fb_videomode),
> GFP_KERNEL);
> > +       if (!cfg) {
> > +               dev_err(&dev->dev, "memory allocation failed\n");
> 
> devm_* api will print the message if allocation has failed, please remove the
> above err statement and also similarly below.

Will fix.

<snip>

> > +               lcdc_info = devm_kzalloc(&dev->dev,
> > +                                        sizeof(struct fb_videomode),
> > +                                        GFP_KERNEL);
> > +               if (!lcdc_info) {
> > +                       dev_err(&dev->dev, "memory allocation
> > + failed\n");
> ditto

Will fix

<snip>

> > @@ -1390,7 +1439,7 @@ static int fb_probe(struct platform_device
> *device)
> >         par->dev = &device->dev;
> >         par->lcdc_clk = tmp_lcdc_clk;
> >         par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
> > -       if (fb_pdata->panel_power_ctrl) {
> > +       if (fb_pdata && fb_pdata->panel_power_ctrl) {
> >                 par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
> >                 par->panel_power_ctrl(1);
> 
> What happens to this data in DT case ?
>

Good find,  right now we don't do any power control in the DT case - this is something that needs to be addressed.

>
 > >         }
> > @@ -1638,6 +1687,17 @@ static int fb_resume(struct platform_device
> > *dev)  #define fb_resume NULL  #endif
> >
> > +static const struct of_device_id da8xx_fb_of_match[] = {
> > +       /*
> > +        * this driver supports version 1 and version 2 of the
> > +        * Texas Instruments lcd controller (lcdc) hardware block
> > +        */
> > +       {.compatible = "ti,da830-lcdc", },
> > +       {.compatible = "ti,am3352-lcdc", },
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(of, da8xx_fb_of_match);
> > +
> you can bound this structure and the macro in IS_ENABLED(CONFIG_OF)

Ok will look at that.

Thanks,
Darren
