From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Fix /proc/fb oops after module removal
Date: Sun, 13 Apr 2008 08:42:47 -0700
Message-ID: <20080413084247.245d4711@laptopd505.fenrus.org>
References: <20080412211029.GG9151@martell.zuzino.mipt.ru>
	<20080412152006.02134bf3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759382AbYDMPrq@vger.kernel.org>
In-Reply-To: <20080412152006.02134bf3.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, adaplas@gmail.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sat, 12 Apr 2008 15:20:06 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 13 Apr 2008 01:10:29 +0400 Alexey Dobriyan
> <adobriyan@gmail.com> wrote:
> 
> > /proc/fb is not removed during rmmod.
> > 
> > Steps to reproduce:
> > 
> > 	modprobe fb
> > 	rmmod fb
> > 	ls /proc
> > 

> 
> hm, that's the sort of thing which one would expect people to notice
> fairly soon after we added the bug.  Yet it appears that the bug is
> present in at least 2.6.20 and probably earlier.

rmmod is generally a rare operation... esp for something like a framebuffer

wonder if we need a scripted action that loads all modules and then tries to 
unload the ones it can

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
