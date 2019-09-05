From: Michael Kelley <mikelley@microsoft.com>
Date: Thu, 05 Sep 2019 14:10:10 +0000
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <DM5PR21MB0137437661B0B2DDAC94DD5FD7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190905082816.3612-1-weh@microsoft.com>
In-Reply-To: <20190905082816.3612-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Hai

From: Wei Hu <weh@microsoft.com> Sent: Thursday, September 5, 2019 1:29 AM
> 
> Without deferred IO support, hyperv_fb driver informs the host to refresh
> the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
> is screen update or not. This patch supports deferred IO for screens in
> graphics mode and also enables the frame buffer on-demand refresh. The
> highest refresh rate is still set at 20Hz.
> 
> Currently Hyper-V only takes a physical address from guest as the starting
> address of frame buffer. This implies the guest must allocate contiguous
> physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
> accept address from MMIO region as frame buffer address. Due to these
> limitations on Hyper-V host, we keep a shadow copy of frame buffer
> in the guest. This means one more copy of the dirty rectangle inside
> guest when doing the on-demand refresh. This can be optimized in the
> future with help from host. For now the host performance gain from deferred
> IO outweighs the shadow copy impact in the guest.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporated review comments from Michael Kelley
>     - Increased dirty rectangle by one row in deferred IO case when sending
>     to Hyper-V.
>     - Corrected the dirty rectangle size in the text mode.
>     - Added more comments.
>     - Other minor code cleanups.
> 
>     v3: Incorporated more review comments
>     - Removed a few unnecessary variable tests
> 
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 216 +++++++++++++++++++++++++++++---
>  2 files changed, 197 insertions(+), 20 deletions(-)
> 

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
