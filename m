From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Mar 2019 09:13:58 +0000
Subject: Re: Is it possible to reset graphics controller on reboot in a framebuffer driver?
Message-Id: <CAMuHMdVnkdrUTL_3UaoaOondGxCB_FpEYOTDmLeh1C0W5j0-Hw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190307051641.GA7012@localhost.localdomain> <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com> <20190307213759.GA14798@localhost.localdomain>
In-Reply-To: <20190307213759.GA14798@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Li <tomli@tomli.me>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>

Hi Tom,

On Thu, Mar 7, 2019 at 10:38 PM Tom Li <tomli@tomli.me> wrote:
> On Thu, Mar 07, 2019 at 10:39:23AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2019 at 10:00 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > It's possible to do this using a reboot notifier. I am not sure if there
> > > are better ways to achieve the same, but there's at least one example of
> > > using reboot notifiers to achieve the exact same goal.
> > >
> > > See drivers/video/fbdev/aty/atyfb_base.c, look for
> > > register_reboot_notifier().
> >
> > Or a shutdown handler, which is more device-centric?
> > (cfr. "[3/4] fbdev: atafb: Fix broken frame buffer after kexec",
> >  https://patchwork.kernel.org/patch/10814381/).
> >
> > Gr{oetje,eeting}s,
>
> Thanks, I knew reboot_notifier but I thought it feels "hacky" to use it in a
> device driver, shutdown() handler looks better.
>
> Nevertheless, does it mean there's no way to prevent it from happening if the
> user issues a emergency reboot? Like an automatic reboot after a kernel panic,
> or a SysRq-B reboot.

If Linux performs a reboot, it calls the shutdown handlers.
I think that includes reboot on panic, or SysRq-B, but I'd have to check to
be 100% sure.

If the kernel just crashes, of course all of that doesn't happen.
Is your graphics card reset when the reset button is pressed, or only on
cold power on?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
