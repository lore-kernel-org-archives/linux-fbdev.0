From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 14/15] viafb: Determine type of 2D
 engine and store it in chip_info
Date: Sat, 23 May 2009 08:29:26 +0200
Message-ID: <20090523082926.dd1b6858.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-13-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-14-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7kdR-0002Td-RP
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:23:09 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7kdN-0002PU-M9 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:23:09 +0000
In-Reply-To: <1242851333-325-14-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 May 2009 04:28:52 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> This will help us for the upcoming support for 2D acceleration using
> the M1 engine.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/via/chip.h     |    8 ++++++++
>  drivers/video/via/hw.c       |   15 +++++++++++++++
>  drivers/video/via/viafbdev.c |    3 +--
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/via/chip.h b/drivers/video/via/chip.h
> index 03e90cf..7f4bf73 100644
> --- a/drivers/video/via/chip.h
> +++ b/drivers/video/via/chip.h
> @@ -122,10 +122,18 @@ struct lvds_chip_information {
>  	int i2c_port;
>  };
>  
> +/* The type of 2D engine */
> +enum via_2d_engine {
> +	VIA_2D_ENG_H2,
> +	VIA_2D_ENG_H5,
> +	VIA_2D_ENG_M1,
> +};
> +
>  struct chip_information {
>  	int gfx_chip_name;
>  	int gfx_chip_revision;
>  	int chip_on_slot;
> +	enum via_2d_engine twod_engine;
>  	struct tmds_chip_information tmds_chip_info;
>  	struct lvds_chip_information lvds_chip_info;
>  	struct lvds_chip_information lvds_chip_info2;
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index e06d6b7..e14b852 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -2092,6 +2092,21 @@ static void init_gfx_chip_info(struct pci_dev *pdev,
>  				CX700_REVISION_700;
>  		}
>  	}
> +
> +	/* Determine which 2D engine we have */
> +	switch (viaparinfo->chip_info->gfx_chip_name) {
> +	case UNICHROME_VX800:
> +	case UNICHROME_VX855:
> +		viaparinfo->chip_info->twod_engine = VIA_2D_ENG_M1;
> +		break;
> +	case UNICHROME_K8M890:
> +	case UNICHROME_P4M900:
> +		viaparinfo->chip_info->twod_engine = VIA_2D_ENG_H5;
> +		break;
> +	default:
> +		viaparinfo->chip_info->twod_engine = VIA_2D_ENG_H2;
> +		break;
> +	}
>  }
>  
>  static void init_tmds_chip_info(void)
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 859827b..d6a38ca 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -214,8 +214,7 @@ static int viafb_check_var(struct fb_var_screeninfo *var,
>  	if (!info->par)
>  		return -1;
>  	p_viafb_par = (struct viafb_par *)info->par;
> -	if (p_viafb_par->chip_info->gfx_chip_name == UNICHROME_VX800 ||
> -	    p_viafb_par->chip_info->gfx_chip_name == UNICHROME_VX855)
> +	if (p_viafb_par->chip_info->twod_engine == VIA_2D_ENG_M1)
>  		var->accel_flags = 0;
>  
>  	return 0;
> -- 
> 1.6.2.4
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

 	
----------------------------------------------------------------------
Sprawdz pogode na dzis!
Kliknij >>> http://link.interia.pl/f217d


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
