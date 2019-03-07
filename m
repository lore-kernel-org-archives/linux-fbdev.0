From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Thu, 07 Mar 2019 08:58:57 +0000
Subject: Re: Is it possible to reset graphics controller on reboot in a framebuffer driver?
Message-Id: <871s3jm532.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190307051641.GA7012@localhost.localdomain>
In-Reply-To: <20190307051641.GA7012@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Yifeng Li <tomli@tomli.me>, Teddy Wang <teddy.wang@siliconmotion.com>

On Thu, 07 Mar 2019, Tom Li <tomli@tomli.me> wrote:
> Hi all.
>
> As you may have noticed, recently I've been working on a reworked version
> of sm712fb, and planned to convert it to a DRM/KMS driver. Besides using
> it on embedded/non-x86 systems, I thought it would be a good idea to support
> histrocial x86 laptops with this VGA chipset as well, so I've acquired a
> machine for testing.
>
> However, soon I found a nasty problem. The BIOS does not reset the chip
> on boot! Like most graphics controller of that era, sm712 chipset has a
> VGA compatible mode and a 2D framebuffer mode. The power-on default is
> VGA. The BIOS writer just assumed this, and does nothing to reinitialize
> it. If one uses the framebuffer driver under Linux, once the machine reboots,
> the entire LCD panel becomes a piece of garbage.
>
> AFAIK, the framebuffer driver would be running throughout the kernel's life-
> cycle, is it really possible to workaround this issue by restoring on VGA
> state upon reboot?

It's possible to do this using a reboot notifier. I am not sure if there
are better ways to achieve the same, but there's at least one example of
using reboot notifiers to achieve the exact same goal.

See drivers/video/fbdev/aty/atyfb_base.c, look for
register_reboot_notifier().


HTH,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
