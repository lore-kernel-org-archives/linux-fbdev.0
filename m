From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] fbdev: Add framebuffer and
 display update module support for pnx4008
Date: Fri, 30 Jun 2006 22:45:10 -0700
Message-ID: <20060630224510.4e4420fa.akpm@osdl.org>
References: <44A51257.10804@gmail.com> <20060630204304.7afe6c91.akpm@osdl.org>
	<44A601DB.5090807@gmail.com>
	<20060630221136.6ddc1ef3.akpm@osdl.org>
	<44A6058A.7000700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwYID-0006CH-Ru for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:45:21 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FwYIC-0006kd-IY
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:45:21 -0700
In-Reply-To: <44A6058A.7000700@gmail.com>
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

On Sat, 01 Jul 2006 13:18:02 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Andrew Morton wrote:
> > On Sat, 01 Jul 2006 13:02:19 +0800
> > "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> > 
> >> Andrew Morton wrote:
> >>> On Fri, 30 Jun 2006 20:00:23 +0800
> >>> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> >>>
> >>>> +static struct fb_var_screeninfo rgbfb_var __initdata = {
> >>> Is that right?  We later do
> >>>
> >>> +       info->var = rgbfb_var;
> >>>
> >>> but rgbfb_var is about to be unloaded from memory.  I suspect this'll crash
> >>> if the driver is statically linked into the kernel.
> >>>
> >> Should be okay, as the assignment is done during init only.
> > 
> > But we're setting info->var to point at memory which will be freed up by
> > free_initmem().
> > 
> > So if anyone _uses_ info->var after free_initmem() they'll reference random
> > memory or they'll oops.
> 
> No, rgbfb_var is not a pointer, so the contents or rgbfb_var are copied to
> info->var.
> 

oh, ok.  How unusual.  I assume things inside fb_var_screeninfo.var
get altered at runtime?


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
