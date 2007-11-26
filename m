From: Ben Dooks <ben@fluff.org.uk>
Subject: Re: [PATCH 6/7] sm501: Remove a misplaced
	x	character
Date: Mon, 26 Nov 2007 16:18:27 +0000
Message-ID: <20071126161827.GA31746@fluff.org.uk>
References: <1196020892591-git-send-email-syrjala@sci.fi>
	<11960208934176-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iwgff-0006AE-NI for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 08:18:55 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iwgfd-0007tE-4F
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 08:18:55 -0800
Content-Disposition: inline
In-Reply-To: <11960208934176-git-send-email-syrjala@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ben@simtec.co.uk, vince@simtec.co.uk, Ville Syrjala <syrjala@sci.fi>

On Sun, Nov 25, 2007 at 10:01:31PM +0200, Ville Syrjala wrote:
> sm501.c doesn't compile with debug enabled due to a misplaced x character.

Hi, thanks but a fix for this has already been submitted.
 
> Signed-off-by: Ville Syrjala <syrjala@sci.fi>
> ---
>  drivers/mfd/sm501.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index f31947c..4de8d46 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -137,7 +137,7 @@ static void sm501_dump_clk(struct sm501_devdata *sm)
>  
>  	dev_dbg(sm->dev, "PM0[%c]: "
>  		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
> -x		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
> +		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
>  		 (pmc & 3 ) == 0 ? '*' : '-',
>  		 fmt_freq(decode_div(pll2, pm0, 24, 1<<29, 31)),
>  		 fmt_freq(decode_div(pll2, pm0, 16, 1<<20, 15)),
> -- 
> 1.5.2.5
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
