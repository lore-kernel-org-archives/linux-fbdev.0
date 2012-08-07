From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 07 Aug 2012 14:33:42 +0000
Subject: Re: [PATCH V4 0/2] arm: samsung: Move FIMD headers to include/video/
Message-Id: <20120807143342.GD18957@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1344342872-7904-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com

On Tue, Aug 07, 2012 at 06:04:30PM +0530, Leela Krishna Amudala wrote:
>  arch/arm/plat-samsung/include/plat/regs-fb-v4.h    |  159 --------------------
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |    2 +-
>  drivers/video/s3c-fb.c                             |    2 +-
>  .../plat/regs-fb.h => include/video/samsung_fimd.h |  152 +++++++++++++++++--

Isn't include/video for framebuffer drivers?  Isn't this more a DRM thing?
Wouldn't include/drm therefore be more appropriate?
