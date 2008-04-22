From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] atyfb: Fix 64 bits resources on 32 bits archs
Date: Tue, 22 Apr 2008 19:43:56 +0400
Message-ID: <480E07BC.3050107@ru.mvista.com>
References: <20080422012726.42775DE2A3@ozlabs.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932236AbYDVPop@vger.kernel.org>
In-Reply-To: <20080422012726.42775DE2A3@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, adaplas@gmail.com

Benjamin Herrenschmidt wrote:

> This fixes atyfb to not truncate 64 bits resources on 32 bits
> platforms. Unfortunately, there are still issues with addresses
> returned to userspace via struct fb_fix_screeninfo. This will
> have to be dealt with separately.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[...]
> --- linux-work.orig/drivers/video/aty/atyfb_base.c	2008-04-22 11:21:46.000000000 +1000
> +++ linux-work/drivers/video/aty/atyfb_base.c	2008-04-22 11:23:58.000000000 +1000
> @@ -2842,7 +2842,7 @@ static int atyfb_setcolreg(u_int regno, 
>  #ifdef __sparc__
>  
>  static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
> -			struct fb_info *info, unsigned long addr)
> +			struct fb_info *info, resource_size_t addr)

    Not sure what that change gives us -- this function mostly treats 'addr' 
as unsigned long (casting it to char/void *), ot compares it to 'unsigned 
long' 'base' variable -- which should be made 'resource_size_t' in its turn 
being assigned resource's start value.  So, this part of patch looks incomplete
(and yet I'm not sure if SPARC really needs all that)...

WBR, Sergei
