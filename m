From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 13:23:38 +0000
Subject: Re: [PATCH] video: bfin-lq035q1-fb: constify dev_pm_ops
Message-Id: <2523728.I0KZokJJZq@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170717011910epcas2p2df602abe7ade94050b8277cc186ce1e4@epcas2p2.samsung.com>
        <20170717011906.GA25787@embeddedgus>
In-Reply-To: <20170717011906.GA25787@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday, July 16, 2017 08:19:06 PM Gustavo A. R. Silva wrote:
> This dev_pm_ops structure is only stored in the pm field of a
> device_driver structure. This field is declared const, so
> dev_pm_ops structures that have this property can be declared
> as const also.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

