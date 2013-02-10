From: Olof Johansson <olof@lixom.net>
Date: Sun, 10 Feb 2013 00:47:40 +0000
Subject: Re: [PATCH 0/5] at91: atmel_lcdfb: regression fixes and cpu_is removal
Message-Id: <20130210004740.GH16278@quad.lixom.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1360340791.git.nicolas.ferre@atmel.com>
In-Reply-To: <cover.1360340791.git.nicolas.ferre@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 08, 2013 at 05:35:13PM +0100, Nicolas Ferre wrote:
> These patches fix a regression in 16-bpp support for older SOCs which use
> IBGR:555 rather than BGR:565 pixel layout. Use SOC-type to determine if the
> controller uses the intensity-bit and restore the old layout in that case.
> 
> The last patch is a removal of uses of cpu_is_xxxx() macros in atmel_lcdfb with
> a platform-device-id table and static configurations.
> 
> 
> Patches from Johan Hovold taken from:
> "[PATCH 0/3] atmel_lcdfb: fix 16-bpp regression"
> and
> "[PATCH v2 0/3] ARM: at91/avr32/atmel_lcdfb: remove cpu_is macros"
> patch series to form a clean patch series with my signature.
> 
> Arnd, Olof,
> as it seems that old fbdev drivers are not so much reviewed those days, can we
> take the decision to queue this material through arm-soc with other AT91
> drivers updates?

It would be beneficial to get an ack from Florian. Was he involved in the
review of the code that regressed 16-bpp support in the first place? When was
the regression introduced?


-Olof
