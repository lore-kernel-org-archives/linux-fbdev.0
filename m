From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: Fix crash if fb_set_var() called before register_framebuffer()
Date: Sat, 27 Nov 2004 10:56:52 +0800
Message-ID: <200411271056.53598.adaplas@hotpop.com>
References: <200411250115.50895.adaplas@hotpop.com> <1101508723.28047.43.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXslv-0007wL-G9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 18:57:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXslp-0002P8-OS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 18:57:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DCCAFA57A3C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Nov 2004 02:56:58 +0000 (UTC)
In-Reply-To: <1101508723.28047.43.camel@gaston>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Saturday 27 November 2004 06:38, Benjamin Herrenschmidt wrote:
> On Thu, 2004-11-25 at 01:15 +0800, Antonino A. Daplas wrote:
> > The field info->modelist is initialized during register_framebuffer. 
> > This field is also referred to in fb_set_var().  Thus a call to
> > fb_set_var() before register_framebuffer() will cause a crash.  A few
> > drivers do this, notably controlfb.  (This might fix reports of controlfb
> > crashing in powermacs).
> >
> > .../...
>
> Hi Antonio, I "missed" this modelist thingy. Can you explain what is the
> logic ? There is now a modelist attached to fb_info used for mode
> matching ? In this case, it makes sense to be able to add things to it
> before register_framebuffer(). I mean, I would expect drivers to probe
> at least their default head modes before registering the fb, since the
> later will cause fbcon to try to setup a mode ...

Yep, this came about because there were two problems in terms of mode
setting before I added the modelist:

1. Lack of per-display var which prevents full restore of the console on 
mode switch
2. the stty utility does not work correctly for drivers that do not have
mode validation

The modelist functions as a private mode database, meaning the entries are
always correct for the driver/graphics/display combination in question.

The modelist can be filled up in a number of ways:

1.  By default, upon register_framebuffer(), if info->modelist is empty or
not initialized, it will be filled up with mode timings derived from
info->var.  In effect, most drivers will have at least one correct entry in
info->modelist.

2. Drivers can choose to fill up info->modelist, perhaps from timings
derived from EDID.  There is one function in fbmem.c,
fb_videomode_to_modelist() which converts a modedb array to a 
modelist.

3.  For each correct fbset, (accepted by both driver and user), if
the timings are unique, this will be also be added to the modelist. Also,
in the unfortunate case that an illegal mode timing is accidentally entered
into the modelist, there is a mechanism to remove that entry.

Therefore, when doing an stty, fbcon will only look at info->modelist,
finds the best matching mode, builds a var from that particular entry
and passes the var to the driver.  There is no guesswork involved, and
drivers will always operate on known working mode timings.

Also, the graphics states per console are also preserved.  However, instead
of saving a var per console, we only save a part of the var, the graphics
state. The mode timings are saved as pointers to entries in info->modelist.
In effect, we have the full functionality of a per-display var, but we save
half the memory, that's around 5K.

You'll probably notice that with recent kernels, if you switch consoles,
your previous console settings are restored.  Also, doing an stty should, in
theory, never produce a corrupt console, even if you enter insane numbers.
Of course, the effectivity of stty depends on the number of entries in
info->modelist.

Anyway, the goal here is to fix as many regressions as possible.  And I
think the 2.6 framebuffer is now behaving in almost the same manner as 2.4,
with a few minor exceptions. 

BTW, a few drivers do fill up info->modelist before register_framebuffer(),
rivafb and savagefb.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
