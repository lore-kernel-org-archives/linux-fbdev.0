From: Jon Smirl <jonsmirl@gmail.com>
Subject: sysfs support for framebuffer
Date: Fri, 18 Feb 2005 17:35:25 -0500
Message-ID: <9e4733910502181435f60371c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2Gj3-0000Ei-Nx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 14:35:53 -0800
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2Gj1-0001uY-04
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 14:35:53 -0800
Received: by rproxy.gmail.com with SMTP id j1so860rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 14:35:26 -0800 (PST)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

What are the attributes needed for framebuffers in sysfs? 
This is the list I came up with, are there more?

bits_per_pixel - r/w color depth
blank - w set the vesa blank state
color_map - r/w control the color map
console - r/w? map of console number to fb device
cursor - r/w x/y position of the cursor
mode - r/w set the display mode
modes - list of valid modes
pan - r/w x/y of the pan offset
virtual_size - r/w x/y of the virtual size

modes is designed to let a user space root app set the list of valid
modes into the driver
ownership of all other attributes are assigned by pam to the display user
mode must be an entry from the list of modes, this prevents a user
from setting in a damaging mode

The list is based on the current fbdev IOCTLs. All attributes appear
in /sys/class/graphics/fb0/xxxx
Current patch is in the "Patch to add mode setting to sysfs" thread.

fbdev also needs to generate events to let the xserver know if things
have been changed. These can come up through hotplug to dbus.

bits_per_pixel, mode, virtual_size - mode event
blank - blank event
modes - modes event

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
