From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Tue, 1 Mar 2005 21:05:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503012102360.4595@pentafluge.infradead.org>
References: <9e4733910502241239268ca595@mail.gmail.com> 
 <200502250704.56925.adaplas@hotpop.com>  <9e47339105022415165ee292e0@mail.gmail.com>
  <200502250720.33030.adaplas@hotpop.com>  <Pine.LNX.4.56.0502251755400.20213@pentafluge.infradead.org>
 <9e473391050225113466ccdcb8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6EYe-0007Yw-RZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 13:05:32 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D6EYd-0003jA-VQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 13:05:32 -0800
In-Reply-To: <9e473391050225113466ccdcb8@mail.gmail.com>
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
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net


> There is already code of mine in the kernel so I have been through the
> process. Let's get the process moving on these patches so that they
> will be in place by the time OLS comes around. This patch is small and
> non-controversial. Let's get it started moving forward so that we can
> spend time on the complex ones. The complex ones will also need to get
> hammered out on LKML since they involve complicated hotplug code.
> 
> The next patch will be the sysfs one but it is not ready yet.
> After that is the reset one.
> Next will be secondary head support in the radeon driver.
> 
> These three will require a lot more code review.

Have patience. Also if your patch doesn't go in time you still can demo a 
patched kernel. When I first started out maintaning the fbdev layer I made 
radical changes all the time. This just got people upset. Now I take my 
time and make sure everything works and its clean. 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
