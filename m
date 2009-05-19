From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 2/3] viafb: Add missing break
 statement in switch
Date: Tue, 19 May 2009 10:01:39 +0200
Message-ID: <20090519100139.b003c82c.krzysztof.h1@poczta.fm>
References: <20090519035201.GY19746@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6KAq-00083p-B3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 07:55:44 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6KAm-0001d3-2o for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 07:55:44 +0000
In-Reply-To: <20090519035201.GY19746@prithivi.gnumonks.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

On Tue, 19 May 2009 11:52:01 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>


>  drivers/video/via/hw.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index fcd53ce..59ddf09 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2272,6 +2272,7 @@ int viafb_setmode(int vmode_index, int hor_res, int ver_res, int video_bpp,
>  
>  	case UNICHROME_CX700:
>  		viafb_write_regx(CX700_ModeXregs, NUM_TOTAL_CX700_ModeXregs);
> +		break;
>  
>  	case UNICHROME_VX800:
>  		viafb_write_regx(VX800_ModeXregs, NUM_TOTAL_VX800_ModeXregs);
> -- 
> 1.6.2.4
> 

 	
----------------------------------------------------------------------
Sprawdz pogode na dzis!
Kliknij >>> http://link.interia.pl/f217d


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
