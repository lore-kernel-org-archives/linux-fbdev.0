From: jurriaan <thunder7@xs4all.nl>
Subject: Re: no cursor on nvidiafb console in 2.6.14-rc1-mm1
Date: Wed, 21 Sep 2005 13:32:36 +0200
Message-ID: <20050921113236.GA4461@amd64.of.nowhere>
References: <20050919175116.GA8172@amd64.of.nowhere> <432F08C1.8010705@ppp0.net> <432F36B4.8030209@gmail.com> <432FBC93.4040007@ppp0.net> <432FE3E0.3020405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI2qo-000204-Ce
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 04:33:22 -0700
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EI2ql-0008Eh-CX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 04:33:22 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr1.xs4all.nl (8.13.3/8.13.3) with ESMTP id j8LBX7Na070322
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 21 Sep 2005 13:33:07 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <432FE3E0.3020405@gmail.com>
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
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

From: Antonino A. Daplas <adaplas@gmail.com>
Date: Tue, Sep 20, 2005 at 06:26:40PM +0800
> Heh, didn't realize that. drivers/video/nvidia/nvidia.c, actually.
> But just apply this patch instead, as a Kconfig change is also
> needed.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -650,6 +650,7 @@ config FB_NVIDIA
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_SOFT_CURSOR
>  	help
>  	  This driver supports graphics boards with the nVidia chips, TNT
>  	  and newer. For very old chipsets, such as the RIVA128, then use
> diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
> --- a/drivers/video/nvidia/nvidia.c
> +++ b/drivers/video/nvidia/nvidia.c
> @@ -893,7 +893,7 @@ static int nvidiafb_cursor(struct fb_inf
>  	int i, set = cursor->set;
>  	u16 fg, bg;
>  
> -	if (!hwcur || cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
> +	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
>  		return -ENXIO;
>  
>  	NVShowHideCursor(par, 0);
> @@ -1356,6 +1356,9 @@ static int __devinit nvidia_set_fbinfo(s
>  	info->pixmap.size = 8 * 1024;
>  	info->pixmap.flags = FB_PIXMAP_SYSTEM;
>  
> +	if (!hwcur)
> +	    info->fbops->fb_cursor = soft_cursor;
> +
>  	info->var.accel_flags = (!noaccel);
>  
>  	switch (par->Architecture) {
> 

Thanks, this fixes my problem.

Jurriaan
-- 
Pine - the outlook of Unix.
        Erik Hensema in xs4all.general
Debian (Unstable) GNU/Linux 2.6.14-rc1-mm1 5404 bogomips load 0.58


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
