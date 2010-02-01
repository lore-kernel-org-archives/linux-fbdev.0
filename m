From: Qiang Wang <rurality.linux@gmail.com>
Date: Mon, 01 Feb 2010 13:35:39 +0000
Subject: Re: [Linux-arm-nuc900] RE: [PATCH]NUC900 LCD Controller Driver
Message-Id: <71413c851002010535w391ca149p210aa448ed10c19c@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ae11f36b1001110005k410620datb5444ffa795b27f3@mail.gmail.com>
	<20100129162755.b591a2fb.akpm@linux-foundation.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020E976F@mi8nycmail19.Mi8.com>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020E976F@mi8nycmail19.Mi8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

在 2010年1月30日 上午8:37，H Hartley Sweeten <hartleys@visionengravers.com> 写道：
> On Friday, January 29, 2010 5:28 PM, Andrew Morton wrote:
>>
>> On Mon, 11 Jan 2010 17:05:44 +0900
>> Wang Qiang <rurality.linux@gmail.com> wrote:
>>
>>> hi, Dear Wan
>>>
>>> There is the patch of LCD controller driver for nuc900s.
>>> The Linux LOGO is just fine and the FB-Test application was ok, too.
>>>
>>> best regards
>>> wangqiang
>>>
>>>
>>> ...
>>>
>>> @@ -380,6 +381,48 @@ struct platform_device nuc900_device_kpi = {
>>>      .resource       = nuc900_kpi_resource,
>>>  };
>>>
>>> +#ifdef CONFIG_FB_NUC900
>>> +
>>> +static struct resource nuc900_lcd_resource[] = {
>>> +    [0] = {
>>> +            .start = W90X900_PA_LCD,
>>> +            .end   = W90X900_PA_LCD + W90X900_SZ_LCD - 1,
>>> +            .flags = IORESOURCE_MEM,
>>> +    },
>>> +    [1] = {
>>> +            .start = IRQ_LCD,
>>> +            .end   = IRQ_LCD,
>>> +            .flags = IORESOURCE_IRQ,
>>> +    }
>>> +};
>>> +
>>> +static u64 nuc900_device_lcd_dmamask = 0xffffffffUL;
>>
>> I suspect this should have type `dma_addr_t', but `struct device' uses
>> open-coded u64 too.  Odd.
>>
>> It makes no sense to initialise a u64 with an unsigned long value -
>> it's wrong on a 32-bit machine.
>>
>> this:
>>
>>       static u64 nuc900_device_lcd_dmamask = -1;
>>
>> will work.
>>
>>> +struct platform_device nuc900_device_lcd = {
>>> +    .name             = "nuc900-lcd",
>>> +    .id               = -1,
>>> +    .num_resources    = ARRAY_SIZE(nuc900_lcd_resource),
>>> +    .resource         = nuc900_lcd_resource,
>>> +    .dev              = {
>>> +            .dma_mask               = &nuc900_device_lcd_dmamask,
>>> +            .coherent_dma_mask      = 0xffffffffUL
>>
>> And this gets initialised to 0x00000000ffffffff also.  Using -1 will fix.
>>
>
> Wouldn't this also work?
>
>        .dev                    = {
>                .dma_mask                       = &nuc900_device_lcd.dev.coherent_dma_mask,
>                .coherent_dma_mask      = DMA_BIT_MASK(32),
>        },
>
> Then you could just get rid of nuc900_device_lcd_dmamask.

Yes, you are right.
I will use the DMA_BIT_MASK macro.
Thank you very much.



>
> Regards,
> Hartley
>
