From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Patch to add mode setting to sysfs
Date: Mon, 21 Feb 2005 21:16:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502212116220.16017@pentafluge.infradead.org>
References: <9e4733910502161430ff1dad1@mail.gmail.com> 
 <200502172150.16256.adaplas@hotpop.com>  <9e47339105021712494955212d@mail.gmail.com>
  <200502180804.46005.adaplas@hotpop.com>  <9e47339105021716392dcce795@mail.gmail.com>
  <Pine.LNX.4.56.0502211837040.13423@pentafluge.infradead.org>
 <9e47339105022111111474017@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3KvT-0004Lt-TC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 13:17:07 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3KvS-00074f-9L
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 13:17:07 -0800
In-Reply-To: <9e47339105022111111474017@mail.gmail.com>
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
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>


> <jsimmons@www.infradead.org> wrote:
> > 
> > Here is a question. What about if the drivers are built and fbdev is
> > modular? I will have to try it to see the results.
> 
> If a driver is built in you can't use fb as a module. Kernel kconfig
> controls this automatically for you. If you pick fb as a module you
> will only get modules as a choice on the drivers. If you pick built in
> you can build the drivers either way. You can't compile fb as a module
> and have built in drivers, the kernel will refuse to build.

So kbuild is smart enough to handle this. In the old days you could break 
the build.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
