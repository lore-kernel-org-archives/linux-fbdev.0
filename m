From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 22 Nov 2012 15:17:28 +0000
Subject: Re: [PATCH 2/2] OMAP: DSS: panel-n8x0: register the DSS driver after SPI probe
Message-Id: <20121122151728.GA13187@blackmetal.musicnaut.iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi>
 <1353527332-5216-2-git-send-email-aaro.koskinen@iki.fi>
 <50AE1831.90308@ti.com>
In-Reply-To: <50AE1831.90308@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Nov 22, 2012 at 02:18:57PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 2012-11-21 21:48, Aaro Koskinen wrote:
> > Register the DSS driver after SPI probe. This simplifies the
> > initialization. This is similar to what is being done e.g.
> > in panel-acx565akm.
> 
> Is this a fix? The description sounds like it's just a cleanup.

Yes, it's a cleanup. I should have sent it separately, sorry.

> The first patch in the series needs to be sent for the next -rc, right?

Yes, it's fixing regression. There are OMAP2 boards with display
configured (e.g. board-apollon) and those will see probe failing.

A.
