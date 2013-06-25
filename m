From: jett zhou <jett.zhou@gmail.com>
Date: Tue, 25 Jun 2013 02:23:26 +0000
Subject: Re: [V2 1/7] video: mmp: rb swap setting update for new LCD driver
Message-Id: <CACDDiy_CpKuZkevm4jQud1DKBEDa-ZhtrWb+rFpTXvK3zm6aHw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370879533-11017-1-git-send-email-jtzhou@marvell.com>
 <CAMLZHHQ+97f=i3axaFBn9JoOu7Cqo73neqxKYNCfWqwjZ4DfnQ@mail.gmail.com>
 <CACDDiy8=WRmnGMFr55uVWUE6+NNy3pMCeBfV8E9urAeW6VVEMw@mail.gmail.com>
 <CAMLZHHQxMAM1Vhj9Jreq5rAN-nmBEbEyoKMwFnL0tVHsKv4U=g@mail.gmail.com>
In-Reply-To: <CAMLZHHQxMAM1Vhj9Jreq5rAN-nmBEbEyoKMwFnL0tVHsKv4U=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

2013/6/24 Daniel Drake <dsd@laptop.org>:
> On Mon, Jun 24, 2013 at 2:45 AM, jett zhou <jett.zhou@gmail.com> wrote:
>>        Sorry that the comments of the patch is not so clear.
>>        As you might know,We can set two rbswap setting, one is based on
>> pix_fmt to set into DMA input part, the other is to configured in the output
>> interface part.
>>        This patch include below change and enhancement:
>>        1) The input format which support rbswap is based RGB format, YUV
>> series did not support now. So you can see the patch will change the rbswap
>> value based on specific RGB format,eg. RGB will set rbswap = 1, BGR will not
>> set it.
>
> What if I'm working with a display that doesn't need or want RB
> swapping? Lets say I am working with format PIXFMT_RGB565, and running
> your patch. dmafetch_set_fmt() gets called, and fmt_to_reg() sets
> rbswap to 1.
> This means that dmafetch_set_fmt() writes a '1' into the appropriate
> RB-swapping bit in the LCD_PN_CTRL0 register, and this triggers the
> "DMA input" swapping that you mentioned. But I never asked for RB
> swapping...

Yes, if you configure it as PIXFMT_RGB565, it will set rbswap in "DMA
input" part.
So, for your case, you need to use PIXFMT_BGR565 instead of PIXFMT_RGB565.

>
>>           This part setting is controlled in driver internally, will not
>> depend on platform configure(link_config) any more.
>
> Your patch seems to depend very clearly on link_config.

Based on the patch, it does not depend on link_config for the "DMA
input" swapping, it depend on the configured pix_format.

>
>>        2) The output part of rbswap is depend on link_config which is
>> defined in specific platfrom.
>>            It will setting bit27:24 of 0x01DC register, eg. DSI output
>> interface can be controlled by this.
>
> I don't think you should add more disorganised/undocumented (ab)use of
> this magic link_config variable. You should create new, dedicated,
> documented fields.
Agree with you, create new,dedicated field for this usage is better, I
will amend the patch and send out for review again.:)
>
> Your comment above suggests that this RB-swapping behaviour is
> something that is imposed by the output device. In which case, this
> should be a configuration parameter on the panel, not on the path
> structure.
>
>>            TTC_dkb does not support dsi, the link_config is no used anymore.
>
> Then you should fix up ttc_dkb before submitting this patch.

After we add one new field for this output rbswap setting based on dsi
interface, it can be used by new stepping of mmp display controller,
ttc_dkb platform just leave and not touch it, it will be tranparent
for ttc_dkb, does not need to nothing for platform configuration for
ttc_dkb usage.
It means , ttc_dkb can only configure rbswap in "dma input" part, not
support rbswap in dsi interface part.
What do you think?

Thanks




--

----------------------------------
Best Regards
Jett Zhou
