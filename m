From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 3/3] viafb: Add support for the
 VX855 chipset
Date: Tue, 19 May 2009 10:07:48 +0200
Message-ID: <20090519100748.e471ea6d.krzysztof.h1@poczta.fm>
References: <20090519035254.GZ19746@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6KGg-00007H-Fs
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 08:01:46 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6KGa-00078i-UU for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 08:01:46 +0000
In-Reply-To: <20090519035254.GZ19746@prithivi.gnumonks.org>
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

On Tue, 19 May 2009 11:52:54 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> This patch adds support for a new VIA integrated graphics chipset, the VX855.
> 
> Signed-off-by: HaraldWelte <HaraldWelte@viatech.com>
> ---

I believe it is correct. I have no chance to test. 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Only one small comment below.

Kind regards,
Krzysztof

>  drivers/video/via/chip.h     |    3 +
>  drivers/video/via/hw.c       |  203 ++++++++++++++++++++++++++++--------------
>  drivers/video/via/hw.h       |   14 +++
>  drivers/video/via/share.h    |   98 ++++++++++++++++++++
>  drivers/video/via/viafbdev.c |    7 +-
>  drivers/video/via/viamode.c  |   55 +++++++++++
>  drivers/video/via/viamode.h  |    2 +
>  7 files changed, 312 insertions(+), 70 deletions(-)
> 

(...)

> diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
> index 6ff38fa..22786a5 100644
> --- a/drivers/video/via/hw.h
> +++ b/drivers/video/via/hw.h
> @@ -335,6 +335,17 @@ is reserved, so it may have problem to set 1600x1200 on IGA2. */
>  /* location: {CR94,0,6} */
>  #define VX800_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     128
>  
> +/* For VT3409 */
> +#define VX855_IGA1_FIFO_MAX_DEPTH               400
> +#define VX855_IGA1_FIFO_THRESHOLD               320
> +#define VX855_IGA1_FIFO_HIGH_THRESHOLD          320

Are these two values above always the same? If so you can use
a single symbol. 

> +#define VX855_IGA1_DISPLAY_QUEUE_EXPIRE_NUM     160
> +
> +#define VX855_IGA2_FIFO_MAX_DEPTH               200
> +#define VX855_IGA2_FIFO_THRESHOLD               160
> +#define VX855_IGA2_FIFO_HIGH_THRESHOLD          160
> +#define VX855_IGA2_DISPLAY_QUEUE_EXPIRE_NUM     320
> +
>  #define IGA1_FIFO_DEPTH_SELECT_REG_NUM          1
>  #define IGA1_FIFO_THRESHOLD_REG_NUM             2
>  #define IGA1_FIFO_HIGH_THRESHOLD_REG_NUM        2
> @@ -716,6 +727,7 @@ struct pll_map {
>  	u32 cle266_pll;
>  	u32 k800_pll;
>  	u32 cx700_pll;
> +	u32 vx855_pll;
>  };
>  
>  struct rgbLUT {
> @@ -860,6 +872,8 @@ struct iga2_crtc_timing {
>  #define P4M900_FUNCTION3    0x3364
>  /* VT3353 chipset*/
>  #define VX800_FUNCTION3     0x3353
> +/* VT3409 chipset*/
> +#define VX855_FUNCTION3     0x3409
>  
>  #define NUM_TOTAL_PLL_TABLE ARRAY_SIZE(pll_value)
>  

----------------------------------------------------------------------
Audi kilka tysiecy zlotych taniej? Przebieraj wsrod tysiecy ogloszen!
Sprawdz: http://link.interia.pl/f216f


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
