From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 16:47:23 +0000
Subject: Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140813164723.GG31326@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org>
In-Reply-To: <53EB9471.3090204@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>
> I think this make simplefb not simple any more, which rather goes  
> against the whole point of it.
>
> I specifically conceived simplefb to know about nothing more than the  
> memory address and pixel layout of the memory buffer. I certainly don't  
> like the idea of expanding simplefb to anything beyond that, and IIRC  
> *not* extending is was a condition agreed when it was first merged. If  
> more knowledge than that is required, then there needs to be a  
> HW-specific driver to manage any clocks/resets/video registers, etc.

Yes. Simplefb quickly becomes anything but, doesn't it. Perhaps DenialFB 
would've been a better name for it ;p

> The correct way to handle this without a complete DRM/KMS/... driver is  
> to avoid the clocks in question being turned off at boot. I thought  
> there was a per-clock flag to prevent disabling an unused clock? If not,  
> perhaps the clock driver should force the clock to be enabled (perhaps  
> only if the DRM/KMS driver isn't enabled?). For example, the Tegra clock  
> driver has a clock initialization table which IIRC was used for this  
> purpose before we got a DRM/KMS driver. That way, all the details are  
> kept inside the kernel code, and don't end up influencing the DT  
> representation of simplefb.

How was simplefb handled on tegra? Where is the code for that? I didn't 
see anything in u-boot for instance.

But the code for handling clocks where they are supposed to be handled 
is pretty generic from where i sit.

Luc Verhaegen.
