From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Thu, 23 Mar 2017 11:48:52 +0000
Subject: Re: [PATCH] video: fbdev: pmag-aa-fb: remove incorrect __exit markups
Message-Id: <alpine.LFD.2.20.1703231148190.15502@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170301233114epcas2p3a6fa255ce9b90f7715ab7f7f89866ec9@epcas2p3.samsung.com> <20170301233109.GA8563@dtor-ws> <6090318.4Vxfg9eOhE@amdc3058>
In-Reply-To: <6090318.4Vxfg9eOhE@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 20 Mar 2017, Bartlomiej Zolnierkiewicz wrote:

> > Even if bus is not hot-pluggable, devices can be unbound from the
> > driver via sysfs, so we should not be using __exit annotations on
> > remove() methods. The only exception is drivers registered with
> > platform_driver_probe() which specifically disables sysfs bind/unbind
> > attributes.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Patch queued for 4.12, thanks.

 Thanks!

  Maciej
