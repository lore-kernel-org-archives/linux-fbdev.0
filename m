From: Sasha Levin <sashal@kernel.org>
Date: Tue, 01 Oct 2019 18:45:26 +0000
Subject: Re: [PATCH v5] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <20191001184526.GE8171@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190913060209.3604-1-weh@microsoft.com>
In-Reply-To: <20190913060209.3604-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>
Cc: "info@metux.net" <info@metux.net>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, Stephen Hemminger <sthemmin@microsoft.com>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, Dexuan Cui <decui@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, Michael Kelley <mikelley@microsoft.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Sep 13, 2019 at 06:02:55AM +0000, Wei Hu wrote:
>Without deferred IO support, hyperv_fb driver informs the host to refresh
>the entire guest frame buffer at fixed rate, e.g. at 20Hz, no matter there
>is screen update or not. This patch supports deferred IO for screens in
>graphics mode and also enables the frame buffer on-demand refresh. The
>highest refresh rate is still set at 20Hz.
>
>Currently Hyper-V only takes a physical address from guest as the starting
>address of frame buffer. This implies the guest must allocate contiguous
>physical memory for frame buffer. In addition, Hyper-V Gen 2 VMs only
>accept address from MMIO region as frame buffer address. Due to these
>limitations on Hyper-V host, we keep a shadow copy of frame buffer
>in the guest. This means one more copy of the dirty rectangle inside
>guest when doing the on-demand refresh. This can be optimized in the
>future with help from host. For now the host performance gain from deferred
>IO outweighs the shadow copy impact in the guest.
>
>Signed-off-by: Wei Hu <weh@microsoft.com>

What tree is this based on? I can't get it to apply.

--
Thanks,
Sasha
