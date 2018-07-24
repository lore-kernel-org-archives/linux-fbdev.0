From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:55:13 +0000
Subject: Re: [PATCH] fbdev: fbmem: mark expected switch fall-through
Message-Id: <11978135.HSW5xz1Y1h@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180709213648epcas1p23fcd55af87b2e5ad9a011b335b68873b@epcas1p2.samsung.com>
        <20180709213608.GA7584@embeddedor.com>
In-Reply-To: <20180709213608.GA7584@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, July 09, 2018 04:36:08 PM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

