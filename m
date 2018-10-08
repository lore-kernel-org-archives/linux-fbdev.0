From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 08 Oct 2018 10:54:49 +0000
Subject: Re: [PATCH] video: fbdev: arcfb: mark expected switch fall-through
Message-Id: <20181008105451eucas1p27537ee0fa142488ae041844919037224~bnMqMgl581320913209eucas1p2d@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181003115120epcas1p1e0cbeaddf6b54f8db18abf2b089e13e0@epcas1p1.samsung.com>
 <20181003115044.GA10786@embeddedor.com>
In-Reply-To: <20181003115044.GA10786@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>


On 10/03/2018 01:50 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 115017 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
