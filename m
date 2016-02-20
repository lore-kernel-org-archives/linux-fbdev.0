From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Feb 2016 11:46:35 +0000
Subject: Re: [02/11] video: ARM CLCD: support DT signal inversion flags
Message-Id: <CACRpkdZjmP+XxZiM+o+AYaz4NMNJxzyQHD1no-fK4AG45CEuMQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-3-git-send-email-linus.walleij@linaro.org>
 <0cebf93a-ee0a-3637-3242-8aed266df091@broadcom.com>
 <CACRpkdbGCidu_3qbTYf7WSoAhafU4Z5W0jDs4CGtH5XwSf14aA@mail.gmail.com>
 <ac0739e5-4339-7fc5-1179-73af722beb08@broadcom.com>
In-Reply-To: <ac0739e5-4339-7fc5-1179-73af722beb08@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Feb 20, 2016 at 2:23 AM, Ray Jui <ray.jui@broadcom.com> wrote:

>> Do you have a system that needs this?
>
> Yah, we have a system (Cygnus) that can either use the HCLK, or an external
> clock generated from a PLL. To get certain pixel clock frequencies
> (depending on the LCD panel we use), we need to use the external clock
> source with the PLL configured to a particular VCO frequency.
>
> We have not enabled full LCD/video support on that platform in the mainline
> kernel, but we'll eventually get to it.

OK I hope to finish these patches soon so you have some nice stuff
to build upon. I guess it will need the same per-vendor plug-in that
I supplied for the ARMs and the Nomadik.

Yours,
Linus Walleij
