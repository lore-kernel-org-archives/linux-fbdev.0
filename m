From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Sat, 6 Nov 2004 10:02:38 +0800
Message-ID: <200411061002.38017.adaplas@hotpop.com>
References: <1099448020.900.25.camel@gaston> <200411052055.17316.adaplas@hotpop.com> <1099701519.3884.32.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQFva-0000o0-QC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 18:03:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQFvZ-0002Aa-3Q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 18:03:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D0503709F9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  6 Nov 2004 02:03:22 +0000 (UTC)
In-Reply-To: <1099701519.3884.32.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Saturday 06 November 2004 08:38, Benjamin Herrenschmidt wrote:
> On Fri, 2004-11-05 at 20:55 +0800, Antonino A. Daplas wrote:
> > And make it black is usually done in software (by memsetting the screen
> > with the black color).
> >
> > So why not this:  In fbcon_blank(), if the blank parameter is:
> >
> > 0 - unblank the screen, and call info->fbops->fb_blank(VESA_NO_BLANKING),
> >      then return a nonzero value to force a redraw.
> > 1,2,3,4 - clear the screen with all black
> > 2,3,4 - call info->fbops->fb_blank(blank - 1);
> >
> > Similarly, we can do the same thing in fbmem.c:fb_blank(), but without
> > the software blanking.
> >
> > Drivers will just need to follow the VESA_* defines in fb.h (which
> > happens to be also defined in console.h)
>
> Ah... so radeonfb is correct then, and fb_blank() is not ? X is
> definitely passing +1 values it seems.
>

Well, depends on what approach is adopted:

Most drivers do this:
if (blank)
	switch(blank-1) {
	...
	}

Which means fb_blank() and fbcon_blank() should pass the 
blank parameter to info->fbops->fb_blank() unchanged.

If we adopt the approach of passing (blank -1) to 
info->fbops->fb_blank(), then drivers simply do a:

switch(blank) {
...
}

Currently, fbcon_blank() does the first method (pass blank unchanged),
which means radeonfb is wrong. Adopting the second method will make
radeonfb do the right thing, but will require changes to a lot of drivers.

So, what will it be then?

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
