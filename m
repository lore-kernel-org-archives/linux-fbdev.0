From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 21 Sep 2010 17:00:10 +0000
Subject: Re: [PATCH] viafb: Use proper register for bgcolor when doing MONO
Message-Id: <4C98E49A.5010200@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921154604.2E3059D401B@zog.reactivated.net>
In-Reply-To: <20100921154604.2E3059D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Drake schrieb:
> From: Jon Nettleton <jon.nettleton@gmail.com>
> 
> Seemingly random colours were being painted as the background on the
> terminal. This fixes MONO color blits.

Not really. For color blits it looks like we're doing the right thing here, at 
least it works on VX800 as I'd expect it (when I change the bg_color to red I 
get the characters with a red background, after applying your patch I get them 
with a black background). To me it looks like we should set this register for 
fillrect operations (as after your patch is applied I get a red backround for 
the space where no characters are).


Thanks,

Florian Tobias Schandinat

> 
> Fixes http://dev.laptop.org/ticket/9323
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> 
> ---
>  drivers/video/via/accel.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
> index e44893e..8d9819c 100644
> --- a/drivers/video/via/accel.c
> +++ b/drivers/video/via/accel.c
> @@ -287,7 +287,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
>  		writel(fg_color, engine + 0x4C);
>  
>  	if (op = VIA_BITBLT_MONO)
> -		writel(bg_color, engine + 0x50);
> +		writel(bg_color, engine + 0x58);
>  
>  	if (op = VIA_BITBLT_FILL)
>  		ge_cmd |= fill_rop << 24 | 0x00002000 | 0x00000001;

