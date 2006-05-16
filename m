From: Sylvain Garrigues <garrigue@enst.fr>
Subject: Framebuffer output but no framebuffer console output
Date: Tue, 16 May 2006 17:02:14 +0200
Message-ID: <4469E976.1080709@enst.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fg133-0003Zm-LL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 08:01:21 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fg133-0003uX-QG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 08:01:21 -0700
Received: from a.mx.realmagic.fr ([82.229.218.57])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fg132-0003wS-8E
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 08:01:21 -0700
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

I wrote a framebuffer based on the virtual framebuffer (vfb.c) for an 
embedded device which has a TV output. Basically, I just had to modify 
the mmap, init, and exit functions so as to use my own memory addresses. 
I'm using a kernel 2.6.15.1 and the vfb in that tree.

This framebuffer works very well, I can make X run on top of it and see 
my X desktop on the TV. However, in console mode, it doesn't work. Well, 
it receives keyboard events as if I type 'root' <enter> 'halt', the 
embedded devices actually halts. So the problem is that there's no echo 
on the TV in console mode.

To redirect a tty to the framebuffer, I'm using the con2fb program 
(ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/con2fb.c.gz 
<ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/con2fb.c.gz>) which 
redirects a tty to a framebuffer. So, as I said, once redirected, I 
don't get any echo on the TV, althought key strokes are taken into account.

What is the problem? Is vfb unfit for console frame buffering? Should I 
consider taking vesafb as a basis? Is the con2fb wrong?  Should I 
compile vfb with some fonts? Notice that on my development station (the 
embedded device is on a PCI board), my VESA framebuffer works well, so 
my kernel is OK with console framebuffer options.

Any help would be very very appreciated.
Best regards,
Sylvain.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
