From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 22 Feb 2016 15:54:15 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdbO1+nWJOce8eC-G=tKrH3a2OEqQ-ro=LK88RhNrJ5cfQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk>
 <56C5B080.9090007@ti.com>
 <CACRpkdaXFUCR5=5mS28_4Dx_LfzqV13zwT=vVeJwuOzm_rGRBQ@mail.gmail.com>
 <56CB2C31.5040703@ti.com>
In-Reply-To: <56CB2C31.5040703@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 22, 2016 at 4:41 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> After thinking this a bit and discussing it with Laurent P., generally
> speaking I still think that the only sane option is that the bootloader
> does any detection needed and provides the kernel a .dtb that contains
> the HW that is connected. No board specific drivers are needed on the
> kernel side.
>
> In some cases userspace loaded DT overlays may be fine, if the userspace
> can do the detection and the device in question is not somehow critical
> to operation. But I think displays are critical, and afaik in Versatile
> case the userspace can't even do the detection (?).
>
> The third option is to have board specific display handling code and the
> display HW data in the kernel, as you've done in the patches.

Yeah correct...

> But, of course, which option should be used for which board is not
> always clear...
>
> What bootloader is used on Versatile?

It's U-boot indeed. Not that I've tried to compile or use it, I got it
as binary from ARM.

> If it's some proprietary loader
> which can't be changed, then the bootloader option is out, and I guess
> it points to the third option, i.e. either the version in this patch or
> the earlier version. If it's u-boot, I would suggest going for the
> bootloader option.
>
> Afaik u-boot doesn't support combining DT fragments yet. But (also
> afaik) the u-boot maintainer is ok with the idea. And I know there are
> others (for example TI) interested in the same functionality.

Hm OK.... so the bootloader need to be better at augmenting device
trees than the kernel. Well... The problem is that there are a bunch
of deployed systems out there and they all need to have their boot loader
updated then, which may be OK since it's ARM development boards
but I don't know.

> Now, adding that support might take some time, and in the meantime it'd
> be good to get the HW working with kernel with a temporary solution. To
> do that, my suggestion is basically "any solution which requires no
> (temporary) changes to .dts".
>
> While I don't like too much the solution in the patch here, it's all
> inside kernel code and can be dropped easily, right? If we would merge
> the the multi-endpoint solution you had in the earlier patch, you would
> have to support that .dts in the future too.

To go with this solution I need to extend the drivers/of library to be
able to update properties properly instead of this hack, and that is
non-reversible if we start to use it.

It is not really an overlay because the DT stuff is dynamically
augmented by the kernel, not taken from somewhere else.

Yours,
Linus Walleij
