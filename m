From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 13:09:57 +0000
Subject: Re: [PATCH 04/11] fbdev: da8xx-fb: Drop unnecessary static
Message-Id: <2086929.avP79hnAKk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
        <CGME20170715203255epcas2p40497b7388043ff9ec488a3f0fbbdf63f@epcas2p4.samsung.com>
        <1500149266-32357-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1500149266-32357-5-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, July 15, 2017 10:07:39 PM Julia Lawall wrote:
> Drop static on a local variable, when the variable is initialized before
> any possible use.  Thus, the static has no benefit.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

