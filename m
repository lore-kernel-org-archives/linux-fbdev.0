From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] fbdev: workaround for broken X servers
Date: Sat, 6 Nov 2004 10:07:01 +0800
Message-ID: <200411061007.01203.adaplas@hotpop.com>
References: <1099448020.900.25.camel@gaston> <Pine.GSO.4.61.0411051313130.15464@waterleaf.sonytel.be> <1099701452.3884.30.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQFz8-0001mE-QU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 18:07:22 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQFz1-0002vN-5v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 18:07:22 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DD5EA9B807C
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  6 Nov 2004 02:07:06 +0000 (UTC)
In-Reply-To: <1099701452.3884.30.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Saturday 06 November 2004 08:37, Benjamin Herrenschmidt wrote:
> On Fri, 2004-11-05 at 13:15 +0100, Geert Uytterhoeven wrote:
> > On Fri, 5 Nov 2004, Benjamin Herrenschmidt wrote:
> > > > But every existing application that uses (shiver) the kernel headers
> > > > will break after this change...
> > >
> > > Geert, can you explain the whole story please ?
> >
> > The story about the +1 or the story about the breakage?
> >
> > The Story About The +1
> > ----------------------
> > Since the VESA levels do not provide a way to blank (`make it black') the
> > screen, the +1 is introduced. Hence 0 means unblank, 1 means black
> > screen, 2 means lowest power save level, and so on...
>
> So why don't we have a nice set of #define's or an enum at least
> describing those ? :)
>
> > The Story About The Breakage
> > ----------------------------
> > Every application that passes VESA_*+1 will break when recompiled, since
> > (most of) the VESA_* values are incremented by 1 by the patch.
>
> What patch ? Mine ? It doesn't increment the VESA values, it just clamps
> the max. But then, everything seem to be totally inconsistent. So can we
> instead define a  set of FB_BLANK_**** values to use and have fbcon
> convert VESA->FB_BLANK and FBIOBLANK pass FB_BLANK_* as-is, thus the
> drivers would switch/case on those and no more +1 games ?
>

Currently, yes, the patch will break many drivers:

VESA_POWERDOWN + 1 is interpreted by most drivers as
VESA_POWERDOWN. If clamped, it will be misinterpreted as
VESA_HSYNC_SUSPEND.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
