From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives
 black screen
Date: Thu, 14 Apr 2005 19:13:23 +0200
Message-ID: <20050414191323.10d7d435.khali@linux-fr.org>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	<20050324203118.345c6004.akpm@osdl.org>
	<200504141351.42971.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DM7u3-0008Gl-QG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 10:13:19 -0700
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104] helo=mallaury.noc.nerim.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DM7u3-00063m-BC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 10:13:19 -0700
In-Reply-To: <200504141351.42971.adaplas@hotpop.com>
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
To: "Antonino A. Daplas" <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>

Hi Tony,

> This patch will always limit the amount of video RAM to remap at
> 128 MiB.

I don't much get the idea. What are you trying to prevent?

128 MiB seems a rather low limit. Graphics adapters with 256 MiB, 512
MiB or even 640 MiB exist, and I see little reason why it would stop
increasing.

> diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
> --- a/drivers/video/nvidia/nvidia.c	2005-04-14 13:33:38 +08:00
> +++ b/drivers/video/nvidia/nvidia.c	2005-04-14 13:44:15 +08:00
> @@ -1510,7 +1510,11 @@
>  	par->FbMapSize = par->RamAmountKBytes * 1024;
>  
>  	if (vram && vram * 1024 * 1024 < par->FbMapSize)
> -	    par->FbMapSize = vram * 1024 * 1024;
> +		par->FbMapSize = vram * 1024 * 1024;

You're fixing an indentation error you just introduced in the previous
patch. Maybe you could fix the first patch instead?

Thanks,
-- 
Jean Delvare


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
