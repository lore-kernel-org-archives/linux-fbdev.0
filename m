From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 11:55:13 +0000
Subject: Re: [RFC 4/4] backlight: gpio_backlight: remove platform data support
Message-Id: <CACRpkdaUX8tga=Bt=gjKmxJJE=2_AqFrjow_AmyP_z=4MSK1hA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com> <20180315224202.96668-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20180315224202.96668-5-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On Thu, Mar 15, 2018 at 11:42 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Legacy boards can use static property sets/GPIO lookup tables to describe
> backlight connections, there is no need to maintain legacy platform data.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Good riddance, this is how all drivers should eventually end up
after full device property conversion I guess.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
