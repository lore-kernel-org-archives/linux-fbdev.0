From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Fri, 25 Feb 2005 14:34:57 -0500
Message-ID: <9e473391050225113466ccdcb8@mail.gmail.com>
References: <9e4733910502241239268ca595@mail.gmail.com>
	 <200502250704.56925.adaplas@hotpop.com>
	 <9e47339105022415165ee292e0@mail.gmail.com>
	 <200502250720.33030.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502251755400.20213@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4lEq-0005TR-5w
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 11:35:00 -0800
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D4lEo-00035g-JE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 11:35:00 -0800
Received: by rproxy.gmail.com with SMTP id z35so1251545rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 25 Feb 2005 11:34:57 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502251755400.20213@pentafluge.infradead.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

On Fri, 25 Feb 2005 17:57:44 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> Yeap. The process is first make patch and send to list for testing. People
> comment and some changes happen. This can happen several times. Once the
> patch is acceptable then it going into Andrew's tree for wider range
> testing. Once Andrew determines that the patch is safe he sends it to
> linus. It is a sure way to make sure the patches are of the highest
> quality.

There is already code of mine in the kernel so I have been through the
process. Let's get the process moving on these patches so that they
will be in place by the time OLS comes around. This patch is small and
non-controversial. Let's get it started moving forward so that we can
spend time on the complex ones. The complex ones will also need to get
hammered out on LKML since they involve complicated hotplug code.

The next patch will be the sysfs one but it is not ready yet.
After that is the reset one.
Next will be secondary head support in the radeon driver.

These three will require a lot more code review.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
