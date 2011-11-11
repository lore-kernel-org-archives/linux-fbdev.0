From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Fri, 11 Nov 2011 16:41:25 +0000
Subject: Re: [RFC] drivers/video: fsl-diu-fb: combine several allocated
Message-Id: <4EBD5033.2020603@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1320793445-29562-1-git-send-email-timur@freescale.com>
In-Reply-To: <1320793445-29562-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:

> The idea to merge multiple DMA objects sounds good. But I think you might want
> to have a look at what you put in the DMA area. I think it would be better and
> cleaner to put things that should be never accessed by the device, like
> fsl_diu_info, irq, reg_lock and so on, in a separate structure.

Hmmm... you have a valid point, but I'm not keen on the idea of having two 
memory blocks.  I was even hoping to put mfb_info objects in fsl_diu_info, 
but framebuffer_alloc() won't let me.

>> Documentation for some affected data structures and variables is added.
>
> You could do this in an separate patch as it's independent of your idea to merge
> the DMA objects. Well, I do not care very much in this case.

I can split it out.  It will give me the chance to add even more 
documentation.

-- 
Timur Tabi
Linux kernel developer at Freescale
