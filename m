From: Tom Li <tomli@tomli.me>
Date: Thu, 07 Mar 2019 21:38:00 +0000
Subject: Re: Is it possible to reset graphics controller on reboot in a framebuffer driver?
Message-Id: <20190307213759.GA14798@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190307051641.GA7012@localhost.localdomain>
 <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
In-Reply-To: <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Yifeng Li <tomli@tomli.me>, Teddy Wang <teddy.wang@siliconmotion.com>

On Thu, Mar 07, 2019 at 10:39:23AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 7, 2019 at 10:00 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > It's possible to do this using a reboot notifier. I am not sure if there
> > are better ways to achieve the same, but there's at least one example of
> > using reboot notifiers to achieve the exact same goal.
> >
> > See drivers/video/fbdev/aty/atyfb_base.c, look for
> > register_reboot_notifier().
> 
> Or a shutdown handler, which is more device-centric?
> (cfr. "[3/4] fbdev: atafb: Fix broken frame buffer after kexec",
>  https://patchwork.kernel.org/patch/10814381/).
> 
> Gr{oetje,eeting}s,

Thanks, I knew reboot_notifier but I thought it feels "hacky" to use it in a
device driver, shutdown() handler looks better.

Nevertheless, does it mean there's no way to prevent it from happening if the
user issues a emergency reboot? Like an automatic reboot after a kernel panic,
or a SysRq-B reboot.

Tom Li
