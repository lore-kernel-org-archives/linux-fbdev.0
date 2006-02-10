From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] fbdev: Fix typo in fbmem.c
Date: Fri, 10 Feb 2006 17:34:07 +0100
Message-ID: <20060210163407.GA3531@inferi.kami.home>
References: <20060207220627.345107c3.akpm@osdl.org> <20060210145243.GA3581@inferi.kami.home> <43ECADBC.2080107@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751287AbWBJQde@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43ECADBC.2080107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, Feb 10, 2006 at 11:14:04PM +0800, Antonino A. Daplas wrote:
> A typo in fbmem.c prevents recognition of video= parameter.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> ---
> Mattia Dongili wrote:
> 
> > On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> > 
> > Hello,
> > 
> > radeonfb ignores the video= parameter and always run at 1400x1050 (the
> > highest available). Things where fine with .16-rc1-mm5.
> > I also tried booting with 640x480-32@60 without success.
> 
> Try this patch.

Thanks, now working as usual. (BTW: my ISP smtp is blacklisted so my
messages won't reach linux-fbdev-devel)

ciao
-- 
mattia
:wq!
