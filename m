From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 18 May 2011 10:15:10 +0000
Subject: Re: [PATCH 2/2] trivial: Changed the printk loglevel when not able
Message-Id: <1305713710.11468.39.camel@e102109-lin.cambridge.arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305653342.2182.15.camel@anish-desktop>
	 <BANLkTi=AGbuU-jyhqaSF+yXA3qQuKVLWfA@mail.gmail.com>
	 <BANLkTi=ngJiMyVt4AMqcWUSUM2EVXtjRQQ@mail.gmail.com>
In-Reply-To: <BANLkTi=ngJiMyVt4AMqcWUSUM2EVXtjRQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anish singh <anish198519851985@gmail.com>
Cc: linux@arm.linux.org.uk, lethal@linux-sh.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2011-05-18 at 04:19 +0100, anish singh wrote:
> On Tue, May 17, 2011 at 11:13 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>         On 17 May 2011 18:29, anish <anish198519851985@gmail.com> wrote:
>         > When not able to allocate memory we were using KERN_INFO as
>         > log level in printk so changed to KERN_ERR
>         >  Signed-off-by: anish kumar<anish198519851985@gmail.com>
>         
>         
>         Maybe KERN_WARN?
> Then shouldn't we change below case also?
> 467         ret = amba_request_regions(dev, NULL);
> 468         if (ret) {
> 469                 printk(KERN_ERR "CLCD: unable to reserve regs region\n");
> 470                 goto out;
> 
> If yes,then i will resend the patch for this also.

I think the register reserving is less likely to fail because of memory
allocations but more because of overlapping regions, in which case it
could be a programming error.

Allocating a big framebuffer is likely to fail in some memory constraint
systems but I don't consider this a kernel error. That's why I suggested
warning.

-- 
Catalin


