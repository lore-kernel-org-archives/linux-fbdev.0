From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] atyfb: vblank irq support
Date: Mon, 26 Jul 2004 06:47:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407260647.03489.adaplas@hotpop.com>
References: <20040722184937.GA11361@sci.fi> <200407250803.14308.adaplas@hotpop.com> <200407252036.52194.alex.kern@gmx.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BormA-0004tp-PT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 15:47:26 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BormA-000639-DF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 15:47:26 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 7FD35101FB3A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 25 Jul 2004 22:26:06 +0000 (UTC)
In-Reply-To: <200407252036.52194.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-15?q?Syrj=E4l=E4?= <syrjala@sci.fi>

On Monday 26 July 2004 02:36, Alexander Kern wrote:
> Am Sonntag, 25. Juli 2004 02:03 schrieb Antonino A. Daplas:
> > On Sunday 25 July 2004 07:12, Alexander Kern wrote:
> > > P.S. Now the last consumer from fb_load_cursor_image is neo driver.
> > > Should we drop this function, it's buggy!
> >
> > We should.  fb_load_cursor_image() cannot be generic.
>
> fine, do you make it for neo driver?

I think James did it for neofb. 

We can just move it to one of neofb's file and rename it 
neofb_load_cursor_image().

>
> > > Steel on my TODO list:
> > >
> > > Issue with 16bpp mode, brocken boot logo, fbi has problems too.
> >
> > 1. aty128fb_setcolreg has this lines:
> >
> > 		case 16:
> > 			pal[regno] = (regno << 11) | (regno << 6) | regno;
> > 			break;
> >
> > Shouldn't it be?
> >
> > 		pal[regno] = (regno << 11) | (regno << 5) | regno;
>
> Maybe, but I work on mach64 driver. In atyfb_base.c#2671 it is really
> pal[regno] = (regno << 11) | (regno << 5) | regno;

Ok, I got confused since I was looking at a different patchset. 

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
