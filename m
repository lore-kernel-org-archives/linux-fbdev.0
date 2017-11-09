From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:57:10 +0000
Subject: Re: [PATCH] video: fbdev: sm501fb: mark expected switch fall-through in sm501fb_blank_crt
Message-Id: <12199764.4hoRUuLNjp@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171106223123epcas2p205e8d945db1baf075e0e1005e308e81d@epcas2p2.samsung.com>
 <20171106223117.GA705@embeddedor.com>
In-Reply-To: <20171106223117.GA705@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, November 06, 2017 04:31:18 PM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

