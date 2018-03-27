From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 11:53:25 +0000
Subject: Re: [RFC 1/4] backlight: gpio_backlight: use generic device properties
Message-Id: <CACRpkdaUk-x3tFrrONhVT0opHgkWW_-yyz1165o22=tQ48uS5g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com> <20180315224202.96668-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20180315224202.96668-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On Thu, Mar 15, 2018 at 11:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Instead of using of_property_read_bool() switch to using
> device_property_read_bool() This will allow switching from platform data to
> device properties everywhere.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
