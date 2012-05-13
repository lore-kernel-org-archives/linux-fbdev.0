From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 20:59:37 +0000
Subject: Re: [PATCH 0/5] video: exynos mipi dsi: fixes some bugs and clean the codes
Message-Id: <4FB020B9.9090909@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FAA0578.3060509@samsung.com>
In-Reply-To: <4FAA0578.3060509@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/09/2012 05:49 AM, Donghwa Lee wrote:
> These patches fix some bugs and clean the codes for exynos mipi dsi
> display driver.
> 
> video: exynos mipi dsi: enable interrupt again after sw reset
> 	:I resend this patch by including this series.
> 	You can refer the original patch by below url.
> 	http://marc.info/?l=linux-fbdev&m3610770329570&w=2
> video: exynos mipi dsi: Do not use deprecated suspend/resume callbacks
> video: exynos mipi dsi: Avoid races in probe()
> video: exynos mipi dsi: Properly interpret the interrupt source flags
> video: exynos mipi dsi: support reverse panel type

I applied this series (2-5 as I applied the original of 1 earlier).


Thanks,

Florian Tobias Schandinat

> 
> Thank you,
> Donghwa Lee
> 

