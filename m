From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 07 Jun 2019 11:52:00 +0000
Subject: Re: [PATCH] video: fbdev: mxsfb: Remove driver
Message-Id: <80891dd1-370b-6070-011b-b7ac822e17de@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520130612.2214-1-festevam@gmail.com>
 <CGME20190520134337epcas3p369f0aaf00906512fa716324896822679@epcas3p3.samsung.com>
 <1bb6a117-dcf4-8842-0c3a-c3e015b2f0a9@denx.de>
In-Reply-To: <1bb6a117-dcf4-8842-0c3a-c3e015b2f0a9@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, linux-fbdev@vger.kernel.org


On 5/20/19 3:43 PM, Marek Vasut wrote:
> On 5/20/19 3:06 PM, Fabio Estevam wrote:
>> There is a DRM version of the mxsfb driver for quite some time
>> at drivers/gpu/drm/mxsfb/, so there is no need to keep maintaining
>> the fbdev version any longer.
>>
>> Remove the fbdev mxsfb driver in favour of the DRM version.
>>
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Acked-by: Marek Vasut <marex@denx.de>

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
