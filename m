From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] Provide control of active VGA device
 on PCI systems
Date: Tue, 22 Feb 2005 04:13:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502220411560.21388@pentafluge.infradead.org>
References: <9e47339105021921507545d084@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3RQ3-0003Br-LB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 20:13:07 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3RQ2-0003Jy-29
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 20:13:07 -0800
In-Reply-To: <9e47339105021921507545d084@mail.gmail.com>
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
Cc: Jesse Barnes <jbarnes@sgi.com>


> This patch adds a 'vga' attribute to each framebuffer device on PCI
> systems. For non-PCI hardware it does nothing.
> 
> If you have multiple VGA cards loaded, and you have framebuffer
> drivers loaded for each, you can then set 0/1 into the VGA attributes
> to move VGA console around to the different screens.
> 
> This is almost everything needed to implement reset of secondary
> cards. ROM access is already in the kernel. This code is needed to
> make sure you don't end up with multiple VGA devices enabled. All that
> is left is to construct the proper hotplug event and fix up my user
> space reset program.

Also please place the class_device for vga under /sys/class/graphics/ for 
cleaness.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
