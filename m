From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Mar 2017 16:49:05 +0000
Subject: Re: [PATCH] video: fbdev: pmagb-b-fb: remove incorrect __exit markups
Message-Id: <2044127.WH4JhakCYy@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170225192516epcas3p427ddaefb80f7721a40db8fa3312bef16@epcas3p4.samsung.com>
 <20170225192511.GA12591@dtor-ws>
In-Reply-To: <20170225192511.GA12591@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, February 25, 2017 11:25:11 AM Dmitry Torokhov wrote:
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

