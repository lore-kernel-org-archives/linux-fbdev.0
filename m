From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Tue, 1 Mar 2005 21:11:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
References: <9e47339105030102003ee47879@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6EeM-0007kz-J0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 13:11:26 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D6EeJ-0004PM-RX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 13:11:26 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D6EeG-0001Fg-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 21:11:22 +0000
In-Reply-To: <9e47339105030102003ee47879@mail.gmail.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> Not finished yet but here's an update.

Barf!!!! This patch is just nasty hack. Okay a run down on the fbdev api. 
First struct xxx_par is your data structure representing your device. 
There is one per video card. That is that hook in struct fb_info called 
par. The idea was xxx_par could be independent of the fbdev layer and 
could be used DRI. Now for the case of video cards with more than one 
framebuffer then you have bothe struct fb_info's par point to the same 
data structure. The verse works as well. Some systems allow multiple video 
cards hooked up to one montior. Two framebuffers, one display. The 
structure to deal with that is monspecs in struct fb_info. Now the problem 
is it is not a pointer :-( I have to fix that with a patch in the near 
future. If you are going to be messing with montiors work off of struct 
fb_monspecs.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
