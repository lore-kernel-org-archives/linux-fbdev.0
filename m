From: Johannes Stezenbach <js@convergence.de>
Subject: Re: fbdv/fbcon pending problems
Date: Mon, 23 Feb 2004 16:52:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040223155209.GB302@convergence.de>
References: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1077497593.5960.28.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

Benjamin Herrenschmidt wrote:
> 
> Here's a list of pending issues with fbdev (either upstream or in the
> fbdev bk treee), I figured posting it here may help getting more people
> on those issues as my time is sparse and I suppose James too.
...
> Ok, that's all that comes to my mind right now, help is welcome :)

IMHO it is rather discouraging that:

FRAMEBUFFER LAYER
P:      James Simmons, Geert Uytterhoeven       
M:      jsimmons@infradead.org, geert@linux-m68k.org    
L:      linux-fbdev-devel@lists.sourceforge.net 
W:      http://www.linux-fbdev.org

$ host www.linux-fbdev.org
Nameserver not responding
www.linux-fbdev.org A record not found, try again


http://linux-fbdev.sourceforge.net/ has no halfway up-to-date information about
the state of 2.6 fbdev devlopment. Sure, one can dig through the mailing list
archives, but if a project is looking for developers I would at least expect a
link to
- the current fbdev source tree
- a TODO that lets me see what work is currently been done by others,
  and what work could be contributed by me

(This is just a suggestion, I don't have time to work on fbdev myself.)

Johannes
