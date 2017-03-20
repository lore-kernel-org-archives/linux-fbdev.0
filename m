From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Mar 2017 16:49:16 +0000
Subject: Re: [PATCH] video: fbdev: pmag-aa-fb: remove incorrect __exit markups
Message-Id: <6090318.4Vxfg9eOhE@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170301233114epcas2p3a6fa255ce9b90f7715ab7f7f89866ec9@epcas2p3.samsung.com>
 <20170301233109.GA8563@dtor-ws>
In-Reply-To: <20170301233109.GA8563@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, March 01, 2017 03:31:09 PM Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, devices can be unbound from the
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

