From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Thu, 3 Mar 2005 00:12:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
References: <9e47339105030102003ee47879@mail.gmail.com> 
 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
 <9e47339105030210135dbe71ed@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6dx5-0001m6-1S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 16:12:27 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D6dx3-00048R-TZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 16:12:26 -0800
In-Reply-To: <9e47339105030210135dbe71ed@mail.gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>


> Have you considered moving all of the monitor support out into a
> hotplug helper app? This will even work at boot time since early user
> space is there when fbdev initializes. The helper app would be on
> initrd just like the boot disk drivers.

Consider the following case. I have high end server with fbcon running as
the console. One VC is at a different resolution than another. Now say the
system is under really heavy load. When I VC switch I would have to wait
until userland sets up the proper mode for me to VC switch. Consider also 
if userland apps start getting killed. I'm limited to only VCs of the same 
resolution if that helper app dies :-( 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
