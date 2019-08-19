From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 19 Aug 2019 14:01:57 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: remove unnecessary comparison of unsigned integer with < 0
Message-Id: <7c233700-a6b2-54fd-e86d-a11583bb3ec3@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190722203403epcas2p32d13bdd6f29bed37696385baca909abf@epcas2p3.samsung.com>
 <20190722203358.GA29111@embeddedor>
In-Reply-To: <20190722203358.GA29111@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 7/22/19 10:33 PM, Gustavo A. R. Silva wrote:
> There is no need to compare *var->xoffset* or *var->yoffset* with < 0
> because such variables are of type unsigned, making it impossible to
> hold a negative value.
> 
> Fix this by removing such comparisons.
> 
> Addresses-Coverity-ID: 1451964 ("Unsigned compared against 0")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
