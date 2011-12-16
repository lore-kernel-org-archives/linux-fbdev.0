From: Timur Tabi <timur@freescale.com>
Date: Fri, 16 Dec 2011 18:24:49 +0000
Subject: Re: [PATCH v4 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <4EEB8CF1.4050902@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279893639-24333-4-git-send-email-agust@denx.de>
In-Reply-To: <1279893639-24333-4-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anatolij Gustschin wrote:

> We cannot guarantee that the DIU is not in these modes. Even
> if U-Boot didn't set these modes there is still a possibility
> that such mode is configured. E.g. I've seen U-Boot binary
> standalone applications for other display controllers initializing
> the display controller.

True, but modes 2 and 3 don't make any sense.  2 is just a color bar, and 3 writes back to memory (which means you need to have a reserved DMA buffer otherwise you'll crash).  Have you really seen Linux boot with the DIU in either of these modes?

> But you are right. With this snippet, if the DIU is already
> disabled, there will be not needed mode register access. So
> the code should better look like:
> 
> diu_mode = in_be32(&dr.diu_reg->diu_mode);
> if (diu_mode && diu_mode != MFB_MODE1)
> 	out_be32(&dr.diu_reg->diu_mode, 0);

Ok.  I'm planning on cleaning up the driver so that it does not initialize the DIU until the .open call, and once that's done, I should be able to remove most of the code from your patch.

-- 
Timur Tabi
Linux kernel developer at Freescale

