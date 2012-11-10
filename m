From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 10 Nov 2012 08:42:56 +0000
Subject: Re: [PATCH 02/10] arm: at91: move platfarm_data to include/linux/platform_data/atmel.h
Message-Id: <20121110084256.GB14761@core.coreip.homeip.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
 <1352287374-25176-2-git-send-email-plagnioj@jcrosoft.com>
 <509A5219.2080408@pengutronix.de>
In-Reply-To: <509A5219.2080408@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 07, 2012 at 01:20:41PM +0100, Marc Kleine-Budde wrote:
> On 11/07/2012 12:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: linux-ide@vger.kernel.org
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-mmc@vger.kernel.org
> > Cc: linux-can@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-pcmcia@lists.infradead.org
> > Cc: rtc-linux@googlegroups.com
> > Cc: spi-devel-general@lists.sourceforge.net
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> > HI all,
> > 
> > 	If it's ok with everyone this will go via at91
> > 	with the patch serie than clean up the include/mach
> 
> Fine with me.
> 
> > 	For preparation to switch to arm multiarch kernel
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> (for the CAN related changes)

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

for input piece.

-- 
Dmitry
