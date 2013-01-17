From: Timur Tabi <timur@tabi.org>
Date: Thu, 17 Jan 2013 22:20:04 +0000
Subject: Re: [PATCH 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <50F87914.8000609@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358454518-14032-2-git-send-email-agust@denx.de>
In-Reply-To: <1358454518-14032-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anatolij Gustschin wrote:
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

Ok, thanks for catching this.  I don't know how I missed it.

> Masking the diu interrupts in probe() must happen before install_fb()
> calls since this function registers framebuffer devices and if fbcon
> tries to take over framebuffer after registering a framebuffer device,
> it will call fb_open of the diu driver and enable the interrupts. But
> at this time the diu interrupt handler is not registered yet. Therefore
> we must mask the diu interrupts before registering the framebuffers
> and enable the interrupts after registering the handler.

The root cause of this problem is that the hardware is initialized in the
.probe(), but it should instead be initialized in the .open.  This has
been a major design flaw in the DIU driver that I've hoping to fix, but I
never got around to it (and probably never will).

This is why you need hacks like can_handle_irq.  So I'm not crazy about
this patch.  I think you need to get rid of can_handle_irq and allow the
interrupt handler to be registered before the hardware is initialized.

-- 
Timur Tabi
