From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 10/10] [HEADS UP] fbdev: Move arch-specific bits to
	their respective subdirectories
Date: Thu, 17 May 2007 06:59:05 +0800
Message-ID: <1179356345.4743.6.camel@daplas>
References: <464B78BC.4080900@gmail.com>
	 <20070516.145317.03979683.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763295AbXEPW7Y@vger.kernel.org>
In-Reply-To: <20070516.145317.03979683.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 2007-05-16 at 14:53 -0700, David Miller wrote:
> From: "Antonino A. Daplas" <adaplas@gmail.com>
> Date: Thu, 17 May 2007 05:33:48 +0800
> 
> > Move arch-specific bits of fb_mmap() to their respective subdirectories
> > 
> > Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> > ---
> > Hi all,
> > 
> > Please let me know if there are mistakes with this patch.
> 
> Thank you for doing this work.
> 
> __sparc_v9__ means CONFIG_SPARC64, if that is not defined it's
> CONFIG_SPARC32, so you could simplify this patch a lot.
> 
> 1) Remove __sparc_v9__ ifdefs from asm-sparc64/fb.h
> 2) Define fb_mmap_required() to return 0 in asm-sparc64/fb.h
> 3) Define fb_mmap_required() to return 1 in asm-sparc/fb.h
> 4) Remove all the sparc ifdef stuff you added to linux/fb.h
> 5) There won't be a default fb_mmap_required() provided by
>    linux/fb.h on platforms other than sparc ones, you'll need
>    to provide one in order for the build to work non-sparc since
>    this call is unconditional in fbmem.c:
> 
> +	if (fb_mmap_required())
> +		return -EINVAL;
> 
> With those fixes:
> 

Okay, I see what you mean.  I will concoct another patch later.

Tony
