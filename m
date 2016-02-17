From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Feb 2016 16:17:33 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
In-Reply-To: <56C438DA.5040109@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 17, 2016 at 10:09 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

>> Tested on Versatile AB with just VGA with the default device tree,
>> and with the IB2 daughterboard with the custom IB2 device tree.
>> Tested to shunt in XVGA by modifying the device tree and this works
>> too. Also tested on QEMU for Versatile in both VGA and Sanyo 2.5"
>> mode. I don't have the IB1 daughterboard and its add-on displays,
>> but it should work as long as the detection mechanism and device
>> tree parameters are sound.
>
> Well... I don't like this very much. The .dts should contain
> descriptions for hardware that is connected. Have you looked at DT
> overlays? I think they would be a much better match for this.

I'll look into it. I don't know how good those are. They must be overlaid
at runtime and anyways exist somewhere in memory so they can be
overlaid in there.

> What's the SYS_CLCD register? An EEPROM or such, programmed when the
> board is manufactured? Is the panel meant to be switchable by the user,
> possibly to a panel that's not "standard"?

As Russell points out: it's a register that contains a number saying what
panel is connected.

So it is plug-n-play and I want to preserve this in the patch.

The alternative is to make one DTS per display type connected, but that is
loosing all the nice plug'n'play :(

But if an overlay can do the same, I'm game for it.

Yours,
Linus Walleij
