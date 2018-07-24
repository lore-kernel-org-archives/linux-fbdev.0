From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:02:14 +0000
Subject: Re: [PATCH 3/4] video: fbdev: pxafb: handle errors from pxafb_init_fbinfo() correctly
Message-Id: <5236074.pdZxYZoplA@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180624153817.24387-1-daniel@zonque.org>
 <CGME20180624153830epcas4p37cb6f12227eff56e4f94722fcd240455@epcas4p3.samsung.com>
 <20180624153817.24387-3-daniel@zonque.org>
In-Reply-To: <20180624153817.24387-3-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Mack <daniel@zonque.org>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, robert.jarzmik@free.fr, dri-devel@lists.freedesktop.org

On Sunday, June 24, 2018 05:38:16 PM Daniel Mack wrote:
> pxafb_init_fbinfo() can not only report errors caused by failed
> allocations but also when the clock can't be found.
> 
> To fix this, return an error pointer instead of NULL in case of errors,
> and up-chain the result.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

