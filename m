From: Ben Collins <bcollins@debian.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Thu, 23 Oct 2003 19:45:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031023234552.GB554@phunnypharm.org>
References: <20031023144315.GA667@phunnypharm.org> <Pine.LNX.4.44.0310232343410.21561-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310232343410.21561-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Oct 23, 2003 at 11:50:48PM +0100, James Simmons wrote:
> 
> > The cursor has changed from a nice underline to a solid white block. 
> 
> I seen the problem. Its the wrong color for the background color for the 
> cursor. I haven't been able to figure out why it went wrong. The specs are 
> not to clear on this.
> 
> > Not only that,
> > but the block is bigger than the font it is over (if I am on top of
> > adjacent letters, it covers the entire letter I am on, plus a couple of
> > pixels of the letter to the right).
> 
> Ug. That code is straight from the old driver. Will fix.
> 
> > In additition, the cursor now disappears while typing, and navigating
> > around (on the command line left and right, or even in an editor when
> > moving the cursor up and down). This disappearing while typing or
> > navigating is _really_ annoying. If I go left or right a lot, I have to
> > keep stopping to see where the cursor actually is.
> 
> I seen this problem last night with the NVIDIA fbdev driver. I think I 
> know what the problem is. I will try a fix tonight. 

I noticed one thing, and that is that the mach64 used to use software
cursor it seems (I remember wondering why atyfb_cursor was never used
anywhere). It's now using the hw cursor.

Also, I notice with this new code that the random vertical shifting of
the console doesn't occur anymore like it does with current 2.6.0-test8
code. For as long as I can remember 2.6.0-test, and way back into
2.5.5x, this has been a problem with highly active console programs
(mutt, vim, etc...). Good to see it's going away :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
