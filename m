From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:27:22 +0000
Subject: Re: [PATCH] [v2] drivers/video: use strings to specify the Freescale DIU monitor port
Message-Id: <20110713082722.GJ13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310243894-2660-1-git-send-email-timur@freescale.com>
In-Reply-To: <1310243894-2660-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, agust@denx.de

On Sat, Jul 09, 2011 at 03:38:14PM -0500, Timur Tabi wrote:
> Instead of using ill-defined numbers (0, 1, and 2) for the monitor port, allow
> the user to specify the port by name ("dvi", "lvds", or "dlvds").  This works
> on the kernel command line, the module command-line, and the sysfs "monitor"
> device.
> 
> Note that changing the monitor port does not currently work on the P1022DS,
> because the code that talks to the PIXIS FPGA is broken.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> Acked-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/512x/mpc512x_shared.c |   22 +++-----
>  arch/powerpc/platforms/85xx/p1022_ds.c       |   47 ++++++++---------
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   55 +++++++++----------
>  arch/powerpc/sysdev/fsl_soc.h                |   25 ++++++---
>  drivers/video/fsl-diu-fb.c                   |   74 +++++++++++++++++++-------
>  5 files changed, 128 insertions(+), 95 deletions(-)
> 
Applied, thanks.
