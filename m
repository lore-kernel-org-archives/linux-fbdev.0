From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 17:23:23 +0000
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: fix display-timings lookup
Message-Id: <1971311.3PN1zRAlXO@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171113102758epcas2p433e3d361b93e9030ffe53a2c65268d38@epcas2p4.samsung.com>
 <20171113102719.9634-1-johan@kernel.org>
In-Reply-To: <20171113102719.9634-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <johan@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, dri-devel@lists.freedesktop.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On Monday, November 13, 2017 11:27:19 AM Johan Hovold wrote:
> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
> 
> To make things worse, the parent display node was also prematurely
> freed.
> 
> Note that the display and timings node references are never put after a
> successful dt-initialisation so the nodes would leak on later probe
> deferrals and on driver unbind.
> 
> Fixes: b985172b328a ("video: atmel_lcdfb: add device tree suport")
> Cc: stable <stable@vger.kernel.org>     # 3.13
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

