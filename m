From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] atyfb: Replace busy loop with
	mdelay()
Date: Mon, 5 Mar 2007 15:53:18 -0800
Message-ID: <20070305155318.23fff053.akpm@linux-foundation.org>
References: <20070222002033.GA26166@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HON18-0000Kk-Bx for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:54:58 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HON15-0003jF-PU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:54:58 -0800
In-Reply-To: <20070222002033.GA26166@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, stable@kernel.org, adaplas@gmail.com, alex.kern@gmx.de

On Thu, 22 Feb 2007 02:20:33 +0200
Ville Syrj__l__ <syrjala@sci.fi> wrote:

> Replace a busy loop with mdelay() in atyfb clock setup code. This fixes
> boot hangs several people have experienced.
> 
> Signed-off-by: Ville Syrjala <syrjala@sci.fi>
> ---
> 
> This patch was already forwareded by James to some of you, but here it 
> is with the proper changelog, signed-off-by line, and a language fix in 
> the comment part. Also Cc:d stable@kernel.org as this seems like -stable 
> material to me.
> 
>  drivers/video/aty/mach64_ct.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6.20.1/drivers/video/aty/mach64_ct.c
> ===================================================================
> --- linux-2.6.20.1.orig/drivers/video/aty/mach64_ct.c
> +++ linux-2.6.20.1/drivers/video/aty/mach64_ct.c
> @@ -598,7 +598,6 @@ static void aty_resume_pll_ct(const stru
>  	struct atyfb_par *par = info->par;
>  
>  	if (par->mclk_per != par->xclk_per) {
> -		int i;
>  		/*
>  		* This disables the sclk, crashes the computer as reported:
>  		* aty_st_pll_ct(SPLL_CNTL2, 3, info);
> @@ -609,12 +608,10 @@ static void aty_resume_pll_ct(const stru
>  		aty_st_pll_ct(SCLK_FB_DIV, pll->ct.sclk_fb_div, par);
>  		aty_st_pll_ct(SPLL_CNTL2, pll->ct.spll_cntl2, par);
>  		/*
> -		 * The sclk has been started. However, I believe the first clock
> -		 * ticks it generates are not very stable. Hope this primitive loop
> -		 * helps for Rage Mobilities that sometimes crash when
> -		 * we switch to sclk. (Daniel Mantione, 13-05-2003)
> +		 * SCLK has been started. Wait for the PLL to lock. 5 ms
> +		 * should be enough according to mach64 programmer's guide.
>  		 */
> -		for (i=0;i<=0x1ffff;i++);
> +		mdelay(5);
>  	}
>  
>  	aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);
> 

A similar but different patch just got merged into mainline:


commit 8690ba446defe2e2b81803756c099d2943dfd5fd
Author: David Miller <davem@davemloft.net>
Date:   Mon Mar 5 01:35:36 2007 -0800

    [PATCH] video/aty/mach64_ct.c: fix bogus delay loop
    
    CT based mach64 cards were reported to hang on sparc64 boxes when
    compiled with gcc-4.1.x and later.
    
    Looking at this piece of code, it's no surprise.  A critical
    delay was implemented as an empty for() loop, and gcc 4.0.x
    and previous did not optimize it away, so we did get a delay.
    
    But gcc-4.1.x and later can optimize it away, and we get crashes.
    
    Use a real udelay() to fix this.  Fix verified on SunBlade100.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
index f3b487b..1fdcfdb 100644
--- a/drivers/video/aty/mach64_ct.c
+++ b/drivers/video/aty/mach64_ct.c
@@ -598,7 +598,6 @@ static void aty_resume_pll_ct(const stru
        struct atyfb_par *par = info->par;
 
        if (par->mclk_per != par->xclk_per) {
-               int i;
                /*
                * This disables the sclk, crashes the computer as reported:
                * aty_st_pll_ct(SPLL_CNTL2, 3, info);
@@ -614,7 +613,7 @@ static void aty_resume_pll_ct(const stru
                 * helps for Rage Mobilities that sometimes crash when
                 * we switch to sclk. (Daniel Mantione, 13-05-2003)
                 */
-               for (i=0;i<=0x1ffff;i++);
+               udelay(500);
        }
 
        aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);


hopefully that works OK for you.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
