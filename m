From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 10/15] sunxvr500: fix cmap memory leaks
Date: Sun, 08 Feb 2009 17:51:37 -0800 (PST)
Message-ID: <20090208.175137.89667094.davem@davemloft.net>
References: <20090207121540.0e618d0f@ephemeral>
	<20090208.165925.240846008.davem@davemloft.net>
	<20090208175024.6e58671f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754780AbZBIBv5@vger.kernel.org>
In-Reply-To: <20090208175024.6e58671f.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: Text/Plain; charset="us-ascii"
To: akpm@linux-foundation.org
Cc: dilinger@queued.net, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 8 Feb 2009 17:50:24 -0800

> On Sun, 08 Feb 2009 16:59:25 -0800 (PST) David Miller <davem@davemloft.net> wrote:
> 
> > From: Andres Salomon <dilinger@queued.net>
> > Date: Sat, 7 Feb 2009 12:15:40 -0500
> > 
> > [ Fixed typo in adaplas's email address ]
> > 
> > >  - fix cmap leak in removal path
> > >  - fix cmap leak when register_framebuffer fails
> > > 
> > > Signed-off-by: Andres Salomon <dilinger@debian.org>
> > 
> > I assume the fbdev folks will pick this up or should I take
> > it in my sparc tree?
> 
> (fbdev folks == me) at present.  I'll crunch on these 15 patches
> tomorrow.  If you want to queue it in in a sparc tree so that it gets
> more-than-zero runtine testing then go for it.

Nah, you can take it, thanks Andrew :-)
