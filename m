From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 16:03:33 +0000
Subject: Re: [PATCH] video: fbdev: sis_main: mark expected switch fall-throughs
Message-Id: <3369040.8Dtr7j8mMC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171108171106epcas3p2bfe517009929d49cd56d3def262d1bca@epcas3p2.samsung.com>
 <20171108171059.GA7495@embeddedor.com>
In-Reply-To: <20171108171059.GA7495@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday, November 08, 2017 11:10:59 AM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 115025
> Addresses-Coverity-ID: 115026
> Addresses-Coverity-ID: 115027
> Addresses-Coverity-ID: 115028
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

