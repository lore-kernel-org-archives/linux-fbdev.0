From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: Fix crash if fb_set_var() called before register_framebuffer()
Date: Sat, 27 Nov 2004 12:43:38 +0800
Message-ID: <200411271243.40230.adaplas@hotpop.com>
References: <200411250115.50895.adaplas@hotpop.com> <200411271056.53598.adaplas@hotpop.com> <1101528953.4668.7.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXuR9-0001t9-Do
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 20:43:55 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXuR6-0005dx-5b
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 20:43:55 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 65F17123F960
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Nov 2004 04:43:42 +0000 (UTC)
In-Reply-To: <1101528953.4668.7.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 27 November 2004 12:15, Benjamin Herrenschmidt wrote:
> On Sat, 2004-11-27 at 10:56 +0800, Antonino A. Daplas wrote:
> > 1. Lack of per-display var which prevents full restore of the console on
> > mode switch
> > 2. the stty utility does not work correctly for drivers that do not have
> > mode validation
>
> Ok, good.
>
>  .../...
>
> > 3.  For each correct fbset, (accepted by both driver and user), if
> > the timings are unique, this will be also be added to the modelist. Also,
> > in the unfortunate case that an illegal mode timing is accidentally
> > entered into the modelist, there is a mechanism to remove that entry.
>
> Ok, though I'm not too fan of this one, I'd rather have an explicit flag
> in the var passed by fbset trigger the "remember" thing... oh well,
> we'll see how things goes.

You mean the mode entry deletion? That's okay, the code is minor, still
unused, and was submitted as optional, but still got merged.  It can be
easily removed.

>
> > Therefore, when doing an stty, fbcon will only look at info->modelist,
> > finds the best matching mode, builds a var from that particular entry
> > and passes the var to the driver.  There is no guesswork involved, and
> > drivers will always operate on known working mode timings.
>
> Yah, I know that problem, this looks like a good solution.
>
> > Also, the graphics states per console are also preserved.  However,
> > instead of saving a var per console, we only save a part of the var, the
> > graphics state. The mode timings are saved as pointers to entries in
> > info->modelist. In effect, we have the full functionality of a
> > per-display var, but we save half the memory, that's around 5K.
>
> I dislike the pointers tho. Remember that one day, we'll do monitor
> hotswap, which means that at one point, the driver will
> remove/add/rebuild modelist...

Removing/adding/rebuilding the modelist should be doable with pointers. But
in the case people don't want pointers, this can be easily changed.  The
conversion code is entirely in display_to_var() and var_to_display() helpers.
  
Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
