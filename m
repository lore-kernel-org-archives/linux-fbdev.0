From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 09:04:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049158940.1059.21.camel@localhost.localdomain>
References: <20030401000746.44732.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190AGk-00066T-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 Mar 2003 17:08:55 -0800
In-Reply-To: <20030401000746.44732.qmail@web14912.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DirectFB-devel <directfb-dev@directfb.org>

On Tue, 2003-04-01 at 08:07, Jon Smirl wrote:
> I didn't read through the code yet, is this being
> implemented by adding some new IOCTLs to the fb
> interface? For example an IOCTL to get the legal modes
> or to reset the card.
> 

It uses a dedicated device, /dev/vm86, which is unrelated to fb.

> Why does it need /dev/vm86, couldn't it just use the
> fb device and add some new IOCTLS?

A new device seems more powerful and more generic.  Generic in a sense
that other subsystems besides fbdev can use it to access the BIOS or
whatever.  More powerful because a dedicated device is also provided
with the functionality of the file system.  The daemon uses file
read/write to access data, select/poll to wait for device ready, and 1
ioctl call to let /dev/vm86 know that the daemon is loaded or to be
unloaded. If async IO works for regular files, it will also have that
functionality.
 
> 
> I would expect to the end user app to only interact
> with the /dev/fb, it would be unaware of the daemon.
> This would allow these functions to be transparently
> added to the driver if the need hardware info becomes available.
> 

Yes.  Behavior of /dev/fbX is still the same, except that when vm86d is
loaded, it provides additional functionality to vesafb. The user will
not notice that vm86d is there, except that he/she and applications can
now change the video mode. 

Tony
 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
> http://platinum.yahoo.com
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ValueWeb: 
> Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
> No other company gives more support or power for your dedicated server
> http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
