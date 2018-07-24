From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:58:35 +0000
Subject: Re: [PATCH] video: fbdev: mark expected switch fall-throughs
Message-Id: <61303804.R82jaX4LRF@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180709224217epcas1p397f731700d48b9b39d12afb5c41f8f06@epcas1p3.samsung.com>
 <20180709224145.GA15004@embeddedor.com>
In-Reply-To: <20180709224145.GA15004@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Monday, July 09, 2018 05:41:45 PM Gustavo A. R. Silva wrote:
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

