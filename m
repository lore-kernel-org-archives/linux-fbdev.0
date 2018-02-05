From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 05 Feb 2018 11:54:29 +0000
Subject: Re: [PATCH] video: fbdev: convert to use GPIO descriptors
Message-Id: <CACRpkdbg1gXJigiPp9Ee0D0gyif-crsuBf9R93e9jJ-mjDkLug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180205082335.5727-1-ludovic.desroches@microchip.com>
In-Reply-To: <20180205082335.5727-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 5, 2018 at 9:23 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Use GPIO descriptors instead of relying on the old method.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

The subject should probably indicate that you're patching the
Atmel driver. Anyways:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for doing this.
Linus Walleij
