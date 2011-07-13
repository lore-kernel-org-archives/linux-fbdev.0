From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:13:19 +0000
Subject: Re: [PATCH 5/5] drivers/video/msm/mdp.c: adjust error handling code
Message-Id: <20110713081318.GB13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309788705-22278-5-git-send-email-julia@diku.dk>
In-Reply-To: <1309788705-22278-5-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: David Brown <davidb@codeaurora.org>, kernel-janitors@vger.kernel.org, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 04, 2011 at 04:11:45PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Use the error handling code at the end of the function, rather than
> returning directly.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> identifier x;
> @@
> 
> kfree(x)
> 
> @@
> identifier r.x;
> expression E1!=0,E2,E3,E4;
> statement S;
> @@
> 
> (
> if (<+...x...+>) S
> |
> if (...) { ... when != kfree(x)
>                when != if (...) { ... kfree(x); ... }
>                when != x = E3
> * return E1;
> }
> ... when != x = E2
> if (...) { ... when != x = E4
>  kfree(x); ... return ...; }
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
Applied, thanks.

> I wonder if the error handling code at the end of the function should be
> calling clk_put as well?  In that case, having a separate label for this
> case would be useful.  Otherwise, one of error_request_irq and error_get_clk
> can be deleted
> 
The MSM implementation for it is simply a nop, so it's not going to
really matter one way or the other. In terms of general consistency it
might be worth implementing.

I expect that there are probably quite a few drivers that don't balance
out their clk_get()'s with clk_put()'s however, perhaps this is another
semantic patch candidate? At the very least it would be interesting to
see the statistics.
