From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 13 Aug 2014 07:54:21 +0000
Subject: Re: simplefb: add clock handling
Message-Id: <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
In-Reply-To: <1407914239-12054-1-git-send-email-libv@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

On Wed, Aug 13, 2014 at 9:17 AM, Luc Verhaegen <libv@skynet.be> wrote:
> This is needed for the sunxi platform, where the u-boot initialized display
> engine gets disabled by the clocks framework if certain clocks are not
> claimed. Once these clocks are disabled, register content is lost, and there
> is no turning back unless a full display driver is loaded, which kind of
> beats the purpose of having simplefb running.
>
> The lack of clock handling should plague more hardware, but so far rpi is the
> best known user of simplefb, and its stepmotherly handling of the arm core
> has kept these sort of issues from the kernel.
>
> The sunxi u-boot side code can be found here:
> https://groups.google.com/forum/#!topic/linux-sunxi/dPs958sIXvY
>
> Patch 3 might be controversial, as this does not achieve anything real today,
> since the status property in dt is only really evaluated when dealing with a
> nodes memory. It still seems like a good idea to at least flag this memory or
> node as disabled, as we really have no way back when the clocks get disabled.

Hans de Goede shortly told me about this and, tbh, I am not very
pleased. Stephen tried to keep simplefd "as simple as possible", your
patch now adds hardware-specific features. To be fair, the patch is
simple and clocks are easy to handle, but I somehow fear we have to
add more and more hardware-support that is required to keep the
framebuffer active. This really defeats the purpose of simplefb.

The biggest question I have, is why do you add the clocks to your DT
at all? The framebuffer is set up by your boot-loader (or maybe
platform code) and should prepare the clocks. I don't see why we add
the clocks to DT now. If they're not added, then no-one will disable
them and simplefb works just fine, right?

Or is there some requirement to make DT a _complete_ hw-description?
Or is there some parent clock which might be used by other drivers and
controls the clock used for your display?

The only reason I see to add the clocks, is to support both, simplefb
*and* a hardware-driver. However, fbdev hand-over is horribly racy and
I'd much rather prefer a solution like sysfb that does proper handover
from primitive firmware-FBs to real hardware-drivers. In that case,
we'd have to figure out how to deal with clocks, but we could do it in
sysfb (which is meant to deal with those issues) with the benefit of
controlling hand-over directly, and allowing hw-dependent features.

My sysfb patches haven't been updated for a while, though, and you
have a working solution here. So I'm not going to NAK this, I
appreciate people working on this. But I'd like to get a discussion
started so we can at least figure out some nicer solution for the
future which might replace your code.

Btw., my current idea was to destroy the platform-devices of EFI/VGA
framebuffers during hand-over (because usually the underlying hw is
shutdown/modified). This automatically unloads simplefb and makes sure
the real hw-driver can be probed without other drivers touching the
hardware in parallel. Iff you unload the hw-driver afterwards, it can
re-create the firmware framebuffer and add a platform-device to make
simplefb load again (in case anyone really needs this).
Looking at your 3rd patch, I wonder whether this works with DT based
machines, or whether we'd have to use the "disable" mechanism you
chose. Any reason destroying the device would not work there? If yes,
I will look into the "disable-idea".

Thanks
David
