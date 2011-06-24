From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 08:17:51 +0000
Subject: Re: [PATCH 18/37] Remove unneeded version.h includes from drivers/video/
Message-Id: <20110624081751.GG24184@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net> <alpine.LNX.2.00.1106240032560.17688@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1106240032560.17688@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesper Juhl <jj@chaosbits.net>
Cc: LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Richard Purdie <rpurdie@rpsys.net>, device-drivers-devel@blackfin.uclinux.org, linux-fbdev@vger.kernel.org

On Fri, Jun 24, 2011 at 12:35:17AM +0200, Jesper Juhl wrote:
> It was pointed out by 'make versioncheck' that some includes of
> linux/version.h are not needed in drivers/video/.
> This patch removes them.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  drivers/video/backlight/adp8860_bl.c |    1 -
>  drivers/video/backlight/adp8870_bl.c |    1 -
>  drivers/video/pxa3xx-gcu.c           |    2 --
>  drivers/video/xilinxfb.c             |    1 -
>  4 files changed, 0 insertions(+), 5 deletions(-)
> 
Applied, thanks.
