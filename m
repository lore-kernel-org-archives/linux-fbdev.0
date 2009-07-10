From: Kai Jiang <b18973@freescale.com>
Subject: Re: 
 [linux-fbdev-devel][PATCH]fb_pan_display:add x/yoffset check
Date: Fri, 10 Jul 2009 16:22:17 +0800
Message-ID: <4A56FA39.1040905@freescale.com>
References: <4A4839CB.8020801@freescale.com>	<20090629103936.GJ9980@sci.fi>	<4A4985C0.2040800@freescale.com>	<20090703153029.GK9980@sci.fi>
	<4A4E2DCE.1060706@gmx.de>	<4A5168D3.3050502@freescale.com>
	<4A520662.1030504@gmx.de> <4A52B63D.2050000@freescale.com>
	<4A52C886.4090605@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kai.Jiang@freescale.com>) id 1MPBga-00036v-Gm
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Jul 2009 08:42:28 +0000
Received: from az33egw02.freescale.net ([192.88.158.103])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPBgS-0004vI-MB
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Jul 2009 08:42:28 +0000
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6A8LsQk014823 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 10 Jul 2009 01:21:59 -0700 (MST)
Received: from zmy16exf40.fsl.freescale.net (zmy16exf40.ap.freescale.net
	[10.211.3.4])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n6A8Lqri028292
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 10 Jul 2009 03:21:53 -0500 (CDT)
In-Reply-To: <4A52C886.4090605@gmx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Florian Tobias Schandinat,

I think your solution is better. It seems much simple in your way:)

Best Regards,

Kai Jiang
>
> I only wanted to highlight, that as far as I can see the same behavior 
> you want to archive can be archived by changing the current code to:
>
> fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
> {
>        ......
>         if (err || !info->fbops->fb_pan_display ||
>             var->yoffset > info->var.yres_virtual - yres ||
>             var->xoffset > info->var.xres_virtual - info->var.xres)
>                 return -EINVAL;
>        ......
> }


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
