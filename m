From: Raphael Assenat <raph@8d.com>
Subject: Re: overlay support
Date: Tue, 12 Sep 2006 10:49:10 -0400
Message-ID: <4506C8E6.70409@8d.com>
References: <eb77d7060609120627x2466d68fle0912cbee96f223e@mail.gmail.com>
	<Pine.LNX.4.62.0609121531120.27586@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GN9Yd-0005PQ-Gv for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 07:48:15 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GN9Yd-0005Bv-3w
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 07:48:15 -0700
Received: from trivia.8d.com ([209.47.172.20] helo=[192.168.142.55])
	by roc.holo.8d.com with esmtp (Exim 4.50) id 1GN9YH-0002rh-Fx
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 10:48:07 -0400
In-Reply-To: <Pine.LNX.4.62.0609121531120.27586@pademelon.sonytel.be>
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

Geert Uytterhoeven wrote:
> On Tue, 12 Sep 2006, Jorge Luis Zapata Muga wrote:
> 
>>i coded a while ago a framebuffer driver for an old video card i have
>>(a SiS 6326, just for learning) but now i would like to support its
>>video extension (overlay support, this card can also capture from an
>>external input, but my version doesnt has the input connectors). ive
>>read on the mailing list and on external projects about how to support
>>overlay on the fb device, but i still dont find a good way to do it,
>>maybe you can help me out.
>>
>>one way is to add another fb device, but it is good only if the device
>>has a different memory space assigned to it, if you only have a chunk
>>of memory for both layers (the overlay and the normal rgb which is
>>this case) there should be a way to resize the memory space assigned
>>to each of them. i dont like this way because is adding a policy on
>>kernel space to manage the memory. am i correct with this assumptions?
> 
> 
> If there are just 2 users of the memory (i.e. 2 frame buffers), you can avoid
> adding a policy to the kernel by making the split dynamic.
> Let the first frame buffer `allocate' (based on xres_virtual, yres_virtual, and
> bits_per_pixel) from the bottom of memory, and the second frame buffer from the
> top of memory. Each frame buffer can shrink whatever it wants, or grow, as long
> as it doesn't conflict with the memory size of the other.
How about creating an ioctl specific to this device, which could be used to pass a
struct to the driver containing information such as size, position, pixel format, overlay 
memory address(es), plane(s) stride? With this approach, the userspace application decides 
where to place the overlay in memory based on it's knowledge of it's regular framebuffer 
memory usage. If both areas conflict, it's the userspace app fault and corruption appears 
on the screen.

That's the approach I use in the mbxfb driver. (see [PATCH 4/5] mbxfb: Add YUV video 
overlay suport).

If many drivers were to implement overlays this way, we could create a new framebuffer 
ioctl for this purpose and remove the need for driver specific ioctls.

Best regards,
Raphael Assenat

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
