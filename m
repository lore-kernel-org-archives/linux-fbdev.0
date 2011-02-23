From: James Simmons <jsimmons@infradead.org>
Date: Wed, 23 Feb 2011 14:58:31 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <alpine.LFD.2.00.1102231456060.13092@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> > Can't the SH_FB_YUV macro definition go into
> > include/video/sh_mobile_lcdc.h too?
> 
> My thinking behind separating this out was that I wanted this
> define to be accessible from user space.  The reason is so that
> an application can test the value of .nonstd against the flag to
> know for sure if it is dealing with a YUV framebuffer or not.
> I was under the impression that only headers under include/linux/ should be
> accessed from user space, but to be honest, I'm not sure about that.
> If that is in fact not the case, then I totally agree that it can go
> into include/video/sh_mobile_lcdc.h.
> Do you know where the proper place for such a header would be?

Originally the idea was headers in include/video would be card 
specific material to be used by userspace. Also those headers could be 
used also by the kernel driver as well.

