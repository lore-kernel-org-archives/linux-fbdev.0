From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 26 Jul 2013 07:38:48 +0000
Subject: Re: [PATCH 2/2] video: imxfb: Add feature to setup PWM Contrast Control Register
Message-Id: <20130726073848.GF2737@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374395709-20898-1-git-send-email-shc_work@mail.ru>
 <1374395709-20898-2-git-send-email-shc_work@mail.ru>
 <20130725133824.GD16871@s25.your-server.de>
 <20130725212053.b39198a8610efc157a91b7be@mail.ru>
In-Reply-To: <20130725212053.b39198a8610efc157a91b7be@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 25, 2013 at 09:20:53PM +0400, Alexander Shiyan wrote:
> On Thu, 25 Jul 2013 15:38:56 +0200
> Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > Hi,
> > 
> > On Sun, Jul 21, 2013 at 12:35:09PM +0400, Alexander Shiyan wrote:
> > > This patch adds feature to setup PWM Contrast Control Register.
> > > This register is used to control the signal output at the contrast pin,
> > > which controls contrast of the LCD panel.
> > 
> > http://www.spinics.net/lists/linux-fbdev/msg10002.html
> 
> PWM? I can not understand how the PWM driver will be connected to the
> framebuffer driver. It is not backlight, this is contrast.
> Even if we imagine that the driver will be connected through phandle,
> then we will need to have at least 4! additional parameters in the framebuffer
> driver: freq source, frequency and active pulse period + phandle to PWM.
> Is it worth it, given that these parameters should not be adjustable?
> On my opinion, the only one additional parameter in framebuffer is enough.
> Thanks.

Why should the contrast of a display not be adjustable?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
