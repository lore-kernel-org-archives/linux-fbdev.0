From: James Simmons <jsimmons@infradead.org>
Subject: Re: how does one _stop_ using fb
Date: Thu, 14 Jul 2005 20:19:07 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507142006070.20470@pentafluge.infradead.org>
References: <200507061756.DRF75259@ms3.netsolmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt9Ew-0004cy-3o
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Jul 2005 12:19:22 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Dt9Ev-0004U8-Oe
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Jul 2005 12:19:22 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.52 #1 (Red Hat Linux))
	id 1Dt9Eh-0005mw-DP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Jul 2005 20:19:12 +0100
In-Reply-To: <200507061756.DRF75259@ms3.netsolmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


You need a driver that supports going back to vga text mode. Unfortunely 
very few drivers support that. At present we can't go back.


On Wed, 6 Jul 2005 evt@texelsoft.com wrote:

> or IOW how does one undo con2fb and put the console back to
> vga to unload a framebuffer module. Thanks.
> 
> - Eric van Tassell
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
