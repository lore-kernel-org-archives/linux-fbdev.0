From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: Mon, 31 Mar 2003 20:01:06 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030401040106.65664.qmail@web14906.mail.yahoo.com>
References: <1049158940.1059.21.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14906.mail.yahoo.com ([216.136.225.58])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190CxO-0006pP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 Mar 2003 20:01:06 -0800
In-Reply-To: <1049158940.1059.21.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DirectFB-devel <directfb-dev@directfb.org>

--- Antonino Daplas <adaplas@pol.net> wrote:
> A new device seems more powerful and more generic. 
> Generic in a sense
> that other subsystems besides fbdev can use it to
> access the BIOS or

The new device is going to need to sort out multiple
adapters. Using /dev/fbX avoids that problem. You'll
also be able to get the /dev/fb code into the kernel.
Getting a driver in that creates /dev/vm86 is going to
be harder. 

I'm not clear on what /dev/vm86 does. Why couldn't the
radeon driver exec vm86d with a parameter of /dev/fb0.
vm86d would then open/IOCTL the radeon driver to
identify the PCI device and what actions are needed.
After it resets and gets the EDID data it would IOCTL
them back into /dev/fb0 and exit. You need to know
which PCI device so that you can set up the right
VBIOS ROM. Each adapter would get it's own vm86d, but
they wouldn't hang around long.

I haven't played with this yet but the vm86d should
use the new klibc. That would allow it to run early in
the boot process. The driver could then exec it if
needed. It would also make vm86d tiny.

The Radeon and Rage128 cards need a reset if they are
reporting zero VRAM.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
