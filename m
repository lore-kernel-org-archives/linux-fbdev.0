From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Wed, 3 Nov 2004 15:52:04 -0800
Message-ID: <20041103155204.7eb2daa3.akpm@osdl.org>
References: <200411021946.06302.adaplas@hotpop.com>
	<1099434421.20294.19.camel@gaston>
	<200411031030.11430.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPUrC-00020T-4t
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 15:48:02 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPUrB-0002DH-LW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 15:48:02 -0800
In-Reply-To: <200411031030.11430.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> Sigh, this patch uncovered a can of worms.  I tested different combinations,
> those with/without xxxfb_blank implementation, framebuffers in directcolor
> or truecolor, etc. I find that there is a problem unblanking if the hardware
> has no xxxfb_blank() implementation, and also that the generic fb_blank() in
> fbmem.c is problematic with drivers in directcolor or pseudocolor mode when
> called by an fb application such as X.
> 
> Display blanking is implemented in three ways:
> 
>     1. using the drivers blanking implementation - info->fbops->fb_blank()
>     2. clearing the screen with the console erase character - fbcon_blank()
>     3. setting the color map to all black - fb_blank()
> 
> The third method is problematic for these reasons:
> 
>     - Setting the colormap to all black will not work in truecolor mode
>     - In directcolor or pseudocolor, it will overwrite the fb application's
>       color map, producing wrong colors.
> 
> So, remove the generic implementation in fb_blank() and just return -EINVAL
> if there is no hardware implementation.  This will be only used by apps doing
> an FBIO_BLANK ioctl, and is a more robust approach.

This patch conflicts with Ben's "fbdev: workaround for broken X servers"
patch, which is in Linus's tree now.

So fb_blank() will now look like this:

int
fb_blank(struct fb_info *info, int blank)
{	
	int err = -EINVAL;
	
	/* Workaround for broken X servers */
	if (blank > VESA_POWERDOWN)
		blank = VESA_POWERDOWN;

	if (info->fbops->fb_blank)
 		err = info->fbops->fb_blank(blank, info);

	return err;
}



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
