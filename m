From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 10:59:39 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031014175939.2616.qmail@web14916.mail.yahoo.com>
References: <Pine.LNX.4.44.0310141735250.20831-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9TSP-0002hn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 10:59:41 -0700
Received: from web14916.mail.yahoo.com ([216.136.225.229])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9TSO-0003gY-BB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 10:59:40 -0700
In-Reply-To: <Pine.LNX.4.44.0310141735250.20831-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- James Simmons <jsimmons@infradead.org> wrote:
> 
> > I just think the whole concept
> > of mapping the framebuffer in to kernel space needs to be eliminated. 
> 
> I agree. That is why I moved the api over to a accelerated api. The idea 
> was to get people to write accelerated drivers. Drivers using acceleration 
> don't need to map the framebuffer in kernel space.
> 
> > 1) System boots using VGA mode or whatever BIOS provides.
> 
> On x86 platforms this fine but for the rest of the world this is not.
> 
I'm looking at this as more of a choice. If you have DRI supported hardware
pick the DRI scheme, otherwise continue with existing framebuffer.  DRI only
supports about 10% of existing graphics cards, but these 10% are used in 90% of
current general purpose systems. 

DRI doesn't exist on most embedded device, PDA's, etc. so stick with the
current framebuffer. The ioremap is only causing problems on systems with over
1GB memory so this eliminates most smaller devices.

My main motivation for this is to have a single driver controlling the graphics
hardware on DRI supported systems. This will eliminate the problem with saving
hardware state between VT's. 

Another issue I am having trouble with is having mode setting/EDID code in a
device driver. That is a lot of seldom used code sitting in a device driver.
I'd rather see it in a user space library. Some hardware (Rage128) can only
read EDID info from user space becuase of real mode INT10 problems.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
