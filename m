From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Mar 2017 16:48:51 +0000
Subject: Re: [PATCH] video: fbdev: pmag-ba-fb: remove incorrect __exit markups
Message-Id: <10214243.2FlnkMB6Cj@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170225192451epcas2p45e9994c5b5618eb73560680041016efc@epcas2p4.samsung.com>
 <20170225192446.GA12502@dtor-ws>
In-Reply-To: <20170225192446.GA12502@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, February 25, 2017 11:24:46 AM Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, the devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch queued for 4.12, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

