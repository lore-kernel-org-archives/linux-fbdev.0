From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Fri, 14 Feb 2014 22:00:43 +0000
Subject: RE: [PATCH] hyperv_fb: Add support for Gen2 VM
Message-Id: <f7618c3978634ca08d6cdbd5de450d56@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1391880342-10081-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1391880342-10081-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Haiyang Zhang
> Sent: Saturday, February 8, 2014 12:26 PM
> To: FlorianSchandinat@gmx.de; akpm@linux-foundation.org; linux-
> fbdev@vger.kernel.org
> Cc: Haiyang Zhang; KY Srinivasan; olaf@aepfle.de; jasowang@redhat.com;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; driverdev-
> devel@linuxdriverproject.org
> Subject: [PATCH] hyperv_fb: Add support for Gen2 VM
> 
> This patch enables Hyper-V FB driver to run on Gen2 VM.
> 
> The Gen2 VM provides MMIO area for synthetic video from ACPI module,
> which is exported by vmbus. The generic video is provided by UEFI. PCI video
> in Gen1 is no longer available.
> 
> To support synthetic video on Hyper-V Gen2 VM, this patch updated code
> related to the changes above.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
> ---

Hi Tomi and Andrew,

This patch has been submitted for a while. Do I need to re-submit it, or 
make any changes?

Thanks,
- Haiyang

