From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Mon, 7 Mar 2005 18:05:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503071803480.21233@pentafluge.infradead.org>
References: <9e47339105030102003ee47879@mail.gmail.com> 
 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org> 
 <9e47339105030210135dbe71ed@mail.gmail.com> 
 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
 <9e47339105030216576d592d14@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mbt-0007Ga-2Z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:05:41 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8Mbs-0005GY-1R
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:05:40 -0800
In-Reply-To: <9e47339105030216576d592d14@mail.gmail.com>
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


> It is a helper app, not a daemon, it does not stay running. It also
> only runs when the monitor is changed - not mode change, monitor
> changed. On monitor change (loading fbdev counts as a monitor change)
> the helper is called. The helper reads the DDC, parses it, merges in
> any updates from /etc/fb.modes (or builds a modelist from fb.modes if
> no DDC), and then sets this list of legal modes into the driver. After
> the list is set a hal/dbus event is generated. Doing this is a root
> only operation.
> 
> It can also happen in early user space when the kernel is first
> booting. Early user space starts before fbcon currently starts. The
> helper app would be loaded on to initrd or initramfs.

The question is will work on systems that have no space to write data. 
Alot of embedded devices can store anything. The fb.modes is very limiting 
in this case. Having a permanent RAM filesystem is expensive.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
