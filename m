From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 02 Jul 2019 09:14:11 +0000
Subject: Re: [PATCH RFT 0/4] backlight: gpio: simplify the driver
Message-Id: <20190702091411.vk3q5zhqh6xh7uyd@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190628100253.8385-1-brgl@bgdev.pl>
 <CACRpkdZqsgXoZcHv9z+7oVrf=i9WPSHG=93qhfA=0SkR0Mdfxg@mail.gmail.com>
In-Reply-To: <CACRpkdZqsgXoZcHv9z+7oVrf=i9WPSHG=93qhfA=0SkR0Mdfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lee Jones <lee.jones@linaro.org>

On Fri, Jun 28, 2019 at 11:15:10AM +0100, Linus Walleij wrote:
> On Fri, Jun 28, 2019 at 11:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > While working on my other series related to gpio-backlight[1] I noticed
> > that we could simplify the driver if we made the only user of platform
> > data use GPIO lookups and device properties. This series tries to do
> > that.
> >
> > The first patch sets up all the required structures in the board file,
> > the second modifies the backlight driver, the third and fourth remove
> > the leftovers.
> >
> > This series depends on the three first patches from [1].
> >
> > I don't have access to this HW but hopefully this works. Only compile
> > tested.
> 
> This series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Excellent work!

Ditto!

Hope to see this come around again alongside the other GPIO clean ups.


Daniel.
