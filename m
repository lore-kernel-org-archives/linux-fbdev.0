From: Tom Li <tomli@tomli.me>
Date: Thu, 07 Mar 2019 05:16:41 +0000
Subject: Is it possible to reset graphics controller on reboot in a framebuffer driver?
Message-Id: <20190307051641.GA7012@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi all.

As you may have noticed, recently I've been working on a reworked version
of sm712fb, and planned to convert it to a DRM/KMS driver. Besides using
it on embedded/non-x86 systems, I thought it would be a good idea to support
histrocial x86 laptops with this VGA chipset as well, so I've acquired a
machine for testing.

However, soon I found a nasty problem. The BIOS does not reset the chip
on boot! Like most graphics controller of that era, sm712 chipset has a
VGA compatible mode and a 2D framebuffer mode. The power-on default is
VGA. The BIOS writer just assumed this, and does nothing to reinitialize
it. If one uses the framebuffer driver under Linux, once the machine reboots,
the entire LCD panel becomes a piece of garbage.

AFAIK, the framebuffer driver would be running throughout the kernel's life-
cycle, is it really possible to workaround this issue by restoring on VGA
state upon reboot?

Thanks,
Tom Li
