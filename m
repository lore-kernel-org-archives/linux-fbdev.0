From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH] atyfb: vblank irq support
Date: Sun, 25 Jul 2004 20:36:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407252036.52194.alex.kern@gmx.de>
References: <20040722184937.GA11361@sci.fi> <200407250112.18689.alex.kern@gmx.de> <200407250803.14308.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bonrl-0001Pc-K6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 11:36:57 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bonrk-0005oU-MS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 25 Jul 2004 11:36:57 -0700
In-Reply-To: <200407250803.14308.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Ville =?iso-8859-15?q?Syrj=E4l=E4?= <syrjala@sci.fi>

Am Sonntag, 25. Juli 2004 02:03 schrieb Antonino A. Daplas:
> On Sunday 25 July 2004 07:12, Alexander Kern wrote:
> > P.S. Now the last consumer from fb_load_cursor_image is neo driver.
> > Should we drop this function, it's buggy!
>
> We should.  fb_load_cursor_image() cannot be generic.
fine, do you make it for neo driver?
>
> > Steel on my TODO list:
> >
> > Issue with 16bpp mode, brocken boot logo, fbi has problems too.
>
> 1. aty128fb_setcolreg has this lines:
>
> 		case 16:
> 			pal[regno] = (regno << 11) | (regno << 6) | regno;
> 			break;
>
> Shouldn't it be?
>
> 		pal[regno] = (regno << 11) | (regno << 5) | regno;
>
Maybe, but I work on mach64 driver. In atyfb_base.c#2671 it is really
pal[regno] = (regno << 11) | (regno << 5) | regno;
> 2. In RGB555, isn't it better to fill up all the 8 slots per index per
> channel (256/32), instead of just (regno * 8)? For RGB565, that will be 8
> slots per red and blue, 4 slots per green (256/64).
>
> So something like this for RGB555, ie:
>
> 	for  (i = 0; i < 8; i++) {
> 		aty128_st_pal((regno * 8) + i, red, green, blue, par);
>
> RGB565 is a bit more complicated because green is deeper, but is doable.
>
> Tony
>
> DISCLAIMER: I know nothing about this hardware, I'm probably shooting
> blanks :-)


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
