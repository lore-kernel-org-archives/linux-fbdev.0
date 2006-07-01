From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] fbdev: Add framebuffer and
 display update module support for pnx4008
Date: Fri, 30 Jun 2006 22:11:36 -0700
Message-ID: <20060630221136.6ddc1ef3.akpm@osdl.org>
References: <44A51257.10804@gmail.com> <20060630204304.7afe6c91.akpm@osdl.org>
	<44A601DB.5090807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwXlc-0003Wu-Gh for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:11:40 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FwXlc-0006PI-4k
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:11:40 -0700
In-Reply-To: <44A601DB.5090807@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, gtolstolytkin@ru.mvista.com

On Sat, 01 Jul 2006 13:02:19 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Andrew Morton wrote:
> > On Fri, 30 Jun 2006 20:00:23 +0800
> > "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> > 
> >> +static struct fb_var_screeninfo rgbfb_var __initdata = {
> > 
> > Is that right?  We later do
> > 
> > +       info->var = rgbfb_var;
> > 
> > but rgbfb_var is about to be unloaded from memory.  I suspect this'll crash
> > if the driver is statically linked into the kernel.
> > 
> 
> Should be okay, as the assignment is done during init only.

But we're setting info->var to point at memory which will be freed up by
free_initmem().

So if anyone _uses_ info->var after free_initmem() they'll reference random
memory or they'll oops.

Looking at, say, drivers/video/vfb.c:vfb_probe(), I see

	info->var = vfb_default;

vfb_default is __init and `info' has a lifetime beyond the execution of
this function.  It looks wrong.

Bear in mind that the __init and __initdata segments do not get unloaded if
the code is compiled as a module (yet).  So the problems only become
apparent when the driver is linked into vmlinux.

Also, we'll now get section mismatch warnings from the kbuild tools.  But
they won't help us in this case because vfb_probe() is __init.

> But it should be __devinitdata, not __initdata (or vice versa).  

Yes, the driver seems a bit confused about that also.


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
