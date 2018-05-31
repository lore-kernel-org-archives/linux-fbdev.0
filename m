From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 06:04:01 +0000
Subject: Re: [PATCH] fb_omap: add gpiolib dependency
Message-Id: <CAHp75VcP=RBpfqN1c0M4Uy639t80sCQ+YidweFmRZSt0J5i37g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180530214938.1073749-1-arnd@arndb.de>
In-Reply-To: <20180530214938.1073749-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Thu, May 31, 2018 at 12:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]

> Rather than fixing up each one individually, this just marks all of it
> as depending on GPIOLIB.

Hmm... But the OF stuff is not part of GPIOLIB.

-- 
With Best Regards,
Andy Shevchenko
