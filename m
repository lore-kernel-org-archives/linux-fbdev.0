From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 27 Feb 2019 20:14:30 +0000
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data support
Message-Id: <20190227201430.GA27395@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-arm-kernel@lists.infradead.org

Hi Alexandre.

Nice patch, good to clean out unused code.
On Mon, Feb 25, 2019 at 10:25:33PM +0100, Alexandre Belloni wrote:
> Make the driver OF only as since AVR32 has been removed from the kernel,
> there are only OF enabled platform using it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
