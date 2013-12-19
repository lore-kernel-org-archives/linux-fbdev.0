From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 19 Dec 2013 15:58:46 +0000
Subject: Re: [PATCH] x86: sysfb: fool-proof CONFIG_X86_SYSFB
Message-Id: <20131219155846.GA27790@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387460330-13989-1-git-send-email-dh.herrmann@gmail.com>
 <20131219154020.GB20044@gmail.com>
 <CANq1E4TSh7-WWiRfBUAXZPK+_87=Ven_kK=NHeN8C+daNWdSFQ@mail.gmail.com>
In-Reply-To: <CANq1E4TSh7-WWiRfBUAXZPK+_87=Ven_kK=NHeN8C+daNWdSFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, the arch/x86 maintainers <x86@kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, stable <stable@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* David Herrmann <dh.herrmann@gmail.com> wrote:

> Hi
> 
> On Thu, Dec 19, 2013 at 4:40 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * David Herrmann <dh.herrmann@gmail.com> wrote:
> >
> >> Turns out, people do not read help-texts of new config-options and
> >> enable them nonetheless. [...]
> >
> > Yeah, I too don't read them either, whenever an option name seems
> > obvious to enable, so this is really something that happens frequently
> > ;-)
> >
> >> [...] So several reports came in with X86_SYSFB=y and FB_SIMPLE=n,
> >> which in almost all situations prevents firmware-fbs from being
> >> probed.
> >>
> >> X86_SYSFB clearly states that it turns legacy vesa/efi framebuffers
> >> into a format compatible to simplefb (and does nothing else..). So
> >> to avoid further complaints about missing gfx-support during boot,
> >> simply depend on FB_SIMPLE now.
> >>
> >> As FB_SIMPLE is disabled by default and usually only enabled on
> >> selected ARM architectures, x86 users should thus never see the
> >> X86_SYSFB config-option. And if they do, everything is fine as
> >> simplefb will be available.
> >>
> >> Note that most of the sysfb code is enabled independently of
> >> X86_SYSFB. The config option only selects a compatibility mode for
> >> simplefb. It was introduced to ease the transition to SimpleDRM and
> >> disabling fbdev. As this is still ongoing, there's no need for
> >> non-developers to care for X86_SYSFB so just change the help-text
> >> recommendation to "n".
> >>
> >> Cc: <stable@vger.kernel.org> # 3.11+
> >> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> >> ---
> >>  arch/x86/Kconfig | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index e903c71..9317ede 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -2298,6 +2298,7 @@ source "drivers/rapidio/Kconfig"
> >>
> >>  config X86_SYSFB
> >>       bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
> >> +     depends on (FB_SIMPLE = y)
> >
> > Could that be written as:
> >
> >         depends on FB_SIMPLE
> >
> > Or is there some complication with modular builds?
> 
> simplefb is actually "bool" so yeah, I can remove the "= y".
> 
> Note that *if* it ever is built as module, it will not get loaded
> during boot, thus not showing any boot-messages. But that's true for
> vesafb/efifb, too, so we're fine.
> 
> >>       help
> >>         Firmwares often provide initial graphics framebuffers so the BIOS,
> >>         bootloader or kernel can show basic video-output during boot for
> >> @@ -2320,7 +2321,7 @@ config X86_SYSFB
> >>         and others enabled as fallback if a system framebuffer is
> >>         incompatible with simplefb.
> >>
> >> -       If unsure, say Y.
> >> +       If unsure, say N.
> >
> > We might in fact leave this bit alone and suggest 'Y' - with the
> > robustification fixes it's not possible anymore to crash the boot or
> > to create an unintentionally headless system, right?
> 
> Nope, we will not cause a headless system, but the handover to other
> fbdev/DRM drivers (other than the common nouveau/radeon/i915) may
> still fail without the other patch (x86: sysfb: remove sysfb when
> probing real hw).
> 
> I will gladly keep the Y, if no-one disagrees. Given that the other 
> patch is rather complex (and a no-op with X86_SYSFB=n) I wasn't 
> quite sure. But as SYSFB is set to 'n' now if FB_SIMPLE wasn't 
> explicitly selected, I think we're fine both ways.

Well, as long as fixes keep coming when people report them, I see no 
problem with keeping the 'Y'. Bugs happen.

And I think we want to apply the other fix regardless of the default.

Thanks,

	Ingo
