From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: XGL/mesa-solo and fbdev
Date: Mon, 21 Feb 2005 21:16:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502212109390.16017@pentafluge.infradead.org>
References: <9e47339105022111483136bd56@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3Kuf-0004Kv-CT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 13:16:17 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3Kud-00070s-TO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 13:16:17 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D3KuY-0004EO-2s
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 21:16:11 +0000
In-Reply-To: <9e47339105022111483136bd56@mail.gmail.com>
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


I have no problem helping you with this :-) In fact I'm very excited!!!!
Who is supporting your work? The problem is free time for me. Otherwise 
I'm 100% behind you and want to work with you. If I could be sponsered for 
this work by someone I would migrate to doing this for a living. I need to 
eat too :-/ 

On Mon, 21 Feb 2005, Jon Smirl wrote:

> XGL/mesa-solo is a project that has been going on for about a year and
> a half now to get X running on top of OpenGL instead of the existing
> 2D XAA drivers. XGL allows a vastly improved user experience as
> demonstrated at the recent X developer's conference. Removing the 2D
> drivers from X means that things like mode setting need to come from
> someplace else, like fbdev.
> 
> To make this project work XGL/mesa-solo needs support for these things
> at the minimum:
> 1) resetting of secondary cards
> 2) mode setting on all heads, not just the primary one
> 3) hardware cursor control
> 4) control of mode setting/cursor etc by users, not just root
> 5) DRM and fbdev need to not conflict
> 
> We are try to get everything in the stack working together before OLS
> this summer. I've posted code to implement some of these features and
> I'm seeking solutions for making the rest work. Does this look like
> something that can get finished in the next month or so? We also need
> time to get all of the layers above fbdev using the new support.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
