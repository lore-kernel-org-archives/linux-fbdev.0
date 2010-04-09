From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 08/16] viafb: Do not probe for LVDS/TMDS on OLPC XO-1.5
Date: Fri, 09 Apr 2010 23:40:55 +0200
Message-ID: <4BBF9EE7.50707@gmx.de>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net> <1270746946-12467-9-git-send-email-corbet@lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-9-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Jonathan Corbet schrieb:
> From: Chris Ball <cjb@laptop.org>
> 
> The i2c transactions involved in detecting LVDS (9 seconds) and TMDS
> (16 seconds) add an extra 25 seconds to viafb load time on the XO-1.5.

I don't like the idea of OLPC specific code. Isn't there any way to 
speed this up in general?
There is not yet even an option for OLPC_XO_1_5 (in contrast to 
CONFIG_OLPC) in mainline. Is such a thing planned?
I can't really see anything that would speak for accepting this patch 
now in current mainline, sorry.


Thanks,

Florian Tobias Schandinat

> [jc: minor merge conflict fixed]
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/video/via/hw.c  |    4 ++++
>  drivers/video/via/lcd.c |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index 7be462e..47ba09a 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2054,6 +2054,10 @@ static void init_gfx_chip_info(struct pci_dev *pdev,
>  
>  static void init_tmds_chip_info(void)
>  {
> +#ifdef CONFIG_OLPC_XO_1_5
> +	if (machine_is_olpc())
> +		return;
> +#endif
>  	viafb_tmds_trasmitter_identify();
>  
>  	if (INTERFACE_NONE == viaparinfo->chip_info->tmds_chip_info.
> diff --git a/drivers/video/via/lcd.c b/drivers/video/via/lcd.c
> index e0e2310..37a9746 100644
> --- a/drivers/video/via/lcd.c
> +++ b/drivers/video/via/lcd.c
> @@ -208,6 +208,10 @@ static bool lvds_identify_integratedlvds(void)
>  
>  int viafb_lvds_trasmitter_identify(void)
>  {
> +#ifdef CONFIG_OLPC_XO_1_5
> +	if (machine_is_olpc())
> +		return FAIL;
> +#endif
>  	viaparinfo->shared->i2c_stuff.i2c_port = I2CPORTINDEX;
>  	if (viafb_lvds_identify_vt1636()) {
>  		viaparinfo->chip_info->lvds_chip_info.i2c_port = I2CPORTINDEX;
