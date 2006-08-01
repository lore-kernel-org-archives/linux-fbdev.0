From: Richard Wolf <rwolf@cardaccess.com.au>
Subject: Re: Driver for Sharp LH155BA
Date: Tue, 1 Aug 2006 10:59:04 +1000
Message-ID: <170385E48B041543AC99CCD09E325AD1952BB9@mail.rogermanagement.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7iKd-00008z-Fg for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 17:41:59 -0700
Received: from [203.166.87.76] (helo=mail1.cardaccess.com.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7iKc-00085U-S1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 17:41:59 -0700
Received: from MAIL.cardaccess.com.au (unknown [203.41.80.28])
	by mail1.cardaccess.com.au (Postfix) with ESMTP id 7FBE8D379E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Aug 2006 10:41:15 +1000 (EST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

 

> -----Original Message-----
> From: Antonino A. Daplas [mailto:adaplas@gmail.com] 
> Sent: Tuesday, 1 August 2006 10:36 AM
> To: linux-fbdev-devel@lists.sourceforge.net
> Cc: rwolf@cardaccess.com.au
> Subject: Re: [Linux-fbdev-devel] Driver for Sharp LH155BA
> 
> Richard Wolf wrote:
> > Hi,
> > 
> > I'm writing a driver for the Sharp LH155BA LCD driver.  This is a 
> > driver designed for controlling small/medium lcd panels (up 
> to 128 x 64 pixels).
> > 
> > I'm trying to decide whether it is sensible to write a frame buffer 
> > driver for a device of this nature.  Does the frame buffer 
> abstraction 
> > make sense for a display this small?
> 
> The dimensions of the display does not matter.
> 
> > 
> > On our target hardware it is not possible to access the 
> display memory 
> > directly.  Rather, all accesses to display memory and other control 
> > registers are through a small number of io ports.  
> Therefore it is not 
> > possible to map display memory.  Is this relevant?
> 
> Yes, if the display memory is not mappable, then it won't be 
> usable as a driver for X, for example.
> 
> You can however allocate a shadow buffer in system RAM which 
> can be mmapp'ed.
> Then on intervals, perhaps by interrupt or timer, update the 
> physical screen.
> Unfortunately, this is inefficient, as you may be updating 
> the screen even if the shadow buffer haven't changed.  But 
> that is the best you can do without hacking the kernel.
> 
> Another option is to just forget about mmap, and create your 
> own fb_read and fb_write hooks.  This is more efficient, but 
> not all apps use this method to update the framebuffer. The 
> driver will be usable as a console though.
> 
> Tony

Thanks Tony

Presumably if I take the shadow buffer route then I could maintain _two_
shadow buffers.  This would allow me to detect whether the user accessible
buffer had been changed and update the display only when necessary.  

Regards,

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
