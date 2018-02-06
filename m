From: Ludovic Desroches <ludovic.desroches@microchip.com>
Date: Tue, 06 Feb 2018 07:37:29 +0000
Subject: Re: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO descriptors
Message-Id: <20180206073729.GI2580@rfolt0960.corp.atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
 <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
In-Reply-To: <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open
 list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 05, 2018 at 12:56:04PM +0100, Linus Walleij wrote:
> On Mon, Feb 5, 2018 at 9:47 AM, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> 
> > Use GPIO descriptors instead of relying on the old method.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Ah there it is :D
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> PS: why not move it all over to use DRI/DRM/KMS? It's becoming
> easier and easier.

It concerns old products, that's why it's not converted yet.

Regards

Ludovic

> 
> Yours,
> Linus Walleij
