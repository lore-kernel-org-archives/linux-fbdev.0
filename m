From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 Feb 2016 20:31:30 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdYRNLdsR1fdJ0WyVpRbtca+1zSjohSKKQcmSgARhRejhA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk>
 <56C5B080.9090007@ti.com>
 <20160218131233.GP19428@n2100.arm.linux.org.uk>
 <56C5C8FD.7090004@ti.com>
In-Reply-To: <56C5C8FD.7090004@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 18, 2016 at 2:37 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On 18/02/16 15:12, Russell King - ARM Linux wrote:
>> On Thu, Feb 18, 2016 at 01:52:32PM +0200, Tomi Valkeinen wrote:
>>> In my opinion the best option would be to use DT overlays, but so that
>>> the bootloader would supply them, or construct the dtb. But afaik that's
>>> not possible at the moment. And perhaps I think that's the best option
>>> only because I don't work with the bootloaders =3D).
>>>
>>> So, I don't like this, but I don't have a good suggestion how to do it
>>> better with the infrastructure in place at the moment.
>>
>> The danger of that position is that we end up with nothing happening,
>> and the problem remaining unresolved, which then pushes people into
>> maintaining patches out of mainline just to have a working setup -
>> which then pushes people to vendor trees.
>
> I agree.
>
> I didn't express my position clearly: I'm ok with the approach, if we
> don't come up with anything better.

I'm checking to see if I can use the overlay primitives directly from
the kernel.

It seems possible, basically to have a panel defined in the device tree
for VGA as default, and then augment it depending on what we detect.
Meaning I start to overwrite clock-frequency, pixelclk-active, hactive etc.
It basically means we go back to having a database in the kernel.

I would then even overwrite the .compatible string from the kernel.

It may be more elegant than this solution though?

> But if we go with this approach, it must be understood that it may cause
> problems later. It's not the most maintainable approach.
>
> I'd also like to have an ack from the DT maintainers, as I think this is
> somewhat of an abuse of the DT.

What I am doing in this patch is sort of a "Schr=C3=B6dinger's cat approach=
",
I basically say that the cat is both dead and alive until we open the
box, i.e. all displays are connected until we figure out which one it
actually is.

Basically the approach taken could even handle the case of switching
a display at runtime. Though I don't think the hardware would like that.

Yours,
Linus Walleij
