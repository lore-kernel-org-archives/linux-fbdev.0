From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Date: Mon, 22 Nov 2004 01:10:51 +0100
Message-ID: <20041122001051.GA3007@stusta.de>
References: <20041121153614.GR2829@stusta.de> <20041121204752.A23300@flint.arm.linux.org.uk> <20041121205613.GA12634@infradead.org> <20041122000413.A27572@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261868AbUKVALD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041122000413.A27572@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, Nov 22, 2004 at 12:04:13AM +0000, Russell King wrote:
> On Sun, Nov 21, 2004 at 08:56:13PM +0000, Christoph Hellwig wrote:
> > On Sun, Nov 21, 2004 at 08:47:52PM +0000, Russell King wrote:
> > > On Sun, Nov 21, 2004 at 04:36:14PM +0100, Adrian Bunk wrote:
> > > > The patch below ncludes the following cleanups for 
> > > > drivers/video/cyber2000fb.c:
> > > > - remove five EXPORT_SYMBOL'ed but completely unused functions
> > > > - make some needlessly global code static
> > > 
> > > These are used by the video capture code which isn't merged, but is
> > > used by people.  Rejected.
> > 
> > If people use the code it should get merged or Adrian has all reasons to
> > remove or #if 0 the code.
> 
> Sigh, if that's what you want to do and place extra burden on me,
> that's fine.  Don't expect me to co-operate with you next time you
> want me to do something though, no matter how important you feel it
> is.  Works both ways.

Where is this video capture code, and why can't it be included in the 
kernel?

cu
Adrian

BTW: It's not my intention to piss off maintainers.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
