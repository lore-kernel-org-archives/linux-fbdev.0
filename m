From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Fri, 14 Feb 2014 21:58:22 +0000
Subject: RE: [PATCH] hyperv_fb: Add screen refresh after pause/resume operation
Message-Id: <4e5f883e38f64a8d932d9047f787abaf@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389658838-15765-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1389658838-15765-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Haiyang Zhang [mailto:haiyangz@microsoft.com]
> Sent: Monday, January 13, 2014 7:21 PM
> To: FlorianSchandinat@gmx.de; akpm@linux-foundation.org; linux-
> fbdev@vger.kernel.org
> Cc: Haiyang Zhang; KY Srinivasan; olaf@aepfle.de; jasowang@redhat.com;
> linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org
> Subject: [PATCH] hyperv_fb: Add screen refresh after pause/resume
> operation
> 
> This is necessary because after VM is pause/resumed, some portion of the
> screen may need refresh.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
> ---

Hi Tomi and Andrew,

This patch has been submitted for a while. Do I need to re-submit it, or make
any changes?

Thanks,
- Haiyang

