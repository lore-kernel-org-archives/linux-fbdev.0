From: Bernardo Innocenti <bernie@develer.com>
Subject: Re: [Linux-fbdev-devel] How to mmap a shadow framebuffer in virtual
 memory
Date: Tue, 06 Feb 2007 15:57:31 +0100
Message-ID: <45C8975B.30508@develer.com>
References: <45A97832.2040206@develer.com> <Pine.LNX.4.62.0701141211030.18479@pademelon.sonytel.be> <45AB196B.7090409@develer.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752260AbXBFO5h@vger.kernel.org>
In-Reply-To: <45AB196B.7090409@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Bernardo Innocenti <bernie@develer.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, aleph <aleph@develer.com>

Bernardo Innocenti wrote:

> I still couldn't solve my problem, but thanks for helping.
> 
> The way you map memory in ps3fb_mmap() is basically the same.
> In my case, memory is allocated with __get_free_pages() instead
> of being at an absolute physical address, but I can't see how
> it could make any difference.

A few weeks ago I found the solution, which I report here to help
people who are googling for the same problem.

consistent_alloc() performed all the required magic to allocate
a contiguous buffer in phisical memory:

 -       if (!(fb_info.shadow = (void *)__get_free_pages(GFP_KERNEL, OLED_MEMORDER))
 +       if (!(fb_info.shadow = consistent_alloc(GFP_KERNEL, PAGE_ALIGN(OLED_MEMSIZE),
 +                       &fb_info.shadow_phys, PTE_BUFFERABLE))


The complete patch set is here, just in case:

   http://www.develer.com/patches/linux/pending/

-- 
   // Bernardo Innocenti - Develer S.r.l., R&D dept.
 \X/  http://www.develer.com/
