From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 01 Feb 2018 19:03:30 +0000
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region' property on DT node
Message-Id: <CAHp75VfTrEELX9kKjZ7zmM8V=ZxbfAPbEDozG1i0A4P6gUjnEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180123113510epcas1p1fc8a6e3ad50127bb84fe350b156a8c07@epcas1p1.samsung.com>
 <1516707296-23667-1-git-send-email-hayashi.kunihiko@socionext.com> <2359956.Z9lQWSAgHb@amdc3058>
In-Reply-To: <2359956.Z9lQWSAgHb@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>

On Thu, Feb 1, 2018 at 5:56 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
>> Enables 'memory-region' property referring to the memory description on
>> the reserved-memory node in case of devicetree use.
>> If there is no 'reg' property that specifies the address and size of
>> the framebuffer, the address and size written in the memory description
>> on the reserved-memory node can be used for the framebuffer.
>>
>> Furthermore, the reserved-memory node needs to have "no-map" attributes
>> because simplefb driver maps the region by ioremap_wc().
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

>> +- memory-region: phandle to a node describing memory region as framebuffer
>> +              memory instead of reg property. The node should include
>> +              'no-map'.

>>       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!mem)
>> +             mem = simplefb_parse_dt_reserved_mem(&pdev->dev);

I'm not sure I understood why you need this entire function?

Put your memory resource ('reg' property) as part of reserved memory
with necessary flags.

-- 
With Best Regards,
Andy Shevchenko
