From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 07 Aug 2012 15:05:30 +0000
Subject: Re: [PATCH V4 0/2] arm: samsung: Move FIMD headers to	include/video/
Message-Id: <50212EBA.5000600@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
 <20120807143342.GD18957@n2100.arm.linux.org.uk>
In-Reply-To: <20120807143342.GD18957@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com

On 08/07/2012 04:33 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 07, 2012 at 06:04:30PM +0530, Leela Krishna Amudala wrote:
>>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159 --------------------
>>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
>>  drivers/video/s3c-fb.c                             |    2 +-
>>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  152 +++++++++++++++++--
> 
> Isn't include/video for framebuffer drivers?  Isn't this more a DRM thing?
> Wouldn't include/drm therefore be more appropriate?

Those headers are now used by both: framebuffer and Exynos DRM
driver. And probably the framebuffer driver has more users, as it
also covers older FIMD devices than those found on exynos4/5 SoCs.

So include/video seems equally right (or wrong) as include/drm.

There have been some efforts, or at least requirements raised, to
create some common low level API for framebuffer and DRM drivers,
but nothing has clarified yet AFAICS.
