From: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Tue, 22 Feb 2005 10:50:43 -0800
Message-ID: <200502221050.43534.jbarnes@sgi.com>
References: <9e47339105021921507545d084@mail.gmail.com> <9e473391050219230764b0dfd2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3f8a-0005HK-7z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 10:52:00 -0800
Received: from omx2-ext.sgi.com ([192.48.171.19] helo=omx2.sgi.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3f8X-0002Rc-H8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 10:52:00 -0800
In-Reply-To: <9e473391050219230764b0dfd2@mail.gmail.com>
Content-Disposition: inline
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, benh@kernel.crashing.org

On Saturday, February 19, 2005 11:07 pm, Jon Smirl wrote:
> New version to previous patch. This one adds the hotplug event mentioned
> before.
>
> To achieve secondary card reset:
>   Load a framebuffer driver.
>   Driver causes hotplug add event
>   reset=x environment parm indicates reset, primary cards is false
>   run user space reset program
>   read VBIOS content using existing API
>   turn off all VGA devices, sysfs vga=3
>   reset the card
>   restore original VGA devices. sysfs vga=4
>   set sysfs no_reset=1 to prevent further resets
>
> Tomorrow I'll clean up a user space reset app and post it.

Nice, if this is combined with Ben's suggestion of using a firmware loader 
type model to deal with POSTing, it seems like we're in pretty good shape.  
Can you add documentation for this API to 
Documentation/filesystems/sysfs-<foo>.txt (maybe the pci file or a new file) 
so that userspace people will be able to figure out how to use it?

Also, how does one know if a card is 'primary' or not?  I.e. some BIOSes will 
POST all cards, some will POST only one, and some will POST none...

Thanks,
Jesse


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
