From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 18 Nov 2010 11:30:30 +0000
Subject: Re: [PATCH 0/3] S5PV210: added MIPI-DSI Driver.
Message-Id: <1290079830.9872.1.camel@tubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CE50338.8060000@samsung.com>
In-Reply-To: <4CE50338.8060000@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Thu, 2010-11-18 at 19:43 +0900, ext daeinki wrote:
> Hello all,
> 
> This patch is a MIPI-DSI driver for S5PV210.
> 
> PATCH 1/3: add a structure for CPU interface to linux/fb.h
> - RGB or CPU interfaces could be used as display mode but framebuffer
> framework doesn't consider CPU interface so I added this structure
> because fb_cpumode structure could be used commonly.
> 
> PATCH 2/3: add parameters for CPU interface to plat-samsung/fb.h
> - MIPI-DSI driver would use s3c-fb driver so I added some parameters
> because MIPI-DSI driver supports CPU interface also.
> 
> PATCH 3/3: add MIPI-DSI driver for S5PV210.

You have three patches, all with the same subject, and no description.

Please check Documentation/SubmittingPatches.

 Tomi


