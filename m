From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Fix get_std_timing
Date: Thu, 4 Mar 2004 22:31:16 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403042230440.13104-100000@phoenix.infradead.org>
References: <20040304221536.GA18093@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Az1ax-0000ST-I0
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Mar 2004 14:45:35 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Az1NA-00057l-AW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Mar 2004 14:31:20 -0800
In-Reply-To: <20040304221536.GA18093@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


Ug. I applied the fix. I will be pushing the new monitor code as soon as 
ben sends me bugs he found as well.


On Thu, 4 Mar 2004, Kronos wrote:

> Hi,
> I thought that this was fixed ages ago, but I see that the bug it's still
> here. To recap, get_std_timing will exit after the first iteration on
> VESA modedb. Fix is trivial, James please apply:
> 
> --- linux-2.6/drivers/video/fbmon.c.orig	Thu Mar  4 23:11:43 2004
> +++ linux-2.6/drivers/video/fbmon.c	Thu Mar  4 23:12:46 2004
> @@ -572,12 +572,12 @@
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
> +	calc_mode_timings(xres, yres, refresh, mode);
> +
>  	return 1;
>  }
>  
> 
> Luca
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
