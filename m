From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to add mode setting to sysfs
Date: Mon, 21 Feb 2005 14:11:14 -0500
Message-ID: <9e47339105022111111474017@mail.gmail.com>
References: <9e4733910502161430ff1dad1@mail.gmail.com>
	 <200502172150.16256.adaplas@hotpop.com>
	 <9e47339105021712494955212d@mail.gmail.com>
	 <200502180804.46005.adaplas@hotpop.com>
	 <9e47339105021716392dcce795@mail.gmail.com>
	 <Pine.LNX.4.56.0502211837040.13423@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3Ixj-0005nB-Qy
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:11:19 -0800
Received: from rproxy.gmail.com ([64.233.170.207])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D3Ixh-0006WW-Ej
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:11:19 -0800
Received: by rproxy.gmail.com with SMTP id z35so594295rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 11:11:14 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502211837040.13423@pentafluge.infradead.org>
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
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>

On Mon, 21 Feb 2005 18:37:45 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> Here is a question. What about if the drivers are built and fbdev is
> modular? I will have to try it to see the results.

If a driver is built in you can't use fb as a module. Kernel kconfig
controls this automatically for you. If you pick fb as a module you
will only get modules as a choice on the drivers. If you pick built in
you can build the drivers either way. You can't compile fb as a module
and have built in drivers, the kernel will refuse to build.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
