From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Fri, 4 Mar 2005 13:48:45 -0500
Message-ID: <9e47339105030410482d4d957@mail.gmail.com>
References: <9e47339105030102003ee47879@mail.gmail.com>
	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
	 <9e47339105030210135dbe71ed@mail.gmail.com>
	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
	 <9e47339105030320085331555a@mail.gmail.com>
	 <Pine.LNX.4.56.0503041823590.4067@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7Hqw-0002Av-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:48:46 -0800
Received: from rproxy.gmail.com ([64.233.170.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7Hqw-0001x6-Ga
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:48:46 -0800
Received: by rproxy.gmail.com with SMTP id z35so1177841rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Mar 2005 10:48:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503041823590.4067@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>

On Fri, 4 Mar 2005 18:26:57 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > Doesn't the i830/i915/etc require a user space helper to change modes
> > since that part of the chip spec hasn't been released? The user space
> > helper would use Int10 VBIOS calls to list and set the modes. I
> > haven't worked with these chips, so this is just based off from what
> > has been posted to dri-devel. Is this why we don't have fbdev drivers
> > for these chips?
> 
> drivers/intel/*.[ch]
> 
> No user space helper there.
> 
> 
What about the i915? We don't seem to have a fbdev driver for it yet.


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
