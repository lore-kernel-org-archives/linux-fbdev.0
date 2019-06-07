From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 12:30:57 +0000
Subject: Re: [PATCH v2] video: fbdev: gbefb: add COMPILE_TEST support
Message-Id: <e1537488-d30e-3680-36d0-3a848b79f370@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <8bcfd5b8-347b-89e4-5faf-8569a3d00115@samsung.com>
        <CGME20190607123055eucas1p2c00e55a61972be0d0da49249a7e15e26@eucas1p2.samsung.com>
In-Reply-To: <8bcfd5b8-347b-89e4-5faf-8569a3d00115@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 5/21/19 1:51 PM, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to gbefb driver for better compile
> testing coverage.
> 
> While at it convert bogus udelay() calls to mdelay() (needed to
> build driver on ARM) and remove dead x86 specific code.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
