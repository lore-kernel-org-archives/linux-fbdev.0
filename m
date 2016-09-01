From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 01 Sep 2016 11:44:35 +0000
Subject: Re: [PATCH] video: fbdev: exynos: Remove old non-working MIPI driver
Message-Id: <176ff6ca-5e1e-1d7e-bfb6-7e0b9da44179@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472729876-9218-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1472729876-9218-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/01/2016 01:37 PM, Krzysztof Kozlowski wrote:
> The old non-DRM Exynos MIPI driver does not support DeviceTree and
> requires board files.  Our platforms do not provide such so the driver
> is not usable since a long time ago.  All features provided by the
> driver (and associated s6e8ax0 panel driver) are already supported by
> newer DRM version so the old code can be removed.
> 
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Damn, I forgot to update top-fbdev Makefile. I will resend soon.

BR,
Krzysztof

