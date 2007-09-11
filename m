From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Intel FB pixel clock calculation fix
Date: Mon, 10 Sep 2007 22:52:21 -0700
Message-ID: <20070910225221.f0eaf22c.akpm@linux-foundation.org>
References: <m3ir6il3wl.fsf@maximus.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUyfl-0000s9-AU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 22:52:29 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IUyfl-0000yJ-21
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Sep 2007 22:52:29 -0700
In-Reply-To: <m3ir6il3wl.fsf@maximus.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, sylvain.meyer@worldonline.fr, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 10 Sep 2007 21:24:42 +0200 Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Intel framebuffer mis-calculated pixel clocks.
> 
> Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
> 
> --- a/drivers/video/intelfb/intelfbhw.c
> +++ b/drivers/video/intelfb/intelfbhw.c
> @@ -924,10 +920,10 @@ calc_pll_params(int index, int clock, u32 *retm1, u32 *retm2, u32 *retn, u32 *re
>  			if (m > pll->max_m)
>  				m = pll->max_m - 1;
>  			for (testm = m - 1; testm <= m; testm++) {
> -				f_out = calc_vclock3(index, m, n, p);
> +				f_out = calc_vclock3(index, testm, n, p);
>  				if (splitm(index, testm, &m1, &m2)) {
> -					WRN_MSG("cannot split m = %d\n", m);
> -					n++;
> +					WRN_MSG("cannot split m = %d\n",
> +						testm);
>  					continue;
>  				}
>  				if (clock > f_out)

and... what are the consequences of this miscalculation?  I need to know
such things so that I can decide whether a change is needed in 2.6.23.  And
2.6.22.

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
