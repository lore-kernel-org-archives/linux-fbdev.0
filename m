From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Aug 2012 13:31:56 +0000
Subject: Re: [rtc-linux] [PATCHv4 8/9] arm: vt8500: gpio: Devicetree support for arch-vt8500
Message-Id: <CACRpkdYsUydqAfvYOKtQw9nBA4TpwF-=Af3kDUwwm6jbuiE68w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <1345707346-9035-9-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345707346-9035-9-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 23, 2012 at 9:35 AM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Converted the existing arch-vt8500 gpio to a platform_device.
> Added support for WM8505 and WM8650 GPIO controllers.
> Replaced existing readl/writel calls with _relaxed variants.
> Replaced existing unsigned variables with u32 to match register size.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
