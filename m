From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Mon, 10 Feb 2014 20:23:42 +0000
Subject: RE: [PATCH] hyperv_fb: Add screen refresh after pause/resume operation
Message-Id: <d2240dee850c458ca642f20cf3b9f858@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389658838-15765-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1389658838-15765-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Haiyang Zhang [mailto:haiyangz@microsoft.com]
> Sent: Monday, January 13, 2014 7:21 PM
> To: FlorianSchandinat@gmx.de; akpm@linux-foundation.org; linux-
> fbdev@vger.kernel.org
> Cc: Haiyang Zhang; KY Srinivasan; olaf@aepfle.de; jasowang@redhat.com;
> linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org
> Subject: [PATCH] hyperv_fb: Add screen refresh after pause/resume operation
> 
> This is necessary because after VM is pause/resumed, some portion of the
> screen may need refresh.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
This was submitted before the tree re-opened. Is it still being considered?

Thanks,
- Haiyang

