From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 18 Sep 2019 16:45:18 +0000
Subject: RE: [PATHC v6] video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver
Message-Id: <PU1P153MB016905271897CA406021BF8DBF8E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190918060227.6834-1-weh@microsoft.com>
In-Reply-To: <20190918060227.6834-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "shc_work@mail.ru" <shc_work@mail.ru>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>, "info@metux.net" <info@metux.net>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephe

> From: Wei Hu <weh@microsoft.com>
> Sent: Tuesday, September 17, 2019 11:03 PM
> [...]
> ---
>     v6: Do not request host refresh when the VM guest screen is
>     closed or minimized.

Looks good to me. Thanks!

Reviewed-by: Dexuan Cui <decui@microsoft.com>
