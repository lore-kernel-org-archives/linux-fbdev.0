From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] fb: convert lock/unlock_kernel()
	into local fb mutex
Date: 05 Aug 2008 12:07:30 +0200
Message-ID: <20080805100731.AC1E297A81B@f43.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQJS8-0003KZ-Ko for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 03:07:40 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQJS7-0004Yn-2P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 03:07:40 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

> On Tue, 5 Aug 2008 07:37:55 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm>
> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Change lock_kernel()/unlock_kernel() to local fb mutex.
> > Each frame buffer instance has its own mutex.
> > 
> > The one line try_to_load() function is unrolled to
> > request_module() in two places for readability.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > 
> > The only caveat is that I had to put request_module()
> > call outside this new mutex while it was inside the 
> > lock_kernel() (inside fb_open()). 
> 
> Why did you have to do that?
> 

This has to be done if the per fb mutex (fb_info->lock) is used as the request_module is called before fb_info pointer exists. 

I tried to avoid one big mutex for the fb layer (which would not be worse than lock_kernel now).

Alternative solution is to provide one global mutex inside the fb layer to mutex fb_open and fb_close functions and another mutex per each fb (fb_info->lock) for all other locking (so ioctls on different fb instances/cards can be concurrent).

> The request_module() in fb_ioctl() is inside the lock...
> 

Yes. This is some mistake I suppose as the fb_info pointer is used before the switch
then it is checked against null inside the switch. Either the request_module is never called there (dead code) or a core dump happens sometimes.

As I see it now, the whole fbmem locking is somehow not right as IMO the registered_fb[idx] access should be locked to avoid situation that someone is adding/removing the fb and another function grabs fb_info pointer from the registered_fb[].

> > If the request_module() should be called only inside this mutex
> > please drop the patch.
> 
> No, request_module() doesn't need lock_kernel().
> 
> The only possible problem I can see is the sole remaining lock_kernel()
> in drivers/video/console/vgacon.c.  The fbcon.c code used to be
> serialised against vgacon_do_font_op() via lock_kernel, but with this
> change vgacon_do_font_op() can now run concurrently with all the code
> which you've put inside fb_info.mutex_lock.  Probably not a problem, but
> please check that sometime.
> 
> 

I will look into it and either resend this patch or another one.

Should I cc some other list or person next time?

Kind regards,
Krzysztof

----------------------------------------------------------------------
Wymien zeszyty na notebooka!
Sprawdz >>> http://link.interia.pl/f1eab 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
