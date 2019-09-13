From: Michael Kelley <mikelley@microsoft.com>
Date: Fri, 13 Sep 2019 23:31:42 +0000
Subject: RE: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <DM5PR21MB013732C4B83792CB49AC27A6D7B30@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190913060209.3604-1-weh@microsoft.com>
In-Reply-To: <20190913060209.3604-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Hai

From: Wei Hu <weh@microsoft.com> Sent: Thursday, September 12, 2019 11:03 PM
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
>     v4: Incorporated test and review feedback from Dexuan Cui
>     - Not disable interrupt while acquiring docopy_lock in
>       hvfb_update_work(). This avoids significant bootup delay in
>       large vCPU count VMs.
> 
>     v5: Completely remove the unnecessary docopy_lock after discussing
>     with Dexuan Cui.
> 

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
