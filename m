From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [announce 5/7] fbsplash - fbdev updates
Date: Tue, 8 Mar 2005 19:43:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0503081943060.15646@pentafluge.infradead.org>
References: <20050308021417.GF26249@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8kcL-0007Qn-QM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 11:43:45 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8kcK-0000vL-BG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 08 Mar 2005 11:43:45 -0800
In-Reply-To: <20050308021417.GF26249@spock.one.pl>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org


> diff -Nru a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> --- a/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
> +++ b/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
> @@ -16,6 +16,7 @@
>  #include <linux/tty.h>
>  #include <linux/fb.h>
>  #include <linux/slab.h>
> +#include "fbsplash.h"
>  
>  #include <asm/uaccess.h>
>  
> @@ -235,6 +236,10 @@
>  					      info))
>  			break;
>  	}
> +	fb_copy_cmap(cmap, &info->cmap);
> +	if (fbsplash_active(info, vc_cons[fg_console].d) &&
> +	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
> +		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
>  	return 0;
>  }
>  
> @@ -265,6 +270,9 @@
>  		if (transp)
>  			transp++;
>  	}
> +	if (fbsplash_active(info, vc_cons[fg_console].d) &&
> +	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
> +		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
>  	return 0;
>  }

That is just gross. You are putting console code back into the fbdev core. 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
