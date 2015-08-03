From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 03 Aug 2015 07:30:47 +0000
Subject: Re: [PATCH 1/2] ARM: integrator: move framebuffers to driver
Message-Id: <CACRpkdYkHgKJHDGp+6gS==9829tUsnFyPrdrevyyUuod04mNvw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438172831-11450-1-git-send-email-linus.walleij@linaro.org>
 <20150729193846.GQ7557@n2100.arm.linux.org.uk>
In-Reply-To: <20150729193846.GQ7557@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 29, 2015 at 9:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 29, 2015 at 02:27:11PM +0200, Linus Walleij wrote:
>> Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
>> "video: move Versatile CLCD helpers" already moved the
>> CLCD mode setting helpers for Versatile and Integrator/CP
>> to drivers/video/fbdev. Let's do the same for the IM-PD1
>> add-on board, copy the missing displays into the database
>> and simplify the code.
>
> And thereby break the support.  The IM-PD1 CLCD can only access the memory
> on the IM-PD1.  That's why the CLCD driver itself doesn't just allocate
> the frame buffer using dma_alloc_writecombine().  Where the memory comes
> from is platform specific.  In this case...
>
>> -static int impd1fb_clcd_setup(struct clcd_fb *fb)
>> -{
>> -     unsigned long framebase = fb->dev->res.start + 0x01000000;
>> -     unsigned long framesize = SZ_1M;
>
> It's a chunk of SRAM offset by the specified value and of the specified
> size above.

Argh how typical. I need to get one of these PROSPECTOR displays
so I can actually test this stuff. I have tried to get VGA out working with
the IM-PD1 but it just doesn't seem to come up no matter how I
try.

Yours,
Linus Walleij
