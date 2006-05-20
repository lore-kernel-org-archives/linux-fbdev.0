From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Framebuffer output but no framebuffer console
 output
Date: Sat, 20 May 2006 08:39:44 +0800
Message-ID: <446E6550.1040106@gmail.com>
References: <4469E269.7090605@enst.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FhFVW-0002P4-IK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 May 2006 17:39:50 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FhFVV-0000JL-CX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 May 2006 17:39:50 -0700
Received: by py-out-1112.google.com with SMTP id z59so1066054pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 May 2006 17:39:47 -0700 (PDT)
In-Reply-To: <4469E269.7090605@enst.fr>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: garrigue@enst.fr

Sylvain Garrigues wrote:
> Hello,
> 
> I wrote a framebuffer based on the virtual framebuffer (vfb.c) for an
> embedded device which has a TV output. Basically, I just had to modify
> the mmap, init, and exit functions so as to use my own memory addresses.
> I'm using a kernel 2.6.15.1 and the vfb in that tree.
> 
> This framebuffer works very well, I can make X run on top of it and see
> my X desktop on the TV. However, in console mode, it doesn't work. Well,
> it receives keyboard events as if I type 'root' <enter> 'halt', the
> embedded devices actually halts. So the problem is that there's no echo
> on the TV in console mode.
> 
> To redirect a tty to the framebuffer, I'm using the con2fb program
> (ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/con2fb.c.gz
> <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/con2fb.c.gz>) which
> redirects a tty to a framebuffer. So, as I said, once redirected, I
> don't get any echo on the screen, althought key strokes are taken into
> account.
> 
> What is the problem? Is vfb unfit for console frame buffering? Should I
> consider taking vesafb as a basis? Is the con2fb wrong?  Should I
> compile vfb with some fonts? Notice that on my development station (the
> embedded device is on a PCI board), my VESA framebuffer works well, so
> my kernel is OK with console framebuffer options.

No vfb should work.

Can you post fbset -i, cat /proc/fb and dmesg after running con2fb.

Tony


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
