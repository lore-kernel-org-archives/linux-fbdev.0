From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 28 Jun 2019 10:27:17 +0000
Subject: Re: [PATCH 2/3] video: fbdev: intelfb: return -ENOMEM on framebuffer_alloc() failure
Message-Id: <ff1c6cab-ecc0-10e2-b1ad-69d73368a754@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a659cb04-b16c-a3a0-30f4-b2f90b0d7196@samsung.com>
 <CGME20190628102719eucas1p2c601b723f6cefca76a9e9246d7f9447a@eucas1p2.samsung.com>
In-Reply-To: <a659cb04-b16c-a3a0-30f4-b2f90b0d7196@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maik Broemme <mbroemme@libmpq.org>


On 6/14/19 4:48 PM, Bartlomiej Zolnierkiewicz wrote:
> Fix error code from -ENODEV to -ENOMEM.
> 
> Cc: Maik Broemme <mbroemme@libmpq.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
