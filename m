From: Stuart Young <sgy-lkml@amc.com.au>
Subject: Re: fbdv/fbcon pending problems
Date: Tue, 24 Feb 2004 16:57:37 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200402241657.37382.sgy-lkml@amc.com.au>
References: <1077497593.5960.28.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvVgq-0007mX-SF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 22:05:08 -0800
Received: from mail1.amc.com.au ([203.15.175.2])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AvVYo-0007Ol-M4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 21:56:50 -0800
In-Reply-To: <1077497593.5960.28.camel@gaston>
Content-Disposition: inline
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Mon, 23 Feb 2004 11:53 am, Benjamin Herrenschmidt wrote:

>  - Logo problems. When booting with a logo, then going to getty, the
> logo doesn't get erased until we actually switch to another console (or
> reset the console). At this point, using things like vi & scrolling up
> doesn't work properly. Actually, last time I tried, I had to switch
> back & forth twice before my console that had the logo got fully working
> with vi.

Been around forever and a day. RedHat getty's clear the screen, which tends to 
remove the unscrollable region that the logo sits in. Debian doesn't, so it's 
much more noticable (and always has been).

This might be best done thru userspace, as having the logo and other graphics 
sitting at the top of the screen through the boot process (eg: sysv init 
scripts, etc) within an unscrollable region can be useful. I know that the 
boot-icons package in Debian actually relies on this behaviour. Perhaps you 
could provide an option in the kernel config to change this default 
behaviour, for those that want it?

If it's possible to unlock this region so that it scrolls again from userspace 
(ie: not resetting/clearing it, just unlocking it), then it's just a simple 
matter of checking wether the current console is an fb device, and if it is, 
making it unlock the scrolling region. In Debian, this could be done 
in /etc/init.d/rmnologin, or even in /etc/profile if someone would rather it 
done after login.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
