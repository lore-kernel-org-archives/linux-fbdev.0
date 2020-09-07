From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 07 Sep 2020 07:55:59 +0000
Subject: Re: [PATCH v1 0/2] video: fbdev: radeonfb: PCI PM framework upgrade and fix-ups.
Message-Id: <20200907075559.GN2352366@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bjorn Helgaas <bjorn@helgaas.com>, Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, Vaibhav Gupta <vaibhav.varodek@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <treding@nvidia.com>, linux-kernel-mentees@lists.linuxfoundation.org

On Thu, Aug 06, 2020 at 12:52:54PM +0530, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management. 
> 
> The original goal of the patch series is to upgrade the power management
> framework of radeonfb fbdev driver. This has been done by upgrading .suspend()
> and .resume() callbacks.
> 
> The upgrade makes sure that the involvement of PCI Core does not change the
> order of operations executed in a driver. Thus, does not change its behavior.
> 
> During this process, it was found that "#if defined(CONFIG_PM)" at line 1434 is
> redundant. This was introduced in the commit
> 42ddb453a0cd ("radeon: Conditionally compile PM code").

I do wonder whether it wouldn't be better to just outright delete these,
we have the drm radeon driver for pretty much all the same hardware ...
-Daniel

> 
> ------------
> 
> Before 42ddb453a0cd:
> $ git show 65122f7e80b5:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"
> 
> Based on output in terminal:
> 
> 547:#ifdef CONFIG_PM
>        |-- 959:#ifdef CONFIG_PPC_PMAC
>        |-- 972:#endif
>        |-- 1291:#ifdef CONFIG_PPC_OF
>        |-- 1301:#endif /* CONFIG_PPC_OF */
>        |-- 1943:#ifdef CONFIG_PPC_OF
>                    |-- 2206:#if 0 /* Not ready yet */
>                    |-- 2508:#endif /* 0 */
>        |-- 2510:#endif /* CONFIG_PPC_OF */
>        |-- 2648:#ifdef CONFIG_PPC_PMAC
>        |-- 2654:#endif /* CONFIG_PPC_PMAC */
>        |-- 2768:#ifdef CONFIG_PPC_PMAC
>        |-- 2774:#endif /* CONFIG_PPC_PMAC */
>        |-- 2791:#ifdef CONFIG_PPC_OF__disabled
>        |-- 2801:#endif /* CONFIG_PPC_OF */
> 2803:#endif /* CONFIG_PM */
> 
> ------------
> 
> After 42ddb453a0cd:
> $ git show 42ddb453a0cd:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"
> 
> Based on output in terminal:
> 
> 547:#ifdef CONFIG_PM
>        |-- 959:#ifdef CONFIG_PPC_PMAC
>        |-- 972:#endif
>        |-- 1291:#ifdef CONFIG_PPC_OF
>        |-- 1301:#endif /* CONFIG_PPC_OF */
>        |-- 1430:#if defined(CONFIG_PM)
>                    |-- 1431:#if defined(CONFIG_X86) || defined(CONFIG_PPC_PMAC)
>                    |-- 1944:#endif
>                    |-- 1946:#ifdef CONFIG_PPC_OF
>                                |-- 1947:#ifdef CONFIG_PPC_PMAC
>                                |-- 2208:#endif
>                    |-- 2209:#endif
>                    |-- 2211:#if 0 /* Not ready yet */
>                    |-- 2513:#endif /* 0 */
>        |-- 2515:#endif /* CONFIG_PPC_OF */
>        |-- 2653:#ifdef CONFIG_PPC_PMAC
>        |-- 2659:#endif /* CONFIG_PPC_PMAC */
>        |-- 2773:#ifdef CONFIG_PPC_PMAC
>        |-- 2779:#endif /* CONFIG_PPC_PMAC */
>        |-- 2796:#ifdef CONFIG_PPC_OF__disabled
>        |-- 2806:#endif /* CONFIG_PPC_OF */
> 2808:#endif /* CONFIG_PM */
> 
> ------------
> 
> This also affected the CONFIG_PPC_OF container (line 1943 at commit 65122f7e80b5)
> 
> The patch-series fixes it along with PM upgrade.
> 
> All patches are compile-tested only.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> Vaibhav Gupta (2):
>   video: fbdev: aty: radeon_pm: remove redundant CONFIG_PM container
>   fbdev: radeonfb:use generic power management
> 
>  drivers/video/fbdev/aty/radeon_base.c | 10 ++++---
>  drivers/video/fbdev/aty/radeon_pm.c   | 38 ++++++++++++++++++++-------
>  drivers/video/fbdev/aty/radeonfb.h    |  3 +--
>  3 files changed, 35 insertions(+), 16 deletions(-)
> 
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
