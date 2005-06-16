From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Thu, 16 Jun 2005 11:11:21 +0800
Message-ID: <200506161111.27115.adaplas@hotpop.com>
References: <9e47339105061021571f479b10@mail.gmail.com> <Pine.LNX.4.62.0506120942100.11197@numbat.sonytel.be> <9e47339105061518346d1df105@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dil1g-00064h-IO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 20:26:44 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dil1e-0006bA-GT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 20:26:44 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6C0871662FB5
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Jun 2005 03:26:30 +0000 (UTC)
In-Reply-To: <9e47339105061518346d1df105@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>

On Thursday 16 June 2005 09:34, Jon Smirl wrote:
> Are there still issues with this patch?

Maybe.  A few drivers will set the fb_cursor field to either
soft_cursor or the driver-specific cursor function, depending
on the kernel boot options or setting of the var.accel flag.

The changes required are probably minor.

Tony





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
