From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Fix get_std_timing
Date: Mon, 29 Sep 2003 23:09:01 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309292308550.12545-100000@phoenix.infradead.org>
References: <20030927172843.GA14088@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A46D3-0002Vi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 15:09:37 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A46D2-0003tA-GN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Sep 2003 15:09:36 -0700
In-Reply-To: <20030927172843.GA14088@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


Applied.


On Sat, 27 Sep 2003, Kronos wrote:

> Hi James,
> it seems  that you  lost the  following patch. It  fixes get_std_timing.
> Current code doesn't search the  VESA modedb. Instead it exits after the
> first  iteration  with  mode calculated  by  calc_mode_timings. Bug  was
> spotted by Antonino Daplas. Please apply:
> 
> ===== drivers/video/fbmon.c 1.9 vs edited =====
> --- 1.9/drivers/video/fbmon.c	Wed Jun  4 07:55:19 2003
> +++ edited/drivers/video/fbmon.c	Mon Sep 15 17:59:28 2003
> @@ -566,17 +566,19 @@
>  	}
>  	refresh = (block[1] & 0x3f) + 60;
>  
> +	/* First find standard mode from the table of VESA modes */
>  	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
>  		if (vesa_modes[i].xres == xres && 
>  		    vesa_modes[i].yres == yres &&
>  		    vesa_modes[i].refresh == refresh) {
>  			*mode = vesa_modes[i];
> -			break;
> -		} else {
> -			calc_mode_timings(xres, yres, refresh, mode);
> -			break;
> +			return 1;
>  		}
>  	}
> +
> +	/* If mode is not found in table, calculate it using GTF */
> +	calc_mode_timings(xres, yres, refresh, mode);
> +	
>  	return 1;
>  }
>  
> 
> Luca
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
