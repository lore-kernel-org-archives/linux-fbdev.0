From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Re: Fbdev magics
Date: Fri, 7 May 2004 00:26:54 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405070026.54372.lucasvr@gobolinux.org>
References: <200405050027.58630.lucasvr@terra.com.br> <Pine.GSO.4.58.0405061112110.12096@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLw0M-0001er-9C
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 20:26:30 -0700
Received: from chiapa.terra.com.br ([200.154.55.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLw0L-0004j5-Gm
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 20:26:29 -0700
Received: from tucuman.terra.com.br (tucuman.terra.com.br [200.154.55.139])
	by chiapa.terra.com.br (Postfix) with ESMTP id 4D74BEC3D1
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 00:26:25 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-117.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.117])
	(authenticated user lucasvr)
	by tucuman.terra.com.br (Postfix) with ESMTP id 08EFD3C016
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 00:26:25 -0300 (BRT)
In-Reply-To: <Pine.GSO.4.58.0405061112110.12096@waterleaf.sonytel.be>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Thursday 06 May 2004 06:17, Geert Uytterhoeven wrote:
...
> So you cannot access the frame buffer memory from the CPU, except through
> sending commands to the LCD controller, right?

Right, but today I discovered that the display controller allows to have DMA 
access for every "page" (8 lines on the display). Cool! ;-)

> > ...
> > - how is the "refresh" done by fbdev? I don't want to keep sending the
> > same data to the display if there isn't any update to be done.
>
> If the frame buffer memory is accessible directly by the CPU, it will be
> updated automatically. If not, things get more difficult:
>   - For text console output, 2.4.x will do direct accesses to the frame
> buffer, which won't work.
>     In 2.6.x, fbcon will call the fb_{fillrect,copyarea,imageblit}()
> routines of your fbdev driver, so you can handle that easily
>   - For graphics from user space, things are more complex, since the
>     application cannot mmap() your frame buffer memory. Either you use a
> shadow frame buffer that updates the hardware periodically, or teach your
> application to talk to the LCD controller directly.

Given that DMA facility, I started to write the code with a frame buffer of 
the same size of the screen and installed an interrupt handler for the DMA; 
when a transfer of a page is done, it interrupts and I can switch this page 
and select another "page" to be automatically updated to the display.

It won't update the entire display at a single time, but it will probably make 
the magic. At least I got the impression that this could be a good logic, 
I'll do some tests tomorrow and will tell if everything worked fine then :-)


> > - also related to this refresh: I haven't seen any interrupt being
> > handled by many fbdev drivers. Is this ok? How will fbdev knows when the
> > card is trying to communicate with the CPU?
>
> Most drivers don't use interrupts yet, because until recently (speaking
> about 2.6), you could not use them there.

I've seen some LCD display drivers for embedded devices that handled it 
directly with request_irq() on 2.4. As I could see from the bottom layers of 
fbdev, an interrupt handler in a driver doesn't seem to hurt anyone there.. 
or am I wrong?

> > - given that I can be told when the user is going to write some data to
> > the fbdev (should I implement my own fb_read and fb_write operations?),
> > is there an automatic way to get only the pixels that he's modifying?
> > This would save a lot of unnecessary transfers to the display as well.
>
> You should implement your own fb_{read,write}() if the CPU cannot access
> the frame buffer memory directly.
>
> > Just forgot to tell that I'm running Linux 2.4.20 for ARM.
>
> 2.6 would make life simpler for you :-)

Sure, I'll give a look for 2.6 fbdev ASAP, it already seems to have a better 
interface, just by looking into the headers.

Cheers, and thanks for the reply,
Lucas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
