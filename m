From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Wed, 2 Mar 2005 13:13:09 -0500
Message-ID: <9e47339105030210135dbe71ed@mail.gmail.com>
References: <9e47339105030102003ee47879@mail.gmail.com>
	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6YLR-0001jR-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 10:13:13 -0800
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6YLQ-0000LY-6R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 10:13:13 -0800
Received: by rproxy.gmail.com with SMTP id z35so335870rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 10:13:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@www.infradead.org>

On Tue, 1 Mar 2005 21:11:20 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > Not finished yet but here's an update.
> 
> Barf!!!! This patch is just nasty hack. Okay a run down on the fbdev api.
> First struct xxx_par is your data structure representing your device.
> There is one per video card. That is that hook in struct fb_info called
> par. The idea was xxx_par could be independent of the fbdev layer and
> could be used DRI. Now for the case of video cards with more than one
> framebuffer then you have bothe struct fb_info's par point to the same
> data structure. The verse works as well. Some systems allow multiple video
> cards hooked up to one montior. Two framebuffers, one display. The
> structure to deal with that is monspecs in struct fb_info. Now the problem
> is it is not a pointer :-( I have to fix that with a patch in the near
> future. If you are going to be messing with montiors work off of struct
> fb_monspecs.

Have you considered moving all of the monitor support out into a
hotplug helper app? This will even work at boot time since early user
space is there when fbdev initializes. The helper app would be on
initrd just like the boot disk drivers.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
