From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Apr 2020 07:51:37 +0000
Subject: Re: [PATCH] omapfb/dss: fix comparison to bool warning
Message-Id: <fecc5f43-d1a2-f29f-da3a-79c297bff462@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200422071903.637-1-yanaijie@huawei.com>
In-Reply-To: <20200422071903.637-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Yan <yanaijie@huawei.com>, b.zolnierkie@samsung.com, afd@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On 22/04/2020 10:19, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:461:15-32: WARNING:
> Comparison to bool
> drivers/video/fbdev/omap2/omapfb/dss/dispc.c:891:5-35: WARNING:
> Comparison of 0/1 to bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 2 +-
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
