From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: New API and X option UseFBDev
Date: Tue, 9 Sep 2003 12:08:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909100849.GA17091@iliana>
References: <XFMail.20030909074955.jim.hague@acm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wfR7-0006B5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 03:09:25 -0700
Received: from smtp7.wanadoo.fr ([193.252.22.29] helo=mwinf0203.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wfR5-0005be-1p
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 03:09:23 -0700
Content-Disposition: inline
In-Reply-To: <XFMail.20030909074955.jim.hague@acm.org>
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
Content-Transfer-Encoding: 7bit
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Sep 09, 2003 at 07:49:55AM +0100, Jim Hague wrote:
> I've been moving the pm2fb driver to the new API (currently working under
> 2.6.0-test3). I've got it working unaccelerated; still need to add acceleration
> and option handling and tidy up.
> 
> I have a problem when I try and run X (Debian 4.2.1-11 20030829103906). My
> config uses the Glint driver with UseFBDev true, and works fine on 2.4.22. It
> fails on 2.6 like this:
> 
> (II) Setting vga for screen 0.
> (**) GLINT(0): Depth 16, (--) framebuffer bpp 16
> (==) GLINT(0): RGB weight 565
> (==) GLINT(0): Default visual is TrueColor
> (==) GLINT(0): Using gamma correction (1.0, 1.0, 1.0)
> (**) GLINT(0): Option "UseFBDev" "true"
> (==) GLINT(0): Using HW cursor
> (II) Loading sub module "fbdevhw"
> (II) LoadModule: "fbdevhw"
> (II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
> (II) Module fbdevhw: vendor="The XFree86 Project"
>         compiled for 4.2.1.1, module version = 0.0.2
>         ABI class: XFree86 Video Driver, version 0.5
> (**) GLINT(0): Using Linux framebuffer device
> (--) GLINT(0): Chipset: "ti_pm2"
> (--) GLINT(0): Linear framebuffer at 0xCE800000
> (--) GLINT(0): MMIO registers at 0xCFFE0000
> (EE) GLINT(0): mmap mmio: Invalid argument
> (EE) GLINT(0): mmap mmio: Invalid argument
>  
> Fatal server error:
> Caught signal 11.  Server aborting
> 
> The lfb and MMIO addresses are correct. Now, I've new to this game and may have
> missed filling out a structure field somewhere. But I'm dammed if I can see
> what.
> 
> It's occurred to me that maybe this just doesn't work and I need an updated
> fbdevhw. Do I? Or should it really Just Work?

I think the glint driver is hardcoded to expect amiga hardware when
using pm2 with fbdev. Just don't use the usefbdev option, and everything
should be fine.

the glint driver does not really support usefbdev anyway, only as a
hacky workaround for amigas with cybervision/bvision graphic board.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
