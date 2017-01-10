From: Vladimir Zapolskiy <vz@mleia.com>
Date: Tue, 10 Jan 2017 04:06:48 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <e6e7c575-d200-bd1f-890e-824fcf0e8c01@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
 <20170102142228.GI14217@n2100.armlinux.org.uk>
 <252ad888-fa9d-695a-58ed-46806e4374fd@mleia.com>
In-Reply-To: <252ad888-fa9d-695a-58ed-46806e4374fd@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/08/2017 01:32 AM, Vladimir Zapolskiy wrote:
> On 01/02/2017 04:22 PM, Russell King - ARM Linux wrote:
>> On Fri, Dec 30, 2016 at 09:23:59AM +0100, Linus Walleij wrote:
>>> On Wed, Dec 21, 2016 at 4:27 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>
>>>> The changeset contains a number of cleanups, changed semantics of
>>>> init_panel() callback, which allows to simplify getting of panel
>>>> properties from panel device tree node, and a handling of optional
>>>> "enable-gpios" panel property, the latter is described in
>>>> display/panel/panel-dpi.txt device tree binding documentation, but
>>>> it has been unsupported by the ARM CLCD driver.
>>>>
>>>> Vladimir Zapolskiy (4):
>>>>   video: ARM CLCD: sort included headers out alphabetically
>>>>   video: ARM CLCD: use panel device node for panel initialization
>>>>   video: ARM CLCD: use panel device node for getting backlight and mode
>>>>   video: ARM CLCD: add support of an optional GPIO to enable panel
>>>
>>> As you may have seen Tomi has stepped down as FBDEV maintainer and
>>> this subsystem is now orphaned.
>>>
>>> I guess Andrew Morton merges patches for it in this case, he usually does.
>>>
>>> But what we should actually do is create a new DRM driver for CLCD
>>> in drivers/gpu/drm/arm/clcd*
>>>
>>> It's maybe not a small undertaking :(
>>>
>>> But in case you're interested in the job, I will pitch in and test the result
>>> on all ARM reference designs plus Nomadik.
>>
>> A DRM driver for it would probably be a good idea, but dealing with all
>> the weird and wonderful connection arrangements may not be that easy...
>>
> 
> Linus, Russell,
> 
> I've immediately encountered a problem while porting the driver to DRM,
> because LPC18xx/LPC43xx SoCs are powered by Cortex-M3/M4 cores and DRM
> framework has build and runtime dependencies on MMU.
> 
> That said, in short term I would expect a continuation of support for
> the legacy CLCD framebuffer driver, which works fine on MMU-less SoCs.
> 

Linus, Russell,

please let me ask you to review/ack the changes, then I'll resend them
to Andrew for inclusion as suggested by Linus.

--
With best wishes,
Vladimir

