From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Geode patches for 2.6.17
Date: Fri, 23 Jun 2006 22:19:23 +0100
Message-ID: <1151097563.4549.90.camel@localhost.localdomain>
References: <20060623170058.GA12819@cosmic.amd.com>
	<449C4E3C.7000107@garzik.org> <20060623205637.GD13017@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtsoX-0007cU-GR for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 14:03:41 -0700
Received: from [81.2.110.250] (helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FtsoW-0004dm-J7
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 14:03:41 -0700
In-Reply-To: <20060623205637.GD13017@cosmic.amd.com>
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
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 14:56 -0600, ysgrifennodd Jordan Crouse:
> +config VGA_NOPROBE
> +       bool "Don't probe VGA at boot" if EMBEDDED
> +       default n
> +       help
> +         Saying Y here will cause the kernel to not probe VGA at boot time.
> +         This will break everything that depends on the probed screen
> +         data.  Say N here unless you are absolutely sure this is what you
> +         want.

GAK given all the ifdefs this causes wouldn't it be easier to just fix
the firmware 8)

> @@ -81,6 +96,7 @@ static void gx_set_mode(struct fb_info *
>  	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
>  	       par->dc_regs + DC_LINE_SIZE);
>  
> +
>  	/* Enable graphics and video data and unmask address lines. */
>  	dcfg |= DC_DCFG_GDEN | DC_DCFG_VDEN | DC_DCFG_A20M | DC_DCFG_A18M;
>  

Spurious blank line

Otherwise looks good


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
