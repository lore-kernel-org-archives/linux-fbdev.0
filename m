From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 17 Oct 2017 13:07:33 +0000
Subject: Re: [PATCH] video: fbdev: pxa3xx_gcu: Use setup_timer and mod_timer
Message-Id: <2142686.yESyXOL10f@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170928201649epcas2p396ef5c6a3bca9eee120f9800c3a22b43@epcas2p3.samsung.com>
        <1506629791-11695-1-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1506629791-11695-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: gustavo@embeddedor.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On Friday, September 29, 2017 01:46:31 AM Himanshu Jha wrote:
> Use setup_timer and mod_timer API instead of structure assignments.
> 
> This is done using Coccinelle and semantic patch used
> for this as follows:
> 
> @@
> expression x,y,z,a,b;
> @@
> 
> -init_timer (&x);
> +setup_timer (&x, y, z);
> +mod_timer (&a, b);
> -x.function = y;
> -x.data = z;
> -x.expires = b;
> -add_timer(&a);
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

