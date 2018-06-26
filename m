From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 26 Jun 2018 14:42:27 +0000
Subject: Re: simple-framebuffer enquire
Message-Id: <CAOf5uwnVoXw1MA=n3vphMhtto=fc+NVf11idLF8nwC6JCvf4+A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com> <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
 <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com> <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
In-Reply-To: <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Hans

On Tue, Jun 26, 2018 at 3:38 PM, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Tue, Jun 26, 2018 at 3:36 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 26-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>
>>> Hi
>>>
>>> to be more specific
>>>
>>> On Tue, Jun 26, 2018 at 3:06 PM, Michael Nazzareno Trimarchi
>>> <michael@amarulasolutions.com> wrote:
>>>>
>>>> Hi
>>>>
>>>> On Tue., 26 Jun. 2018, 12:01 pm Hans de Goede, <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 25-06-18 15:29, Michael Nazzareno Trimarchi wrote:
>>>>>>
>>>>>> Hi Hans
>>>>>>
>>>>>> In order to let it even registered the simplefb I have added this
>>>>>> change. According on what I understand
>>>>>> from the code seems that this is the way to acquire memory with the
>>>>>> correct attribute
>>>>>>
>>>>>> diff --git a/drivers/video/fbdev/simplefb.c
>>>>>> b/drivers/video/fbdev/simplefb.c
>>>>>> index a3c44ec..7e61ce3 100644
>>>>>> --- a/drivers/video/fbdev/simplefb.c
>>>>>> +++ b/drivers/video/fbdev/simplefb.c
>>>>>> @@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device
>>>>>> *pdev)
>>>>>>
>>>>>>           info->fbops = &simplefb_ops;
>>>>>>           info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
>>>>>> -       info->screen_base = ioremap_wc(info->fix.smem_start,
>>>>>> -                                      info->fix.smem_len);
>>>>>> +       info->screen_base = arch_memremap_wb(info->fix.smem_start,
>>>>>> +                                            info->fix.smem_len);
>>>>>
>>>>>
>>>>> I'm not sure why you need this?  wb certainly is not optimal
>>>>> for a framebuffer, the existing wc mapping is really what you
>>>>> want.
>>>>>
>>>>
>>>> Well in this way raise a WARN and get a nice NULL on memory remap on
>>>> imx6ull
>>>> SoC
>>>>
>>>
>>> [    0.397484] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:303
>>> __arm_ioremap_pfn_caller+0x80/0x1cc
>>
>>
>>
>> This is causes by a mismatch in memory attributes, which means the
>> memory is already mapped by the kernel as regular RAM and may
>> already be used for other purposes by the kernel!
>>
>> Memory used by a simplefb framebuffer must be reserved by the
>> bootloader, so that it does not get used by the kernel as regular
>> RAM. See e.g.:
>>
>> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/video/sunxi/sunxi_display.c
>>
>> Near the end of the file where the framebuffer RAM gets excluded from
>> the memory-range reported to the kernel as usable RAM. Note this relies
>> on the u-boot sunxi video code putting the framebuffer at the end of the
>> RAM.

+       aliases {
+               display0 = &lcdif;
+       };
+
+       reserved-memory {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               display_reserved: framebuffer@86fd6080 {
+                       reg = <0x86fd6080 (480 * 272 *4)>;
+               };
+

This should do the trick but I have still the same problem on memory
type. Any idea?


+               linux,cma {
+                       compatible = "shared-dma-pool";
+                       reusable;
+                       size = <0x1000000>;
+                       linux,cma-default;
+               };
+       };
+
+       chosen {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               stdout-path = &uart1;
+               framebuffer0: framebuffer@86fd6080 {
+                       compatible = "simple-framebuffer";
+                       reg = <0x86fd6080 (480 * 272 * 4)>;

Here I try to use the same. I will create in uboot a dynamic way to
track down. I think that
we can even add to the simple buffer a way to get hand of reserved
region automatically

Michael

+                       width = <480>;
+                       height = <272>;
+                       stride = <(480 * 4)>;
+                       format = "a8r8g8b8";
+                       clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
+                                <&clks IMX6UL_CLK_LCDIF_APB>,
+                                <&clks IMX6UL_CLK_DUMMY>,
+                                <&clks IMX6UL_CLK_GPIO3>,
+                                <&clks IMX6UL_CLK_GPIO4>;
+                       nshut-supply = <&reg_lcd_nshut>;
+                       nreset-supply = <&reg_lcd_nreset>;
+                       display = <&lcdif>;
+                       status = "okay";
+               };



>>
>
> Thank you very much for this lesson ;). I will try to document better
> after my tour ;)
>
> Michael
>
>> Regards,
>>
>> Hans
>
>
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
