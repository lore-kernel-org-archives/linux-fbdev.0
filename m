From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: sysfs support for framebuffer
Date: Mon, 21 Feb 2005 18:50:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502211841580.13423@pentafluge.infradead.org>
References: <9e4733910502181435f60371c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3IdV-0004Lb-A0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 10:50:25 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3IdU-0000KG-RN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 10:50:25 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D3IdN-0003ip-Ce
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 18:50:19 +0000
In-Reply-To: <9e4733910502181435f60371c@mail.gmail.com>
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


> What are the attributes needed for framebuffers in sysfs? 
> This is the list I came up with, are there more?
> 
> bits_per_pixel - r/w color depth
> blank - w set the vesa blank state
> color_map - r/w control the color map
> console - r/w? map of console number to fb device
> cursor - r/w x/y position of the cursor
> mode - r/w set the display mode
> modes - list of valid modes
> pan - r/w x/y of the pan offset
> virtual_size - r/w x/y of the virtual size

Yes. line_length. The cursor needs to be expanded. There is much more than 
that. Pretty much var and fix fields need to be exported to userland.
 
> modes is designed to let a user space root app set the list of valid
> modes into the driver
> ownership of all other attributes are assigned by pam to the display user
> mode must be an entry from the list of modes, this prevents a user
> from setting in a damaging mode
> 
> The list is based on the current fbdev IOCTLs. All attributes appear
> in /sys/class/graphics/fb0/xxxx
> Current patch is in the "Patch to add mode setting to sysfs" thread.

Do we really want everything under fb0. I was thinking we should have a 
directory for a card and under that directory list all the properties. 
I was considering this approach so both DRM and fbdev can exist is the 
same spot. 

cardname0/frame0
	 /mmio0/
	 /zbuffer0/
	 /modes/

We also need to deal with mirroring. How are we going to handle that?
Also some card support chaining cards together to into one monitor. 
We need to really think about the design. Because once it goes into the 
main tree it will be hard to change the userland api. 

> fbdev also needs to generate events to let the xserver know if things
> have been changed. These can come up through hotplug to dbus.
> 
> bits_per_pixel, mode, virtual_size - mode event
> blank - blank event
> modes - modes event

Yeap. 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
