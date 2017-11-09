From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 15:59:03 +0000
Subject: Re: [PATCH] video: fbdev: aty: radeon_pm: mark expected switch fall-throughs
Message-Id: <2746455.xTs1Fgk4iN@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171106224006epcas3p4585900edc130ff7ca3a5bef657a237a3@epcas3p4.samsung.com>
 <20171106224001.GA1754@embeddedor.com>
In-Reply-To: <20171106224001.GA1754@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, November 06, 2017 04:40:01 PM Gustavo A. R. Silva wrote:
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

