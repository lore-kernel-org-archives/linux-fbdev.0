From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 25 Sep 2010 20:20:47 +0000
Subject: Re: [PATCH] viafb: don't setup TMDS if it doesn't exist
Message-Id: <4C9E599F.3040208@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100925195242.871699D401B@zog.reactivated.net>
In-Reply-To: <20100925195242.871699D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Daniel Drake schrieb:
> The OLPC XO-1.5 does not have this particular output interface.
> However, init_tmds_chip_info() always assumes it to be present,
> ignoring failure codes from viafb_tmds_trasmitter_identify().

This is true. I noticed it too while working on the identify logic. I will carry 
it on in my tree after I adjusted it (because I replaced the OK/FAIL madness by 
bool, it will change to "if (!viafb_tmds_trasmitter_identify())")

> This fixes lack of output on the XO-1.5 laptop display.

I wonder about that. Current linux-next with an unpatched viafb seems to work 
well on my XO 1.5. I guess I should notice a missing output?

> Thanks to Jon Nettleton for helping identify the problematic code.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks,

Florian Tobias Schandiant

> ---
>  drivers/video/via/hw.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index 7dcb4d5..a24d03f 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2125,7 +2125,8 @@ static void init_gfx_chip_info(int chip_type)
>  
>  static void init_tmds_chip_info(void)
>  {
> -	viafb_tmds_trasmitter_identify();
> +	if (viafb_tmds_trasmitter_identify() != OK)
> +		return;
>  
>  	if (INTERFACE_NONE = viaparinfo->chip_info->tmds_chip_info.
>  		output_interface) {

