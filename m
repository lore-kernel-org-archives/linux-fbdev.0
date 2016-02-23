From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 13:16:08 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
In-Reply-To: <56CC57FC.20707@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 2:00 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> That would be almost the same as what's already in this patch, except
> (if I'm not mistaken) the detection part could be in platform code, and
> the fbdev driver itself would know nothing about board specific
> detection or board specific panel lists.

In this patch set the board/platform-specific plugins are separated
out adding the opaque .board_init() and .panel_init() to the driver.
The platform-specific code is in completely separate files this way,
and the CLCD driver itself just handles various versions of that
IP block.

> So maybe that would be a bit cleaner. Still ugly, I think =). I really
> don't like having possible-panels in the Schrödinger's DT data
> (http://www.angryflower.com/387.html).

OK I will focus my work on the DT-augment code instead.

> That said, maybe this is the best way to deal with Versatile, without
> requiring any change to the bootloader or the boot mechanism.

Depends on if the OF core maintainers will accept my patches to
dynamically alter DT properties at runtime. If I can't do that then
I have to go back to the Schrödinger patch.

> What is the current status of Versatile? Have we had working display
> with Versatile when booting with device tree? Or has the display been
> supported only with legacy boot?

Versatile is DT only as of kernel v4.5. The DT boot uses AUXDATA
which is the Frankenstein solution, bolting on a boardfile piece
to the DT boot and ignoring the existing panel bindings, and of
course standing in the way of cleaning things up.

IMO Schrödinger > Frankenstein.

Yours,
Linus Walleij
