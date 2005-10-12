From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: Atari mach64 support (fwd)
Date: Wed, 12 Oct 2005 06:35:23 -0500
Message-ID: <15C49DB1-DE9D-45CC-95E6-F0071601B213@kilzer.net>
References: <Pine.LNX.4.62.0509221415250.18908@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v734)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPets-0002ri-Hj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Oct 2005 04:36:00 -0700
Received: from sccmmhc91.asp.att.net ([204.127.203.211])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EPets-0005sa-AZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Oct 2005 04:36:00 -0700
In-Reply-To: <Pine.LNX.4.62.0509221415250.18908@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Random code review (see below).

On Sep 22, 2005, at 7:15 AM, Geert Uytterhoeven wrote:

> ---------- Forwarded message ----------
> Date: Wed, 21 Sep 2005 22:07:01 +0100 (BST)
> From: James Simmons <jsimmons@infradead.org>
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linux Fbdev development list <linux-fbdev- 
> devel@lists.sourceforge.net>
> Subject: Atari mach64 support
>
>
> It's back. Please give this a try. It does compile but I can't test  
> it.
>
> diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/ 
> atyfb_base.c fbdev-2.6/drivers/video/aty/atyfb_base.c
> --- linus-2.6/drivers/video/aty/atyfb_base.c    2005-09-13  
> 14:01:40.000000000 -0700
> +++ fbdev-2.6/drivers/video/aty/atyfb_base.c    2005-09-21  
> 13:54:02.000000000 -0700
> [...]
> @@ -2276,18 +2268,20 @@
>              par->pll_limits.mclk = 63;
>      }
>
> -    if (M64_HAS(GTB_DSP)
> -        && (pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par))) {
> -        int diff1, diff2;
> -        diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
> -        diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
> -        if (diff1 < 0)
> -            diff1 = -diff1;
> -        if (diff2 < 0)
> -            diff2 = -diff2;
> -        if (diff2 < diff1) {
> -            par->ref_clk_per = 1000000000000ULL / 29498928;
> -            xtal = "29.498928";
> +    if (M64_HAS(GTB_DSP)) {
> +        u8 pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par);
> +        if (pll_ref_dev) {
> +            int diff1, diff2;
> +            diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
> +            diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
> +            if (diff1 < 0)
> +                diff1 = -diff1;
> +            if (diff2 < 0)
> +                diff2 = -diff2;
> +            if (diff2 < diff1) {
> +                par->ref_clk_per = 1000000000000ULL / 29498928;
> +                xtal = "29.498928";
> +            }
>          }
>      }
>  #endif /* CONFIG_FB_ATY_CT */

Should "if (pll_ref_dev) {" be "if (pll_ref_div) {" to keep the logic  
the same as the old code, or was this a bug fix?

Dave



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
