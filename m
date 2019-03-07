From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 07 Mar 2019 09:39:23 +0000
Subject: Re: Is it possible to reset graphics controller on reboot in a framebuffer driver?
Message-Id: <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190307051641.GA7012@localhost.localdomain>
 <871s3jm532.fsf@intel.com>
In-Reply-To: <871s3jm532.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi Jani,

On Thu, Mar 7, 2019 at 10:00 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 07 Mar 2019, Tom Li <tomli@tomli.me> wrote:
> > As you may have noticed, recently I've been working on a reworked version
> > of sm712fb, and planned to convert it to a DRM/KMS driver. Besides using
> > it on embedded/non-x86 systems, I thought it would be a good idea to support
> > histrocial x86 laptops with this VGA chipset as well, so I've acquired a
> > machine for testing.
> >
> > However, soon I found a nasty problem. The BIOS does not reset the chip
> > on boot! Like most graphics controller of that era, sm712 chipset has a
> > VGA compatible mode and a 2D framebuffer mode. The power-on default is
> > VGA. The BIOS writer just assumed this, and does nothing to reinitialize
> > it. If one uses the framebuffer driver under Linux, once the machine reboots,
> > the entire LCD panel becomes a piece of garbage.
> >
> > AFAIK, the framebuffer driver would be running throughout the kernel's life-
> > cycle, is it really possible to workaround this issue by restoring on VGA
> > state upon reboot?
>
> It's possible to do this using a reboot notifier. I am not sure if there
> are better ways to achieve the same, but there's at least one example of
> using reboot notifiers to achieve the exact same goal.
>
> See drivers/video/fbdev/aty/atyfb_base.c, look for
> register_reboot_notifier().

Or a shutdown handler, which is more device-centric?
(cfr. "[3/4] fbdev: atafb: Fix broken frame buffer after kexec",
 https://patchwork.kernel.org/patch/10814381/).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
