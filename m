From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: 22 Apr 2004 03:35:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082576159.2343.24.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0404211903440.9207-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGWDy-00063L-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 21:54:10 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGW97-0008OC-4H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 21:49:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 811D97295E
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Apr 2004 18:52:30 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.44.0404211903440.9207-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-04-22 at 02:13, James Simmons wrote:
> 
> > > > This is true for PCI/AGP, but may not be true for unified memory systems.
> > >
> > > Right, but that confirms my opinion that the choice of the technique used
> > > shall be under control of the driver
> > 
> > Agreed. So a hint would be the most appropriate.
> 
> Hi Antonino. Haven't heard from you in a while.

Yeah, been busy.

> 
> I agree. What if we add to vmode in struct fb_screeninfo.
> We have 
> 
> FB_VMODE_YWRAP		256
> FB_VMODE_SMOOTH_XPAN	512
> 
> We can add more fields. Of course we have to figure out what the common 
> case would be.
> 

We can add:

FB_VMODE_YPAN
FB_VMODE_REDRAW /* will use imageblit */
FB_VMODE_MOVE   /* will use copyarea */

Personally, I think FB_VMODE_REDRAW should be the default as it is 
faster than FB_VMODE_MOVE for most PCI cards.

Just to be clear.

1.  If without a ypan or ywrap, fbcon can either do a redraw or a move

2.  If with ypan or ywrap, then fbcon can only do a move.

Ypan + redraw (FB_VMODE_MOVE | FB_VMODE_REDRAW) is not supported, and I
consider this combination to give the fastest and smoothest scrolling
action if driver does not have any hardware acceleration in most cards.
Perhaps this can be added?

Tony
 






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
