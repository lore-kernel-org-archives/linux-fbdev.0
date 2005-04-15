From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Framebuffer console performance
Date: Fri, 15 Apr 2005 12:57:05 +0800
Message-ID: <200504151257.05950.adaplas@hotpop.com>
References: <1111702489.29791.216.camel@hermes>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMdt6-0005b4-Nx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 20:22:28 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMdt6-0007di-3D
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 20:22:28 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 910991532BD0
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 03:22:19 +0000 (UTC)
In-Reply-To: <1111702489.29791.216.camel@hermes>
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
To: linux-fbdev-devel@lists.sourceforge.net, Gary Thomas <gary@mlbassoc.com>

On Friday 25 March 2005 06:14, Gary Thomas wrote:
> I have a non-standard framebuffer (i.e. I wrote the driver,
> based on the au1000 driver) running on 2.4.27.  When I run
> virtual consoles on it, I see sluggish scroll performance.
> I get quite acceptable performance when the system first
> comes up, e.g. during the system initialization messages,
> but not long afterwards the scrolling slows down.  It can
> get continually worse, eventually ending up at a crawl.

When the system starts up, the scroll mode is 'redraw'.  This mode is
acceptable, not too slow and not too fast either, whatever the hardware is.

After starting up, the scroll mode changes depending on the driver.  Most
probably, it is using ypan which is not too great on systems without
accelerated rectangle moves and framebuffer reads are slow.

Try setting vyres == yres using fbset and see if that helps.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
