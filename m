From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 13 Feb 2013 00:54:58 +0000
Subject: Re: [PATCH RESEND v2 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <20130212165458.1322d5f8.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360308959-3096-2-git-send-email-agust@denx.de>
In-Reply-To: <1360308959-3096-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri,  8 Feb 2013 08:35:59 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> Since commit f74de500 "drivers/video: fsl-diu-fb: streamline
> enabling of interrupts" the interrupt handling in the driver
> is broken. Enabling diu interrupt causes an interrupt storm and
> results in system lockup.
> 
> The cookie for the interrupt handler function passed to request_irq()
> is wrong (it must be a pointer to the diu struct, and not the address
> of the pointer to the diu struct). As a result the interrupt handler
> can not read diu registers and acknowledge the interrupt. Fix cookie
> arguments for request_irq() and free_irq().
> 
> Registering the diu interrupt handler in probe() must happen before
> install_fb() calls since this function registers framebuffer devices
> and if fbcon tries to take over framebuffer after registering a frame
> buffer device, it will call fb_open of the diu driver and enable the
> interrupts. At this time the diu interrupt handler must be registered
> already.
> 
> Disabling the interrupts in fsl_diu_release() must happen only if all
> other AOIs are closed. Otherwise closing an overlay plane will disable
> the interrupts even if the primary frame buffer plane is opened. Add
> an appropriate check in the release function.
> 
> ...
>
>  This patch fixes a regression, it should be included in v3.8 since
>  without it all mpc512x based boards (with DIU support enabled) do not
>  boot

Thanks, I queued both these with a plan to merge into 3.9-rc1.  I
tagged the patches with "Cc: <stable@vger.kernel.org>" so they should
get backported into 3.8.1 and possibly earlier kernels.  Sound OK?
