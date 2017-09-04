From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 04 Sep 2017 13:58:01 +0000
Subject: Re: [PATCH] video: fbdev: sis: fix duplicated code for different branches
Message-Id: <2720040.oNlgtMK5vT@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170830131945epcas1p47e42f63ff4ae1d88501d4750ad455618@epcas1p4.samsung.com>
        <20170830131942.GA8173@embeddedgus>
In-Reply-To: <20170830131942.GA8173@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 30, 2017 08:19:42 AM Gustavo A. R. Silva wrote:
> Refactor code in order to avoid identical code for different branches.
> 
> This issue was detected with the help of Coccinelle.
> 
> Addresses-Coverity-ID: 1226761
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

