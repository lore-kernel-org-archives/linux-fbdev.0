From: "Jorge Luis Zapata Muga" <jorgeluis.zapata@gmail.com>
Subject: overlay support
Date: Tue, 12 Sep 2006 15:27:00 +0200
Message-ID: <eb77d7060609120627x2466d68fle0912cbee96f223e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GN8I3-0006L0-Kk for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 06:27:03 -0700
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GN8I1-0007Ol-R2
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 06:27:03 -0700
Received: by wr-out-0506.google.com with SMTP id 67so527468wri
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 12 Sep 2006 06:27:00 -0700 (PDT)
Content-Disposition: inline
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

hi all,

i coded a while ago a framebuffer driver for an old video card i have
(a SiS 6326, just for learning) but now i would like to support its
video extension (overlay support, this card can also capture from an
external input, but my version doesnt has the input connectors). ive
read on the mailing list and on external projects about how to support
overlay on the fb device, but i still dont find a good way to do it,
maybe you can help me out.

one way is to add another fb device, but it is good only if the device
has a different memory space assigned to it, if you only have a chunk
of memory for both layers (the overlay and the normal rgb which is
this case) there should be a way to resize the memory space assigned
to each of them. i dont like this way because is adding a policy on
kernel space to manage the memory. am i correct with this assumptions?

another way is to support a video4linux device (overlay type) for it,
in this case there are other problems too. does the v4l device should
be dependant to the fb device? i mean, make the fb device map all the
display memory and support the common mmap, then the v4l has to
receive the fb mem pointer to setup the registers, and finally from
userspace open both devices to actually support overlaying?

is there other solution?

thanks for your comments.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
