From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [ PATCH-LINK ] fb accel capabilities - take 2
Date: Mon, 31 May 2004 09:08:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405310908.45350.adaplas@hotpop.com>
References: <40B7296B.4030804@winischhofer.net> <1085819816.40b84ba84f22d@mail.theboonies.us> <40B9C932.8010805@winischhofer.net>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUbJ5-0001rk-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 May 2004 18:09:39 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BUbJ5-0003ig-8r
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 May 2004 18:09:39 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id ABE9B5542FE
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 May 2004 00:35:39 +0000 (UTC)
In-Reply-To: <40B9C932.8010805@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>, David Eger <eger@theboonies.us>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sunday 30 May 2004 19:44, Thomas Winischhofer wrote:
> David Eger wrote:
> > I'll add some comments to the patch :)
> >
> > The intent for the FBINFO_HWACCEL_fnName flags is to say that the
> > hardware will be smart about it (i.e., it ought to be fast).  New fb
> > drivers have been filling in copyarea() with cfb_copyarea() (that is, the
> > software version) or more opaquely filling in copyarea() with their own
> > mydriver_copyarea(), and then conditionally calling cfb_copyarea()
> > depending on the noaccel flag.
>
> Evidently.
>
> > With the patch, there are a bunch of these "is X really hardware
> > accelerated?" flags in fbinfo->flags, as well as FBINFO_HWACCEL_DISABLED
> > which should tell the driver to not use its acceleration engine --- and
> > use unaccelerated versions of copyarea(), fillrect(), imageblit(); and
> > FBINFO_MODULE (is the driver loaded as a module?)
>
> So far so good. Can't see a reason for partly disabling acceleration,
> but ok.
>
> >>Erm, I wasn't aware of this. Interesting... Personally, since sisfb does
> >>y-panning I didn't see any speed regressions compared with 2.4 yet.
> >
> > So with my patch, you'd see a regression in speed until you flag that
> > your driver can do hardware panning.  I thought it would be good for our
> > small brains to put all the flags for this in one place instead of
> > testing the (x/y)panstep variables for zero...
>
> There is another issue with panning. How does the new fbcon code decide
> how big the virtual screen shall be (if it cares at all)? Will there be
> a change in behavior?

There shouldn't be a change in behavior.  The console virtual screen 
(display->vrows) is still based on var->yres_virtual, which the driver should 
set.  fbcon also checks if var->ypanstep != 0 if the driver can do panning or 
not.  The main intent of the capability flags is choosing the best scrolling 
mode.  So in pseudo_code:

if (cannot_pan && fb_read_is_very_slow)
	no_pan + redraw;
else if (cannot_pan && fb_read_is_fast)
	no_pan + move;
else if (can_pan && fb_read_is_very_slow)
	pan + redraw;
else /* pan + fb_read_is_fast */
	pan + move;

/* an accelerated copyarea == fb_read is fast */
/* With PCI cards, fb_read is magnitudes slower than fb_write */

Of course, pan+redraw is still not supported by fbcon, so this resolves to 
no_pan + redraw.

>
> Right now, this is more or less a hack: sisfb, unless explicitly told
> not to do so (nomax or noypan), will maximize the virtual y resolution
> on all var's it receives. DirectFB disables this "auto-maximizing"
> feature with a respective ioctl before changing the mode etc. Works
> fine. Dunno if other drivers do the same. Advantage is that users get

I think other drivers do the same.  But syntax might be different, ie (if 
var->yres_virtual == 0, then maximize var->yres_virtual, or something like 
that).

> the fastest possible console by default (without using fbset or the like
> to set the virtual screen size.)
>
> Do I have to expect this mechanism to fail? IOW: (No, not io-write, in
> other words ;)) Will the panning stuff change in the fbcon layer
> breaking this?
>
> >>Are these to set/cleared exclusively by the driver or must the driver
> >>expect them to change? (I mean for example that fbset in 2.4 could be
> >>used to disable acceleration, which is important to DirectFB)
> >

The accel capability bits should be set/cleared exclusively by the driver 
depending on it's capability (duh) or if var->accel_flags is set or not.  
 
> > *really*?  I was wondering about that.  I'll have to go see how that
> > works...
>
> Assumingly simple. Set/clears FB_ACCELF_TEXT. DirectFB uses the same
> technique. Your new flags will break both.
>

The new flags should not break DirectFB if the driver correspondingly sets/
clears the capability bits depending on the setting of var->accel_flags.

> >>Is there any driver already finished so that I can look it up somewhere?
> >
> > There's a patch for radeonfb (my video card ;-) )
>
> I already saw that. Will take a closer look.
>
> >>Will an old driver (status as of now) work at all with the new flags not
> >>being touched? Will it compile? (That *should* work IMHO)
> >
> > /me nods.  It should. I tried compiling all of the drivers, and most of
> > them compiled.  The few drivers that didn't seemed to be pure 2.4 API
> > code that no one has loved for a long time :-/  Ah well..
>
> (Assume you mean 2.5 API...?)
>
> If they should compile you will need the mentioned compat-#define's in
> the long run...
>
> Thomas




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
