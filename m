From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Resource management.
Date: Tue, 22 Feb 2005 03:53:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org> 
 <200502220653.01286.adaplas@hotpop.com>  <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
 <9e473391050221170111610521@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
In-Reply-To: <9e473391050221170111610521@mail.gmail.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Do you see any other solution to this then?
> 
> You could build this inside of the DRM framework which already
> supports DMA and memory management. DRM doesn't really know anything
> about 3D, it just knows how to send commands to the graphics hardware.
> It's the mesa layer in user space that knows about 3D.
> 
> There is a lot of code inside DRM to stop a DRM user from using the
> DMA hardware to play with kernel memory and gain root priv. fbdev will
> need the same protection if it starts using DMA.

I have CC the dri list to discuss the issues. I have looked at the DRI 
code. I know merging dri and fbdev infrastructres has been discussed
before. There are a few issues that have always prevented this. Now
I'm going to go over the issues.

1. Lots of work that would take lots of time. To my knowledge all fbdev 
   developers work in there spare free time. No one does this for a 
   living.

2. Sharing of headers. The dri headers are isolated in the drm directory.
   I totally understand why :-) It makes merging easier for them. The
   disadvantage is no one in the fbdev can use them easily :-(

3. DRM has way to much functionality for most embedded devices. I have 
   talked to embedded guys before and they want a simple api to work with.
   By default DRM builds in everything. A simple api mean alot to those 
   guys. Plus the extra built in code bloat takes up to much space which 
   is precious on embedded devices. If a devices doesn't support dma then 
   the dma code doesn't need to be built in.

4. Which comes to the next point. The code is not modular enough. Take 
   drm_bufs.c. Everything is a ioctl function. This has a few disadvantages.
   One is the fbdev layer couldn't just link into it so fbcon could use 
   it. The second is it's not easy to take advantage of things like sysfs.
   If you could untangle the code somewhat it would make life so much 
   easier. That would include making life easier for OS ports.

5. The license issue. The DRI code is GPL and additional rights. What is that? 

For the fbdev layer we would need a layer on top of the drm data 
structures because we need to know things in the kernel to draw images
for font characters i.e how much byte padding is need for images.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
