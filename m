From: Vladimir Zapolskiy <vz@mleia.com>
Date: Sun, 01 Jan 2017 20:50:45 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <d2da4011-9780-89d7-05de-70a2e8a96379@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
In-Reply-To: <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12/30/2016 10:23 AM, Linus Walleij wrote:
> On Wed, Dec 21, 2016 at 4:27 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
>> The changeset contains a number of cleanups, changed semantics of
>> init_panel() callback, which allows to simplify getting of panel
>> properties from panel device tree node, and a handling of optional
>> "enable-gpios" panel property, the latter is described in
>> display/panel/panel-dpi.txt device tree binding documentation, but
>> it has been unsupported by the ARM CLCD driver.
>>
>> Vladimir Zapolskiy (4):
>>   video: ARM CLCD: sort included headers out alphabetically
>>   video: ARM CLCD: use panel device node for panel initialization
>>   video: ARM CLCD: use panel device node for getting backlight and mode
>>   video: ARM CLCD: add support of an optional GPIO to enable panel
> 
> As you may have seen Tomi has stepped down as FBDEV maintainer and
> this subsystem is now orphaned.
> 
> I guess Andrew Morton merges patches for it in this case, he usually does.
> 

Hello Andrew,

if you have the patches in your mailbox, could you please review and
apply them for the next?

> But what we should actually do is create a new DRM driver for CLCD
> in drivers/gpu/drm/arm/clcd*
> 
> It's maybe not a small undertaking :(
> 
> But in case you're interested in the job, I will pitch in and test the result
> on all ARM reference designs plus Nomadik.
> 

I'll take a look at this task, talking about the controller itself
it should be relatively easy to port the driver to DRM and replace
panel initialization code with a panel-simple driver, however platform
specific hooks for Nomadik and Versatile require special attention,
and because I don't have that hardware I'll keep my hands off it. FWIW
the LPC32xx and LPC18xx/LPC43xx platforms for which I did this change
don't need anything out of the shared video/fbdev/amba-clcd.c code.

--
With best wishes,
Vladimir
