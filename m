From: jsimmons@pentafluge.infradead.org
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Wed, 16 Jun 2004 17:47:51 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406161743100.14901@pentafluge.infradead.org>
References: <200406160406.07060.adaplas@hotpop.com> <20040615221710.GA24416@havoc.gtf.org>
 <200406161044.45807.adaplas@hotpop.com> <200406161353.51195.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BadZt-0006CF-CO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 09:47:57 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BadZr-0005Oy-Ux
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 09:47:56 -0700
In-Reply-To: <200406161353.51195.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I believe I know why stty failed.  It's because fbcon_resize() inf fbcon.c uses
> fb_find_mode().  I have reservations with this method though.
> 
> 1. Since it uses a mode database, this will completely ignore drivers/hardware
> that can do scaling or can use the GTF.

The mode database is meant to deal with the lowest denominator hardware. 
It works in a large number of cases. I plan to expand that functionaly 
even more in the near future.
 
> 2. Secondly, stty works in a weird manner.  For example, fb is in 800x600.  I want
> to go to 1024x768.  In order to do that I issue 'stty cols 128 rows 48'.  This will fail
> because it will be processed in 2 steps:
> 
> 	1. set at 1024x592 (128x37) <-- fails
> 	2. set at 1024x768(128x48)
> 
> Of course, step 1 will fail since 1024x592 is not in the database.

This is a bug in stty. I sent the patch to the maintainer. We shoudl add 
that functionalty to fbset now. 

> Anyway, a workaround is to add a best-fit algorithm in fb_find_mode().  It will try to return
> modes that are bigger but closest to the given mode.  fb_find_mode will return 5 in this case.
> Note that it currently ignores refresh rates. So, it will now work this way:
> 
> 	1. set at 1024x592(128x37)
> 		fb_find_mode() return 1024x768
> 	2. set at 1024x768(128x48)
> 		fb_find_mode() return 1024x768 (success)
> 
> The algo is currently very simple, feel free to modify.

Nice. I will apply.
 
> Tony
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> 1. pass info->monspecs.modedb and info->monspecs.modedb_len to fb_find_mode()
> instead of NULL, 0 since its contents are specific to the attached display.  Anyway, if 
> info->monspecs.modedb == NULL, fb_find_mode() will use the default database.
> 
> 2. Added best fit algo to fb_find_mode().
> 
> 3. Use snprintf instead of sprintf. 
> 
> diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/console/fbcon.c linux-2.6.6-rc3-mm2-test/drivers/video/console/fbcon.c
> --- linux-2.6.6-rc3-mm2-orig/drivers/video/console/fbcon.c	2004-06-16 01:18:35.000000000 +0000
> +++ linux-2.6.6-rc3-mm2-test/drivers/video/console/fbcon.c	2004-06-16 05:31:06.594105304 +0000
> @@ -1512,9 +1512,10 @@
>  		if (!info->fbops->fb_set_par)
>  			return -EINVAL;
>  
> -		sprintf(mode, "%dx%d", var.xres, var.yres);
> -		err = fb_find_mode(&var, info, mode, NULL, 0, NULL,
> -					info->var.bits_per_pixel);
> +		snprintf(mode, 40, "%ix%i", var.xres, var.yres);
> +		err = fb_find_mode(&var, info, mode, info->monspecs.modedb, 
> +				   info->monspecs.modedb_len, NULL,
> +				   info->var.bits_per_pixel);
>  		if (!err || width > var.xres/fw || height > var.yres/fh)
>  			return -EINVAL;
>  		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
> diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/modedb.c linux-2.6.6-rc3-mm2-test/drivers/video/modedb.c
> --- linux-2.6.6-rc3-mm2-orig/drivers/video/modedb.c	2004-06-16 01:17:54.000000000 +0000
> +++ linux-2.6.6-rc3-mm2-test/drivers/video/modedb.c	2004-06-16 05:30:55.409805576 +0000
> @@ -490,7 +490,8 @@
>  	int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
>  	unsigned int xres = 0, yres = 0, bpp = default_bpp, refresh = 0;
>  	int yres_specified = 0;
> -
> +	u32 best = -1, diff = -1;
> +	
>  	for (i = namelen-1; i >= 0; i--) {
>  	    switch (name[i]) {
>  		case '@':
> @@ -529,8 +530,8 @@
>  	}
>  done:
>  	for (i = refresh_specified; i >= 0; i--) {
> -	    DPRINTK("Trying specified video mode%s\n",
> -		    i ? "" : " (ignoring refresh rate)");
> +	    DPRINTK("Trying specified video mode%s %ix%i\n",
> +		    i ? "" : " (ignoring refresh rate)", xres, yres);
>  	    for (j = 0; j < dbsize; j++)
>  		if ((name_matches(db[j], name, namelen) ||
>  		     (res_specified && res_matches(db[j], xres, yres))) &&
> @@ -538,6 +539,22 @@
>  		    !fb_try_mode(var, info, &db[j], bpp))
>  		    return 2-i;
>  	}
> +	DPRINTK("Trying best-fit modes\n");
> +	for (i = 0; i < dbsize; i++) {
> +	    if (xres <= db[i].xres && yres <= db[i].yres) {
> +		DPRINTK("Trying %ix%i\n", db[i].xres, db[i].yres);
> +		if (!fb_try_mode(var, info, &db[i], bpp)) {
> +		    if (diff > (db[i].xres - xres) + (db[i].yres - yres)) {
> +			diff = (db[i].xres - xres) + (db[i].yres - yres);
> +			best = i;
> +		    }
> +		}
> +	    }
> +	}
> +	if (best != -1) {
> +	    fb_try_mode(var, info, &db[best], bpp);
> +	    return 5;
> +	}
>      }
>  
>      DPRINTK("Trying default video mode\n");
> 
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
