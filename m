From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: latest patch for atyfb, even more patches
Date: Sun, 17 Oct 2004 06:20:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410170620.58883.adaplas@hotpop.com>
References: <200410120024.50968.alex.kern@gmx.de> <200410152125.55255.alex.kern@gmx.de> <200410162347.59630.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIwpF-0007a1-Se
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 15:14:57 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CIwpE-0000sx-Qw
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 15:14:57 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5817D902474
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Oct 2004 22:14:43 +0000 (UTC)
In-Reply-To: <200410162347.59630.alex.kern@gmx.de>
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
To: linux-fbdev-devel@lists.sourceforge.net, Alexander Kern <alex.kern@gmx.de>
Cc: adaplas@pol.net, Arnaud FONTAINE <arnaud.fontaine@free.fr>, =?iso-8859-1?q?Dani=EBl=20Mantione?= <daniel@deadlock.et.tudelft.nl>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Sunday 17 October 2004 05:47, Alexander Kern wrote:
> Am Freitag, 15. Oktober 2004 21:25 schrieb Alexander Kern:
> > Am Dienstag, 12. Oktober 2004 14:42 schrieb Antonino A. Daplas:
>
> Hi,  here is more patches to go
>
> Our cursor API is a bit understandable, 80 % of drivers given up, and using
> soft_cursor (see a comment in ffb.c#61).
>
> Three drivers made an error and use cursor->enable insted of
> info->cursor.enable.
>
> [PATCH atyfb] fix hw cursor breakage
>
> [PATCH g364fb] fix hw cursor breakage
>
> [PATCH imsttfb] fix hw cursor breakage
>
> And tdfxfb is in my mind, broken as a hell.
> cut from tdfxfb_cursor function
>
> #ifdef TDFX_HARDWARE_CURSOR <-- not defined at all

Yep, tdfxfb_cursor() doesn't get compiled as it's seriously broken.

> static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
> {
> ......
> 	if (info->cursor.enable) {    < Hey it's right
> ......
> 	/* Turn the cursor on */
> 	cursor->enable = 1;
> 	info->cursor = *cursor;    < Outch!
> }
> #endif
>

Yep, the cursor API, IMHO is very confusing, some fields are taken from
info->cursor (ie, mask, enable, rop), the rest from the passed fb_cursor
structure. There are also a lot of short-circuits in the cursor code path.

I've cleaned all this up in my tree so all drivers will use fields in the
passed fb_cursor structure _only_. Also, drivers need not store the changed
fields in info->cursor, fbcon will do that for you.  The end result is that
drivers don't have to look at info->cursor at all.  

Driver changes should be minimal, all references to info->cursor will just
be changed to cursor.  And things like this can be removed:

if (cursor->set & FB_CUR_BLAH)
	info->cursor.blah = cursor->blah; <-- this line can be removed

I'll document all of this in skeletenfb.c.

Other changes: cleaned up the cursor code path.

I'll submit the cursor API patches (including my attempt to modify
drivers) when 2.6.9 comes out.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
