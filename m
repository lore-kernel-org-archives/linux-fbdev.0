From: Wim Van Sebroeck <wim@iguana.be>
Date: Thu, 24 Mar 2011 08:29:40 +0000
Subject: Re: [trivial PATCH 1/2] treewide: Fix iomap resource size
Message-Id: <20110324082940.GB4968@infomag.iguana.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1300909445.git.joe@perches.com>
	<c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Joe,

> Convert off-by-1 r->end - r->start to resource_size(r)
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm/mach-ux500/mbox-db5500.c |    6 ++----
>  arch/mips/rb532/gpio.c            |    2 +-
>  drivers/video/msm/mddi.c          |    2 +-
>  drivers/watchdog/bcm63xx_wdt.c    |    2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

