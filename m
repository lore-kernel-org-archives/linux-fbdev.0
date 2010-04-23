From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Apr 2010 20:56:46 +0000
Subject: Re: [PATCH 09/11] viafb: Do not probe for LVDS/TMDS on OLPC XO-1.5
Message-Id: <4BD2098E.70601@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271614873-5952-1-git-send-email-corbet@lwn.net> <1271614873-5952-10-git-send-email-corbet@lwn.net>
In-Reply-To: <1271614873-5952-10-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Hi Jon,

I fear your analysis that the #ifdef's are not needed is wrong. At least 
with this patch applied I get:

drivers/video/via/hw.c: In function 'init_tmds_chip_info':
drivers/video/via/hw.c:2043: error: implicit declaration of function 
'machine_is_olpc'

drivers/video/via/lcd.c: In function 'viafb_lvds_trasmitter_identify':
drivers/video/via/lcd.c:179: error: implicit declaration of function 
'machine_is_olpc'

So I vote for taking the original patch but in the series that also adds 
the relevant config option.


Thanks,

Florian Tobias Schandinat

Jonathan Corbet schrieb:
> From: Chris Ball <cjb@laptop.org>
> 
> The i2c transactions involved in detecting LVDS (9 seconds) and TMDS
> (16 seconds) add an extra 25 seconds to viafb load time on the XO-1.5.
> 
> [jc: minor merge conflict fixed, removed ifdefs]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/video/via/hw.c  |    7 +++++++
>  drivers/video/via/lcd.c |    7 +++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index 4aff0f7..bd5d5ce 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2037,6 +2037,13 @@ static void init_gfx_chip_info(struct pci_dev *pdev,
>  
>  static void init_tmds_chip_info(void)
>  {
> +	/*
> +	 * OLPC XO 1.5 systems are wired differently, so there is
> +	 * no point in them here.
> +	 */
> +	if (machine_is_olpc())
> +		return;
> +
>  	viafb_tmds_trasmitter_identify();
>  
>  	if (INTERFACE_NONE = viaparinfo->chip_info->tmds_chip_info.
> diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
> index b656e59..ce3f4b6 100644
> --- a/drivers/video/via/lcd.c
> +++ b/drivers/video/via/lcd.c
> @@ -173,6 +173,13 @@ static bool lvds_identify_integratedlvds(void)
>  
>  int viafb_lvds_trasmitter_identify(void)
>  {
> +	/*
> +	 * OLPC XO 1.5 systems are wired differently, so there is
> +	 * no point in them here.
> +	 */
> +	if (machine_is_olpc())
> +		return FAIL;
> +
>  	viaparinfo->shared->i2c_stuff.i2c_port = I2CPORTINDEX;
>  	if (viafb_lvds_identify_vt1636()) {
>  		viaparinfo->chip_info->lvds_chip_info.i2c_port = I2CPORTINDEX;

