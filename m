From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 1/2]Freescale i.MX framebuffer driver
Date: Sat, 19 Mar 2005 04:47:31 +0800
Message-ID: <200503190447.34677.adaplas@hotpop.com>
References: <20050317173624.GA29286@metis.extern.pengutronix.de> <200503182214.30492.adaplas@hotpop.com> <20050318175407.GA25784@metis.extern.pengutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCONi-0001HE-DC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Mar 2005 12:47:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DCONg-0000QG-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Mar 2005 12:47:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id EB4E7FD8FC6
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Mar 2005 20:47:22 +0000 (UTC)
In-Reply-To: <20050318175407.GA25784@metis.extern.pengutronix.de>
Content-Disposition: inline
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
To: Sascha Hauer <s.hauer@pengutronix.de>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Saturday 19 March 2005 01:54, Sascha Hauer wrote:
> +/*
> + * imxfb_blank():
> + *	Blank the display by setting all palette values to zero.  Note, the
> + * 	12 and 16 bpp modes don't really use the palette, so this will not
> + *      blank the display in all modes.
> + */
> +static int imxfb_blank(int blank, struct fb_info *info)
> +{
> +	struct imxfb_info *fbi = info->par;
> +	int i;
> +
> +	pr_debug("imxfb_blank: blank=%d\n", blank);
> +
> +	switch (blank) {
> +	case FB_BLANK_POWERDOWN:
> +	case FB_BLANK_VSYNC_SUSPEND:
> +	case FB_BLANK_HSYNC_SUSPEND:
> +		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> +		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
> +			for (i = 0; i < fbi->palette_size; i++)
> +				imxfb_setpalettereg(i, 0, 0, 0, 0, info);
> +		imxfb_disable_controller(fbi);
> +		break;
> +
> +	case FB_BLANK_UNBLANK:
> +		if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
> +		    info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
> +			fb_set_cmap(&info->cmap, info);
> +		imxfb_enable_controller(fbi);
> +	}
> +	return 0;
> +}

FB_BLANK_NORMAL? It's actually important because FB_BLANK_UNBLANK and
FB_BLANK_NORMAL are commonly requested by fbcon. FB_BLANK_NORMAL is the case
where you need to blank the screen without turning off monitor sync signals,
ie, set cmap to all black but controller is still enabled.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
