From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Dec 2016 08:20:53 +0000
Subject: Re: [PATCH 4/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <CACRpkdb5Ojs+meXZKwJP3oDcYAnnrXgqBaXmCcgmgxJM=GkBGA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
 <20161221032717.13154-5-vz@mleia.com>
In-Reply-To: <20161221032717.13154-5-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 21, 2016 at 4:27 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> The change adds handling of "enable-gpios" property of panel-dpi device
> node used with an ARM CLCD controller, note that the property already has
> a description in display/panel/panel-dpi.txt documentation and it founds
> practical usage while describing some panel devices connected to other
> types of display controllers.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

So as you may have seen I already handle a RESET GPIO in the
Nomadik TPG110 panel subddriver in
drivers/video/fbdev/amba-clcd-nomadik.c

So is this all your panel needs?

I guess it is OK for simple panels.

Yours,
Linus Walleij
