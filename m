From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 18:05:40 +0000
Subject: Re: [PATCH -next] video: fbdev: Fix potential NULL pointer dereference
Message-Id: <67c9cb52-277f-66d9-21bc-2537c795ae51@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190130101714epcas4p18e107a05ba592985d2e63d69a445029a@epcas4p1.samsung.com>
 <20190130101625.20048-1-yuehaibing@huawei.com>
In-Reply-To: <20190130101625.20048-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, keescook@chromium.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 01/30/2019 11:16 AM, YueHaibing wrote:
> There is a potential NULL pointer dereference in case
> fb_create_modedb() fails and returns NULL.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
