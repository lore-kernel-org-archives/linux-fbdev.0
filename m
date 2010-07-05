From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 05 Jul 2010 10:17:01 +0000
Subject: Re: [PATCH 4/6] fbdev: sh-mobile-lcdc: add a parameter to LCDC
Message-Id: <AANLkTimSeciEn9WF2NyC_IYKfpZQqQTBp-OuQ7J9p8Gz@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> HDMI support for the sh_mobile_lcdc framebuffer driver will require a 'struct
> fb_info *' pointer for its .display_on() callback. While at it fix kfr2r09
> framebuffer modular build.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Fine with me!
Acked-by: Magnus Damm <damm@opensource.se>
