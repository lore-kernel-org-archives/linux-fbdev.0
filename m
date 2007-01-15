From: Bernardo Innocenti <bernie@develer.com>
Subject: Re: [Linux-fbdev-devel] How to mmap a shadow framebuffer in virtual
 memory
Date: Mon, 15 Jan 2007 07:04:27 +0100
Message-ID: <45AB196B.7090409@develer.com>
References: <45A97832.2040206@develer.com> <Pine.LNX.4.62.0701141211030.18479@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751821AbXAOGFG@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0701141211030.18479@pademelon.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, aleph <aleph@develer.com>

Geert Uytterhoeven wrote:

> It's known to work for the PS3 frame buffer device driver, which copies the
> virtual frame buffer to the GPU on every vsync. Check out ps3fb_mmap() in
> http://www.kernel.org/git/?p=linux/kernel/git/geoff/ps3-linux.git;a=blob_plain;f=drivers/video/ps3fb.c;hb=HEAD

I still couldn't solve my problem, but thanks for helping.

The way you map memory in ps3fb_mmap() is basically the same.
In my case, memory is allocated with __get_free_pages() instead
of being at an absolute physical address, but I can't see how
it could make any difference.

-- 
   // Bernardo Innocenti - Develer S.r.l., R&D dept.
 \X/  http://www.develer.com/
