From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 05 Feb 2018 11:56:04 +0000
Subject: Re: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO descriptors
Message-Id: <CACRpkdajUDNkODAGU=6SHRJz-q5-+sFRy7Qi9=QLc-HF1NEHWQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
In-Reply-To: <20180205084755.6011-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, Feb 5, 2018 at 9:47 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Ah there it is :D
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

PS: why not move it all over to use DRI/DRM/KMS? It's becoming
easier and easier.

Yours,
Linus Walleij
