From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Tue, 12 Mar 2013 17:06:56 +0000
Subject: RE: [PATCH v3] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <df124c4a0bc945c9a667dc603b99951a@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362779141-9612-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1362779141-9612-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: KY Srinivasan <kys@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Haiyang Zhang
> Sent: Friday, March 08, 2013 4:46 PM
> To: FlorianSchandinat@gmx.de; linux-fbdev@vger.kernel.org
> Cc: Haiyang Zhang; KY Srinivasan; olaf@aepfle.de; jasowang@redhat.com;
> linux-kernel@vger.kernel.org; devel@linuxdriverproject.org
> Subject: [PATCH v3] video: Add Hyper-V Synthetic Video Frame Buffer
> Driver
> 
> This is the driver for the Hyper-V Synthetic Video, which supports
> screen
> resolution up to Full HD 1920x1080 on Windows Server 2012 host, and
> 1600x1200
> on  Windows Server 2008 R2 or earlier.
> It also solves the double mouse cursor issue of the emulated video mode.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
> 

Hi, Florian and Andrew,

So far, I have responded to all comments from the community, and made the
recommended updates. Do you have any additional comments on this driver?

Thanks,
- Haiyang

