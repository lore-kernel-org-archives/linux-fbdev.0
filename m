From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 17 Jan 2013 23:11:07 +0000
Subject: Re: [PATCH 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <20130118001107.2a2c20ea@crub>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358454518-14032-2-git-send-email-agust@denx.de>
In-Reply-To: <1358454518-14032-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Jan 2013 16:20:04 -0600
Timur Tabi <timur@tabi.org> wrote:
...
> This is why you need hacks like can_handle_irq.  So I'm not crazy about
> this patch.  I think you need to get rid of can_handle_irq and allow the
> interrupt handler to be registered before the hardware is initialized.

It makes sense. More testing shows that disabling interrupts in
fsl_diu_release() needs to be fixed, too. If the fb0 plane is opened
(i.e. by fbcon) and another app opens an overlay plane i.e. on /dev/fb1
and then closes it, the diu interrupts will be disabled, even though the
first plane is still opened.

Thanks,

Anatolij
