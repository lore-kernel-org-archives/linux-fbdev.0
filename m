From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 2/3][FBCON]: New Scrolling Mode: YPAN + REDRAW
Date: Tue, 6 Jul 2004 18:30:41 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407061830.41760.adaplas@hotpop.com>
References: <200407060634.37125.adaplas@hotpop.com> <Pine.GSO.4.58.0407060933200.3788@waterleaf.sonytel.be>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhnDO-00089n-Tr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 03:30:18 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BhnDO-0000xw-5l
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jul 2004 03:30:18 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id A86F6697B3F
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  6 Jul 2004 09:46:34 +0000 (UTC)
In-Reply-To: <Pine.GSO.4.58.0407060933200.3788@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>
Cc: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tuesday 06 July 2004 15:38, Geert Uytterhoeven wrote:
> On Tue, 6 Jul 2004, Antonino A. Daplas wrote:
> > Added a new scrolling mode (SCROLL_PAN_REDRAW) to fbcon that should
> > greatly benefit unaccelerated drivers such as VESA fbdev.  An increase of
> > 3-10 times in scrolling speed can be expected.
>
> Nice!

Thanks.  Adding it was actually easy, all I have to do was reuse code already
present in fbcon.c.

>
> > Using an accelerated driver, we see almost the same effect but
> > not as dramatically:
> >
> > 1. SCROLL_MOVE - accel
> > real    0m3.112s
> > user    0m0.000s
> > sys     0m3.112s
> >
> > 2. SCROLL_REDRAW - accel
> > real    0m2.604s
> > user    0m0.000s
> > sys     0m2.603s
> >
> > Redraw is still faster than move, but not much.
>
> That probably depends on the card (imageblit vs copyarea)?
>

True.  I really don't want to speculate on this, it varies from 
hardware to hardware, driver to driver. The only thing I can
definitely say is that pan/wrap is the most effective means
to facilitate scrolling.  Whether it be combined with imageblit
or copyarea, I'll leave that up to the driver maintainers.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
