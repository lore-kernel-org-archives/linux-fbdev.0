From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Mon, 7 Mar 2005 13:10:04 -0500
Message-ID: <9e473391050307101051d3ada3@mail.gmail.com>
References: <9e47339105030102003ee47879@mail.gmail.com>
	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
	 <9e47339105030210135dbe71ed@mail.gmail.com>
	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
	 <9e47339105030216576d592d14@mail.gmail.com>
	 <Pine.LNX.4.56.0503071803480.21233@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8MgE-0007Vd-FK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:10:10 -0800
Received: from rproxy.gmail.com ([64.233.170.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8MgA-0005oc-JV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:10:10 -0800
Received: by rproxy.gmail.com with SMTP id z35so2011874rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 10:10:05 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503071803480.21233@pentafluge.infradead.org>
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

On Mon, 7 Mar 2005 18:05:35 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> The question is will work on systems that have no space to write data.
> Alot of embedded devices can store anything. The fb.modes is very limiting
> in this case. Having a permanent RAM filesystem is expensive.

I doubt if a system that constrained needs to change modes at all. In
that case just build the mode into the driver and forget everything
else.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
