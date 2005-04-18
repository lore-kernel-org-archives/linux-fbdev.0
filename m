From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Framebuffer console performance
Date: Mon, 18 Apr 2005 05:07:38 -0600
Message-ID: <1113822458.1030.16.camel@hermes>
References: <1111702489.29791.216.camel@hermes>
	 <200504151257.05950.adaplas@hotpop.com>  <1113650790.10535.42.camel@hermes>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNU6W-00065a-Qy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Apr 2005 04:07:48 -0700
Received: from sta-206-168-96-204.rockynet.com ([206.168.96.204] helo=hermes.chez-thomas.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DNU6V-00049y-Cf
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Apr 2005 04:07:48 -0700
In-Reply-To: <1113650790.10535.42.camel@hermes>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2005-04-16 at 05:26 -0600, Gary Thomas wrote:
> On Fri, 2005-04-15 at 12:57 +0800, Antonino A. Daplas wrote: 
> > On Friday 25 March 2005 06:14, Gary Thomas wrote:
> > > I have a non-standard framebuffer (i.e. I wrote the driver,
> > > based on the au1000 driver) running on 2.4.27.  When I run
> > > virtual consoles on it, I see sluggish scroll performance.
> > > I get quite acceptable performance when the system first
> > > comes up, e.g. during the system initialization messages,
> > > but not long afterwards the scrolling slows down.  It can
> > > get continually worse, eventually ending up at a crawl.
> > 
> > When the system starts up, the scroll mode is 'redraw'.  This mode is
> > acceptable, not too slow and not too fast either, whatever the hardware is.
> > 
> > After starting up, the scroll mode changes depending on the driver.  Most
> > probably, it is using ypan which is not too great on systems without
> > accelerated rectangle moves and framebuffer reads are slow.
> > 
> > Try setting vyres == yres using fbset and see if that helps.

Thanks for getting back to me on this.

This does seem to have been the problem.  I made a few tweaks to
my driver's setup and now it does not switch into slow mode (I actually
think it was going into __SCROLL_YMOVE mode instead of __SCROLL_YREDRAW)

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
