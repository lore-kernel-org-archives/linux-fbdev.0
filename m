From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fbdev: Fix crash if fb_set_var()
	called before register_framebuffer()
Date: Sat, 27 Nov 2004 15:15:52 +1100
Message-ID: <1101528953.4668.7.camel@gaston>
References: <200411250115.50895.adaplas@hotpop.com>
	 <1101508723.28047.43.camel@gaston>  <200411271056.53598.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXu0C-0005e6-1N
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 20:16:04 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CXu0A-0000fj-96
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 20:16:03 -0800
In-Reply-To: <200411271056.53598.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2004-11-27 at 10:56 +0800, Antonino A. Daplas wrote:

> 1. Lack of per-display var which prevents full restore of the console on 
> mode switch
> 2. the stty utility does not work correctly for drivers that do not have
> mode validation

Ok, good.

 .../...

> 3.  For each correct fbset, (accepted by both driver and user), if
> the timings are unique, this will be also be added to the modelist. Also,
> in the unfortunate case that an illegal mode timing is accidentally entered
> into the modelist, there is a mechanism to remove that entry.

Ok, though I'm not too fan of this one, I'd rather have an explicit flag
in the var passed by fbset trigger the "remember" thing... oh well,
we'll see how things goes.

> Therefore, when doing an stty, fbcon will only look at info->modelist,
> finds the best matching mode, builds a var from that particular entry
> and passes the var to the driver.  There is no guesswork involved, and
> drivers will always operate on known working mode timings.

Yah, I know that problem, this looks like a good solution.

> Also, the graphics states per console are also preserved.  However, instead
> of saving a var per console, we only save a part of the var, the graphics
> state. The mode timings are saved as pointers to entries in info->modelist.
> In effect, we have the full functionality of a per-display var, but we save
> half the memory, that's around 5K.

I dislike the pointers tho. Remember that one day, we'll do monitor
hotswap, which means that at one point, the driver will
remove/add/rebuild modelist... 

> You'll probably notice that with recent kernels, if you switch consoles,
> your previous console settings are restored.  Also, doing an stty should, in
> theory, never produce a corrupt console, even if you enter insane numbers.
> Of course, the effectivity of stty depends on the number of entries in
> info->modelist.

Yah, sounds good.

> Anyway, the goal here is to fix as many regressions as possible.  And I
> think the 2.6 framebuffer is now behaving in almost the same manner as 2.4,
> with a few minor exceptions. 
> 
> BTW, a few drivers do fill up info->modelist before register_framebuffer(),
> rivafb and savagefb.

I'll add that to radeonfb too, I'm working on a big update of this
driver adding power management support for newer apple laptops plus a
few other things, I'll include that as well.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
