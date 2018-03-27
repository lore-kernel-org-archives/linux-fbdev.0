From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 11:59:04 +0000
Subject: Re: [RFC 0/4] gpio-backlight: remove platform data support
Message-Id: <CACRpkdbCqYF-OsmsHFrY5H56oS=FepVFJRqvCM7yj9Ox4E6SEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On Thu, Mar 15, 2018 at 11:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This series attempts to remove platform data support from gpio_blackllist
> driver

We really need a GPIO blacklist driver in the kernel, but for
not let's fix backlight :D :D

> and switch it over to generic device properties/GPIO tables.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Please note that I do not have the hardware (do we even care about
> ecovec24? I'd like to rip out platform data support from tsc2007 as
> well, but ecovec24 is using custom pendown handler and GPIOs have
> to be switched off from interrupt mode to GPIO and back in that
> pendown handler, which is all quite messy. If we do not care about
> this board I'd much rather removed that custom pendown).

I am also struggling with refactoring of board files, all over the place.
At least Arnd deleted the Blackfin stuff now, but the misc ARM board
and MIPS stuff still give me the creeps sometimes.

I guess if maintainers of the boards are not there to even ACK
patches we can propose patches to simply delete them.

Yours,
Linus Walleij
