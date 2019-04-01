From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 12:12:35 +0000
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data support
Message-Id: <d0c51868-dc4a-9494-a7f6-287a4ff605e1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190225212603epcas3p42bd9d7e113c48af1fcb229ecccde2ebc@epcas3p4.samsung.com>
        <20190225212533.26432-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 02/25/2019 10:25 PM, Alexandre Belloni wrote:
> Make the driver OF only as since AVR32 has been removed from the kernel,
> there are only OF enabled platform using it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
