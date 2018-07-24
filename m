From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:02:39 +0000
Subject: Re: [PATCH 4/4] video: fbdev: pxafb: Add support for lcd-supply regulator
Message-Id: <4635629.SV9Pax3P7h@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180624153817.24387-1-daniel@zonque.org>
 <CGME20180624153829epcas4p1effd3ba1319737e82f2a63cc1499fc85@epcas4p1.samsung.com>
 <20180624153817.24387-4-daniel@zonque.org>
In-Reply-To: <20180624153817.24387-4-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Mack <daniel@zonque.org>, dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, robert.jarzmik@free.fr

On Sunday, June 24, 2018 05:38:17 PM Daniel Mack wrote:
> Optionally obtain a lcd-supply regulator during probe and use it in
> __pxafb_lcd_power() to switch the power supply of LCD panels.
> 
> This helps boards booted from DT to control such voltages without
> callbacks.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

