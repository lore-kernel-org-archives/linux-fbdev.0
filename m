From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 15:59:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408091559.45202.adaplas@hotpop.com>
References: <200408090944.01414.adaplas@hotpop.com> <20040808230412.6dc16bf4.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu55H-0008Dr-0g
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:00:43 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu55G-0004Lr-Hw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:00:42 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9280775A28
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 06:43:51 +0000 (UTC)
In-Reply-To: <20040808230412.6dc16bf4.akpm@osdl.org>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Monday 09 August 2004 14:04, Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> > Most fbdev developers are proposing to bring back the per-display var
> >  structures to ease the difficulty of video mode handling.  This proposal
> >  is countered by a few (notably James) in that it severely increases the
> >  memory footprint of the kernel.
>
> Surprised.
>
> By how much does this increase the kernel's memory footprint?

Each var is approx 140 bytes multiplied by the number of consoles, which
is 64. James is in the embedded systems market, so I can see his point.

>
> And how much simpler would the code be if we were to bring back the
> per-display var structures?

The switching code will be much simpler.  All that needs to be done is
grab display->var and pass it to fbdev.  However, the stty/resize route still needs
to be addressed. 

>
> IOW: what's the tradeoff here?

Absence of a per-display var or similar mechanism is simply unacceptable.
Without it, mode setting is basically a mess.  It's possible that by simply
switching consoles you can be left with a corrupt display.

With  the per-display var, console switching is a breeze.  No need for mode
verification or creation.  The downside is the increased memory footprint.

The stty/fbcon_resize path is the other problem.  This is a request coming
from the upper layer (which has no knowledge whatsoever about graphics/
video) asking fbdev to change the video mode of the hardware.  Drivers can
'guess', but not all drivers are good at that, or get the mode from a known,
working modelist (which the 1st and 2nd patch addresses).  A simple solution
is to just remove stty/fbcon_resize support. But James might disagree.

BTW:  The series of patches addresses all of the above.  It can save the
settings per display, but with only half the memory requirement of a per-display
var, and makes the stty/fbcon_resize path work correctly.  It also eliminates 
the need for a static mode database as well.  The downside is increased code
complexity.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
