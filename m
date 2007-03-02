From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [Linux-fbdev-devel] 2.6.21-rc2 radeon backlight
Date: Fri, 02 Mar 2007 23:40:12 +0000
Message-ID: <1172878812.11149.207.camel@localhost.localdomain>
References: <20070301184531.b3aeafe3.akpm@linux-foundation.org>
	 <87tzx35zkc.fsf@sycorax.lbl.gov>
	 <20070302122920.a2967ebf.akpm@linux-foundation.org>
	 <20070302.123514.35465791.davem@davemloft.net>
	 <Pine.LNX.4.64.0703022131310.6960@pentafluge.infradead.org>
	 <20070302135841.fbfc1e32.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992760AbXCBXlO@vger.kernel.org>
In-Reply-To: <20070302135841.fbfc1e32.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, romosan@sycorax.lbl.gov, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Fri, 2007-03-02 at 13:58 -0800, Andrew Morton wrote:
> > @@ -1106,7 +1105,8 @@ config FB_ATY_GX
> >  
> >  config FB_ATY_BACKLIGHT
> >  	bool "Support for backlight control"
> > -	depends on FB_ATY
> > +	depends on FB_ATY && EXPERIMENTAL
> > +	select FB_BACKLIGHT	
> >  	default y
> >  	help
> >  	  Say Y here if you want to control the backlight of your display.
> 
> Sorry, but my confidence level on this one is very low.  We've had heaps
> and heaps of Kconfig-related build errors in exactly this area.  I'd prefer
> that a patch like this one have a lot of testing and review (and a
> changelog?) before we let it near a tree.

Agreed, I can tell from what I've seen so far this will at least break
the PMAC users...

See my proposed patch, if that doesn't work, we should revert the
problematic change.

Richard
