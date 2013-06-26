From: jett zhou <jett.zhou@gmail.com>
Date: Wed, 26 Jun 2013 10:31:14 +0000
Subject: Re: [V2 1/7] video: mmp: rb swap setting update for new LCD driver
Message-Id: <CACDDiy-bCSBVLnSJq+jEP+zunwp8pTHkJaOq-zdzgiiL4ZH8Fw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879533-11017-1-git-send-email-jtzhou@marvell.com>
 <CAMLZHHQ+97f=i3axaFBn9JoOu7Cqo73neqxKYNCfWqwjZ4DfnQ@mail.gmail.com>
 <CACDDiy8=WRmnGMFr55uVWUE6+NNy3pMCeBfV8E9urAeW6VVEMw@mail.gmail.com>
 <CAMLZHHQxMAM1Vhj9Jreq5rAN-nmBEbEyoKMwFnL0tVHsKv4U=g@mail.gmail.com>
 <CACDDiy_CpKuZkevm4jQud1DKBEDa-ZhtrWb+rFpTXvK3zm6aHw@mail.gmail.com>
 <CAMLZHHTdgU2-BAsUn-QoUP5JL--pPVjsT4AW0Yv+bPL__EbHCw@mail.gmail.com>
In-Reply-To: <CAMLZHHTdgU2-BAsUn-QoUP5JL--pPVjsT4AW0Yv+bPL__EbHCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2013/6/25 Daniel Drake <dsd@laptop.org>:
> On Mon, Jun 24, 2013 at 8:23 PM, jett zhou <jett.zhou@gmail.com> wrote:
>>> What if I'm working with a display that doesn't need or want RB
>>> swapping? Lets say I am working with format PIXFMT_RGB565, and running
>>> your patch. dmafetch_set_fmt() gets called, and fmt_to_reg() sets
>>> rbswap to 1.
>>> This means that dmafetch_set_fmt() writes a '1' into the appropriate
>>> RB-swapping bit in the LCD_PN_CTRL0 register, and this triggers the
>>> "DMA input" swapping that you mentioned. But I never asked for RB
>>> swapping...
>>
>> Yes, if you configure it as PIXFMT_RGB565, it will set rbswap in "DMA
>> input" part.
>> So, for your case, you need to use PIXFMT_BGR565 instead of PIXFMT_RGB565.
>
> So let me get this straight. I have a display that wants RGB565
> format, no RB swapping. I don't do anything special in link_config to
> affect any swapping.
>
> After your patch, I must request BGR565 format in order to get RGB565?
> That sounds backwards to me.

HI Daniel
     My above explanation may be not so precise and correct, actually
you can RGB565 directly and does not need BGR565, mmp display
controller handle it accordingly in driver.
     Take RGB565 and BGR565 as example:
          RGB565 indicates the source data in memory is that Red is
[15~11] , Green is [10~5], Blue is [4:0], Red is MSB, Blue is LSB, but
for the display dma input default setting(rbswap = 0), it only support
Blue is [15~11] , Green is [10~5], Red is [4:0], Red is LSB, Blue is
MSB, so for this format(RGB565), display controller need to set rbswap
= 1 and it can support the MSB/LSB correctly.
          In conclusion, no matter you use RGB565 or BGR565, mmp
display driver did the rbswap setiing based on the format and what is
MSB/LSB, so platform does not need handle it by link_config based on
this patch.
Thanks

>
>>> Your comment above suggests that this RB-swapping behaviour is
>>> something that is imposed by the output device. In which case, this
>>> should be a configuration parameter on the panel, not on the path
>>> structure.
>>>
>>>>            TTC_dkb does not support dsi, the link_config is no used anymore.
>>>
>>> Then you should fix up ttc_dkb before submitting this patch.
>>
>> After we add one new field for this output rbswap setting based on dsi
>> interface, it can be used by new stepping of mmp display controller,
>> ttc_dkb platform just leave and not touch it, it will be tranparent
>> for ttc_dkb, does not need to nothing for platform configuration for
>> ttc_dkb usage.
>> It means , ttc_dkb can only configure rbswap in "dma input" part, not
>> support rbswap in dsi interface part.
>> What do you think?
>
> The point I am trying to make is that your patch is changing behaviour
> for ttc_dkb, so you need to address that at the same time.
>
> Right now ttc_dkb does this:
>
> #define CFG_GRA_SWAPRB(x)      (x << 0) /* 1: rbswap enabled */
> .link_config = CFG_DUMBMODE(0x2) | CFG_GRA_SWAPRB(0x1),
>
> i.e. SWAPRB requested through bit 0 in link_config
>
> And this is obeyed by the existing code in fmt_to_reg:
>
>    u32 link_config = path_to_path_plat(overlay->path)->link_config;
>    rbswap = link_config & 0x1;
>
> Your patch removes the handling of link_config bit 0, without fixing
> up its only user (even if that user was incorrect). That is not good
> practice.
>
> Another question: why is this change needed?
> We can request rb swapping either in DMA input or in the output
> interface. I can understand the driver maybe supporting one option or
> the other. But after your patch, it seems like both are supported: RB
> swapping could be enabled either through choice of input format, or
> through configuration of output parameters.
For TTC dkb,  you are right, I need to fix the rbswap in the platform
part, I will add one fix patch for ttc_dkb based on new rbswap patch.
For output dsi interface, it has this feature to do rbswap again if it
needs specifc byte sequence of RGB byte of DSI panel.
eg. If display content is set RGB565 in memory and DMA input part set
rbswap in driver to support Red as MSB , Blue LSB, but dsi panel only
support Red as LSB, Blue as MSB, then it can use this feature.
If there is no this requirement of panel, this dsi output part is not needed.

Thanks
>




--

----------------------------------
Best Regards
Jett Zhou
