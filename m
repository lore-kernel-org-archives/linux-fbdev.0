From: James Simmons <jsimmons@infradead.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Mon, 25 Jul 2005 17:33:59 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507251729430.21629@pentafluge.infradead.org>
References: <9e47339105061021571f479b10@mail.gmail.com> 
 <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org> 
 <9e473391050701175679f468ff@mail.gmail.com>  <200507231305.59225.adaplas@gmail.com>
 <9e473391050723084153d29566@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dx5uD-0005eg-52
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 09:34:17 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Dx5uB-00009z-SF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 09:34:17 -0700
In-Reply-To: <9e473391050723084153d29566@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net


> 1) the current ioctl one

Defunct.

> 2) the new stuff in sysfs. If the hardware cursor is there you get a sysfs 
> attribute named cursor. write x,y to it to move the cursor around. I'll add 
> the sysfs support as soon as we decide on the interface.

I was playing with that a bit.

> I'm still at OLS. Missed seeing both of you at KS. fbdev was discussed and 
> Linus went with Benh's proposal to move the modesetting API to user space. 
> Obviously this will have a lot of impact on fbdev.

I don't have any money to go to such events :-( Looks like fbdev is going 
away completly :-< We will need embedded graphics libraries to boot a 
machine in the future. I seen this coming and thats why my motivation for 
development keeps dropping. I suggest they make a big diff to remove the 
whole system.  


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
