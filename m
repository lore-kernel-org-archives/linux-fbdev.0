From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:14 +0000
Subject: Re: [PATCH v3 00/12] video: fbdev: use generic power management
Message-Id: <7660f403-ff17-04c2-91d3-1d1ff0510e87@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200819185901eucas1p2a6c54c905c199e6a04de8477cfa6539e@eucas1p2.samsung.com>
 <20200819185654.151170-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org, Bjorn Helgaas <bjorn@helgaas.com>, Paul Mackerras <paulus@samba.org>, Andres Salomon <dilinger@queued.net>, Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org, linux-kernel-mentees@lists.linuxfoundation.org


On 8/19/20 8:56 PM, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to upgrade power management in video fbdev
> drivers. This has been done by upgrading .suspend() and .resume() callbacks.
> 
> The upgrade makes sure that the involvement of PCI Core does not change the
> order of operations executed in a driver. Thus, does not change its behavior.
> 
> In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
> helper functions like pci_enable/disable_device_mem(), pci_set_power_state(),
> pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
> their job.
> 
> The conversion requires the removal of those function calls, change the
> callbacks' definition accordingly and make use of dev_pm_ops structure.
> 
> All patches are compile-tested only.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> Vaibhav Gupta (12):
>   fbdev: gxfb: use generic power management
>   fbdev: lxfb: use generic power management
>   fbdev: via-core: use generic power management
>   fbdev: aty: use generic power management
>   fbdev: aty128fb: use generic power management
>   fbdev: nvidia: use generic power management
>   fbdev: savagefb: use generic power management
>   fbdev: cyber2000fb: use generic power management
>   fbdev: i740fb: use generic power management
>   fbdev: vt8623fb: use generic power management
>   fbdev: s3fb: use generic power management
>   fbdev: arkfb: use generic power management
> 
>  drivers/video/fbdev/arkfb.c                  | 41 ++++++-------
>  drivers/video/fbdev/aty/aty128fb.c           | 51 ++++++++++------
>  drivers/video/fbdev/aty/atyfb_base.c         | 50 ++++++++++-----
>  drivers/video/fbdev/cyber2000fb.c            | 13 ++--
>  drivers/video/fbdev/geode/gxfb.h             |  5 --
>  drivers/video/fbdev/geode/gxfb_core.c        | 36 ++++++-----
>  drivers/video/fbdev/geode/lxfb.h             |  5 --
>  drivers/video/fbdev/geode/lxfb_core.c        | 37 +++++------
>  drivers/video/fbdev/geode/lxfb_ops.c         |  4 --
>  drivers/video/fbdev/geode/suspend_gx.c       |  4 --
>  drivers/video/fbdev/i740fb.c                 | 40 +++++-------
>  drivers/video/fbdev/nvidia/nvidia.c          | 64 +++++++++++---------
>  drivers/video/fbdev/s3fb.c                   | 39 +++++-------
>  drivers/video/fbdev/savage/savagefb_driver.c | 52 ++++++++++------
>  drivers/video/fbdev/via/via-core.c           | 39 +++++-------
>  drivers/video/fbdev/vt8623fb.c               | 41 ++++++-------
>  include/linux/via-core.h                     |  2 -
>  17 files changed, 267 insertions(+), 256 deletions(-)

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
