From: Antonino Daplas <adaplas@pol.net>
Subject: Re: request_mem_region problem ...
Date: 02 Nov 2002 06:22:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036189404.621.7.camel@daplas>
References: <20021030130016.GA1573@iliana> <1036024416.644.23.camel@daplas>
	<20021031081007.GB617@iliana> <1036062270.638.25.camel@daplas>
	<20021101105242.GA702@iliana> <1036179467.572.42.camel@daplas>
	<20021101195207.GA931@iliana> <1036181217.572.5.camel@daplas>
	<20021101202246.GA2026@iliana> <1036182603.622.8.camel@daplas> 
	<20021101212353.GA2163@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187kDF-000704-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 14:24:21 -0800
In-Reply-To: <20021101212353.GA2163@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-11-02 at 05:23, Sven Luther wrote:
> On Sat, Nov 02, 2002 at 04:29:32AM +0800, Antonino Daplas wrote:
> > It's an irritating bug in the new kernel configurator.  Try make -k if
> > it complains about the QT libs.
> 
> Ok, it worked some, but debian's kernel-package command did not like it,
> o well, i will have to build it by hand until it is fixed.
> 
> BTW, in the old pm3fb driver (which i did not write) a pm3fb_info
> structure contained the driver local stuff. I suppose, from reading
> skeletonfb.c, that it is now in the xxx_par (that is pm3fb_par) that
> private driver info will be found ?
> 
Yes, you can stuff all your driver private data in info->par. (fb_info
can be stuffed in pci_device during pci_probe, I think).
  
> Also, since pm3fb_par is placed in include/video/pm3.h, this data will
> be shared with other entities, like the drm module for example.
> 
Yes, but it's optional.

> ...
> 
> Mmm, it does not compile :((((
> 
> drivers/video/console/vgacon.c: In function `vgacon_adjust_height':
> drivers/video/console/vgacon.c:890: `i' undeclared (first use in this function)
> drivers/video/console/vgacon.c:890: (Each undeclared identifier is reported only once
> drivers/video/console/vgacon.c:890: for each function it appears in.)
> make[3]: *** [drivers/video/console/vgacon.o] Erreur 1
> 
> O, well, i think i will wait another week or so that the new stuff has
> stabilized a bit more before continuing working on this.
> 
Just declare 'int i' and it should work.

Tony




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
