From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: sysfs support for framebuffer
Date: Mon, 21 Feb 2005 21:36:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502212117240.16017@pentafluge.infradead.org>
References: <9e4733910502181435f60371c@mail.gmail.com> 
 <Pine.LNX.4.56.0502211841580.13423@pentafluge.infradead.org>
 <9e4733910502211133a8d7e59@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3LER-0005FC-6S
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 13:36:43 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3LEQ-0003Qu-Da
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 13:36:43 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D3LEM-0004IQ-C3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 21:36:40 +0000
In-Reply-To: <9e4733910502211133a8d7e59@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net


> > Yes. line_length. The cursor needs to be expanded. There is much more than
> > that. Pretty much var and fix fields need to be exported to userland.
> 
> I would like to keep the export data to user space at a minimum. So if
> you want to set a non-standard mode edit /etc/mode and then use the
> root priv app to add it to the list as a binary structure via
> sysfs/modes. The patch currently supports this.

If you want to support the same level of functionality as the current 
fbdev setup then you have to export var and fix to userspace. You need 
that data to be able to write to the framebuffer properly. 

> > Do we really want everything under fb0. I was thinking we should have a
> > directory for a card and under that directory list all the properties.
> > I was considering this approach so both DRM and fbdev can exist is the
> > same spot.
> 
> DRM and fbdev can not exist in the same spot since they make
> independent deivces, fb0 and drm0. Udev needs them in two different
> places otherwise there is no way to make two 'dev' attributes.

I mean have drm under /sys/class/graphics/

Also we would have /sys/class/graphics/lcd/
		   /sys/class/graphics/display0/	One for each monitor
		   /sys/class/graphics/zbuffer0/
		   /sys/class/graphics/fb0
etc. 

Now there is a problem to the above. If we have more than one graphics 
card it will get messy. I would guess the X server wants to know what 
things belong to what device. For example the matrox card supports dual 
heads. What if we have 3 graphics cards. Which two fbX devices belong to the 
matrox card. You could scan all the directories and organize a list for 
what belongs to what but that would be messy. Plus what if we plug 
a monitor in. We have to know which things (fb, mmio) effect its output.

> > We also need to deal with mirroring. How are we going to handle that?
> > Also some card support chaining cards together to into one monitor.
> > We need to really think about the design. Because once it goes into the
> > main tree it will be hard to change the userland api.
> 
> Mirroring and merged fb would be handled by special modes in the mode
> list. You would need ownership of both heads to set these modes.
> Setting a mode like this into one head would then disable the device
> for the other one.

Okay. Also for demo mode we don't need to handle every case. Just the 
common ones.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
