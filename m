From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: [ PATCH-LINK ] fb accel capabilities - take 2
Date: Sat, 29 May 2004 03:36:56 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085819816.40b84ba84f22d@mail.theboonies.us>
References: <40B7296B.4030804@winischhofer.net>
Reply-To: David Eger <eger-dated-1086424634.e75998@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTzLG-0002cR-28
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 May 2004 01:37:22 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BTzLC-0006uV-Id
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 May 2004 01:37:18 -0700
In-Reply-To: <40B7296B.4030804@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Quoting Thomas Winischhofer <thomas@winischhofer.net>:

> David Eger wrote:
> > Thomas Winischhofer eloquently put:
> >>How about properly documenting what you actually do and let the driver
> >>maintainer handle the implementation?
> >
> > see the update to skeletonfb.c
>
> I saw that but no explanation on eg. the new PAN flags; what has hw
> accel with panning to do? Or do these just mean that the driver CAN pan?

I'll add some comments to the patch :)

The intent for the FBINFO_HWACCEL_fnName flags is to say that the hardware will
be smart about it (i.e., it ought to be fast).  New fb drivers have been
filling in copyarea() with cfb_copyarea() (that is, the software version) or
more opaquely filling in copyarea() with their own mydriver_copyarea(), and
then conditionally calling cfb_copyarea() depending on the noaccel flag.

With the patch, there are a bunch of these "is X really hardware accelerated?"
flags in fbinfo->flags, as well as FBINFO_HWACCEL_DISABLED which should tell
the driver to not use its acceleration engine --- and use unaccelerated
versions of copyarea(), fillrect(), imageblit(); and FBINFO_MODULE (is the
driver loaded as a module?)

> > If you want to handle the fix for sisfb, please do, I'll skip over that one
> ;-)
>
> Yes please. However, you may very well do the changes yourself, but
> please mail them to me as the maintainer and not directly to the kernel
> maintainer.

Can do.  The one patch that touched everyone's driver just kept the new
flags from breaking things, as I changed FBINFO_FLAG_MODULE to FBINFO_MODULE.
I can leave a backwards-compatibility macro in fb.h, but it's sort of ugly, and
I'd just as soon touch all the drivers and get rid of the old #define 
completely :-/

> > SiS310SubsequentScreenToScreenCopy() and friends
> > would probably work great if they were ever called.  Currently, they're
> > not :-P
>
> Erm, I wasn't aware of this. Interesting... Personally, since sisfb does
> y-panning I didn't see any speed regressions compared with 2.4 yet.

So with my patch, you'd see a regression in speed until you flag that your
driver can do hardware panning.  I thought it would be good for our small
brains to put all the flags for this in one place instead of testing the
(x/y)panstep variables for zero...

> Allright, keep on doing what you do. But please be more verbose in the
> include files as to what the flags actually mean.
Will do in the next version of the patch (no one seems to have merged it yet, so
that's OK).  It seems to be getting good discussion, anyways ;-)

> Are these to set/cleared exclusively by the driver or must the driver
> expect them to change? (I mean for example that fbset in 2.4 could be
> used to disable acceleration, which is important to DirectFB)
*really*?  I was wondering about that.  I'll have to go see how that works...

> Is there any driver already finished so that I can look it up somewhere?
There's a patch for radeonfb (my video card ;-) )

> Will an old driver (status as of now) work at all with the new flags not
> being touched? Will it compile? (That *should* work IMHO)

/me nods.  It should. I tried compiling all of the drivers, and most of them
compiled.  The few drivers that didn't seemed to be pure 2.4 API code that no
one has loved for a long time :-/  Ah well..

-dte



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
