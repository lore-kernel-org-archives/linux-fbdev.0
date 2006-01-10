From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Tue, 10 Jan 2006 14:23:42 +1100
Message-ID: <1136863422.5069.5.camel@localhost.localdomain>
References: <1133944427.7168.70.camel@gaston> <43989DA3.8070602@gmail.com>
	 <1134080257.11760.19.camel@gaston> <4398B995.6000903@gmail.com>
	 <1134287682.6989.49.camel@gaston>
	 <1136773933.30123.100.camel@localhost.localdomain>
	 <20060108191311.00ab5dba.akpm@osdl.org> <43C30D2F.1060401@gmail.com>
	 <1136860505.5069.0.camel@localhost.localdomain>
	 <20060109190858.39592844.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwABc-0006l5-1n
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Jan 2006 19:28:40 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EwABb-0000Ir-BT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Jan 2006 19:28:40 -0800
In-Reply-To: <20060109190858.39592844.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@hotpop.com

On Mon, 2006-01-09 at 19:08 -0800, Andrew Morton wrote:

> I'm about to send this:

Looks good to me.

Thanks !

Ben.

> 
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Recent X "nv" driver was fixed for various issues with modern 6xxx and 7xxx
> cards.  This patch ports those fixes to nvidiafb.  This makes it work fine
> on the 6600 bundled with the newest G5 macs.  I've verified it still works
> on the 5200FX of the iMacG5.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: "Antonino A. Daplas" <adaplas@pol.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/nvidia/nv_hw.c    |   81 ++++++++++++++++++++++++------
>  drivers/video/nvidia/nv_setup.c |    3 -
>  drivers/video/nvidia/nvidia.c   |    9 ++-
>  3 files changed, 75 insertions(+), 18 deletions(-)
> 
> diff -puN drivers/video/nvidia/nv_hw.c~nvidiafb-fixes-for-new-g5 drivers/video/nvidia/nv_hw.c
> --- devel/drivers/video/nvidia/nv_hw.c~nvidiafb-fixes-for-new-g5	2006-01-09 17:52:33.000000000 -0800
> +++ devel-akpm/drivers/video/nvidia/nv_hw.c	2006-01-09 17:52:33.000000000 -0800
> @@ -848,7 +848,7 @@ void NVCalcStateExt(struct nvidia_par *p
>  		    int width,
>  		    int hDisplaySize, int height, int dotClock, int flags)
>  {
> -	int pixelDepth, VClk;
> +	int pixelDepth, VClk = 0;
>  	/*
>  	 * Save mode parameters.
>  	 */
> @@ -938,15 +938,24 @@ void NVLoadStateExt(struct nvidia_par *p
>  
>  	if (par->Architecture == NV_ARCH_04) {
>  		NV_WR32(par->PFB, 0x0200, state->config);
> -	} else if ((par->Chipset & 0xfff0) == 0x0090) {
> -		for (i = 0; i < 15; i++) {
> -			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
> -			NV_WR32(par->PFB, 0x0604 + (i * 0x10), par->FbMapSize - 1);
> -		}
> -	} else {
> +	} else if ((par->Architecture < NV_ARCH_40) ||
> +		   (par->Chipset & 0xfff0) == 0x0040) {
>  		for (i = 0; i < 8; i++) {
>  			NV_WR32(par->PFB, 0x0240 + (i * 0x10), 0);
> -			NV_WR32(par->PFB, 0x0244 + (i * 0x10), par->FbMapSize - 1);
> +			NV_WR32(par->PFB, 0x0244 + (i * 0x10),
> +				par->FbMapSize - 1);
> +		}
> +	} else {
> +		int regions = 12;
> +
> +		if (((par->Chipset & 0xfff0) == 0x0090) ||
> +		    ((par->Chipset & 0xfff0) == 0x01D0) ||
> +		    ((par->Chipset & 0xfff0) == 0x0290))
> +			regions = 15;
> +		for(i = 0; i < regions; i++) {
> +			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
> +			NV_WR32(par->PFB, 0x0604 + (i * 0x10),
> +				par->FbMapSize - 1);
>  		}
>  	}
>  
> @@ -1182,11 +1191,17 @@ void NVLoadStateExt(struct nvidia_par *p
>  			NV_WR32(par->PGRAPH, 0x0608, 0xFFFFFFFF);
>  		} else {
>  			if (par->Architecture >= NV_ARCH_40) {
> +				u32 tmp;
> +
>  				NV_WR32(par->PGRAPH, 0x0084, 0x401287c0);
>  				NV_WR32(par->PGRAPH, 0x008C, 0x60de8051);
>  				NV_WR32(par->PGRAPH, 0x0090, 0x00008000);
>  				NV_WR32(par->PGRAPH, 0x0610, 0x00be3c5f);
>  
> +				tmp = NV_RD32(par->REGS, 0x1540) & 0xff;
> +				for(i = 0; tmp && !(tmp & 1); tmp >>= 1, i++);
> +				NV_WR32(par->PGRAPH, 0x5000, i);
> +
>  				if ((par->Chipset & 0xfff0) == 0x0040) {
>  					NV_WR32(par->PGRAPH, 0x09b0,
>  						0x83280fff);
> @@ -1211,6 +1226,7 @@ void NVLoadStateExt(struct nvidia_par *p
>  						0xffff7fff);
>  					break;
>  				case 0x00C0:
> +				case 0x0120:
>  					NV_WR32(par->PGRAPH, 0x0828,
>  						0x007596ff);
>  					NV_WR32(par->PGRAPH, 0x082C,
> @@ -1245,6 +1261,7 @@ void NVLoadStateExt(struct nvidia_par *p
>  						0x00100000);
>  					break;
>  				case 0x0090:
> +				case 0x0290:
>  					NV_WR32(par->PRAMDAC, 0x0608,
>  						NV_RD32(par->PRAMDAC, 0x0608) |
>  						0x00100000);
> @@ -1310,14 +1327,44 @@ void NVLoadStateExt(struct nvidia_par *p
>  				}
>  			}
>  
> -			if ((par->Chipset & 0xfff0) == 0x0090) {
> -				for (i = 0; i < 60; i++)
> -					NV_WR32(par->PGRAPH, 0x0D00 + i,
> -						NV_RD32(par->PFB, 0x0600 + i));
> +			if ((par->Architecture < NV_ARCH_40) ||
> +			    ((par->Chipset & 0xfff0) == 0x0040)) {
> +				for (i = 0; i < 32; i++) {
> +					NV_WR32(par->PGRAPH, 0x0900 + i*4,
> +						NV_RD32(par->PFB, 0x0240 +i*4));
> +					NV_WR32(par->PGRAPH, 0x6900 + i*4,
> +						NV_RD32(par->PFB, 0x0240 +i*4));
> +				}
>  			} else {
> -				for (i = 0; i < 32; i++)
> -					NV_WR32(par->PGRAPH, 0x0900 + i,
> -						NV_RD32(par->PFB, 0x0240 + i));
> +				if (((par->Chipset & 0xfff0) == 0x0090) ||
> +				    ((par->Chipset & 0xfff0) == 0x01D0) ||
> +				    ((par->Chipset & 0xfff0) == 0x0290)) {
> +					for (i = 0; i < 60; i++) {
> +						NV_WR32(par->PGRAPH,
> +							0x0D00 + i*4,
> +							NV_RD32(par->PFB,
> +								0x0600 + i*4));
> +						NV_WR32(par->PGRAPH,
> +							0x6900 + i*4,
> +							NV_RD32(par->PFB,
> +								0x0600 + i*4));
> +					}
> +				} else {
> +					for (i = 0; i < 48; i++) {
> +						NV_WR32(par->PGRAPH,
> +							0x0900 + i*4,
> +							NV_RD32(par->PFB,
> +								0x0600 + i*4));
> +						if(((par->Chipset & 0xfff0)
> +						    != 0x0160) &&
> +						   ((par->Chipset & 0xfff0)
> +						    != 0x0220))
> +							NV_WR32(par->PGRAPH,
> +								0x6900 + i*4,
> +								NV_RD32(par->PFB,
> +									0x0600 + i*4));
> +					}
> +				}
>  			}
>  
>  			if (par->Architecture >= NV_ARCH_40) {
> @@ -1338,7 +1385,9 @@ void NVLoadStateExt(struct nvidia_par *p
>  					NV_WR32(par->PGRAPH, 0x0868,
>  						par->FbMapSize - 1);
>  				} else {
> -					if((par->Chipset & 0xfff0) == 0x0090) {
> +					if ((par->Chipset & 0xfff0) == 0x0090 ||
> +					    (par->Chipset & 0xfff0) == 0x01D0 ||
> +					    (par->Chipset & 0xfff0) == 0x0290) {
>  						NV_WR32(par->PGRAPH, 0x0DF0,
>  							NV_RD32(par->PFB, 0x0200));
>  						NV_WR32(par->PGRAPH, 0x0DF4,
> diff -puN drivers/video/nvidia/nvidia.c~nvidiafb-fixes-for-new-g5 drivers/video/nvidia/nvidia.c
> --- devel/drivers/video/nvidia/nvidia.c~nvidiafb-fixes-for-new-g5	2006-01-09 17:52:33.000000000 -0800
> +++ devel-akpm/drivers/video/nvidia/nvidia.c	2006-01-09 17:52:33.000000000 -0800
> @@ -1485,6 +1485,8 @@ static u32 __devinit nvidia_get_arch(str
>  	case 0x0210:
>  	case 0x0220:
>  	case 0x0230:
> +	case 0x0290:
> +	case 0x0390:
>  		arch = NV_ARCH_40;
>  		break;
>  	case 0x0020:		/* TNT, TNT2 */
> @@ -1581,10 +1583,15 @@ static int __devinit nvidiafb_probe(stru
>  	if (par->FbMapSize > 64 * 1024 * 1024)
>  		par->FbMapSize = 64 * 1024 * 1024;
>  
> -	par->FbUsableSize = par->FbMapSize - (128 * 1024);
> +	if(par->Architecture >= NV_ARCH_40)
> +  	        par->FbUsableSize = par->FbMapSize - (560 * 1024);
> +	else
> +		par->FbUsableSize = par->FbMapSize - (128 * 1024);
>  	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
>  	    16 * 1024;
>  	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
> +	par->CursorStart = par->FbUsableSize + (32 * 1024);
> +
>  	info->screen_base = ioremap(nvidiafb_fix.smem_start, par->FbMapSize);
>  	info->screen_size = par->FbUsableSize;
>  	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
> diff -puN drivers/video/nvidia/nv_setup.c~nvidiafb-fixes-for-new-g5 drivers/video/nvidia/nv_setup.c
> --- devel/drivers/video/nvidia/nv_setup.c~nvidiafb-fixes-for-new-g5	2006-01-09 17:52:33.000000000 -0800
> +++ devel-akpm/drivers/video/nvidia/nv_setup.c	2006-01-09 17:52:33.000000000 -0800
> @@ -285,7 +285,6 @@ static void nv10GetConfig(struct nvidia_
>  			par->CrystalFreqKHz = 27000;
>  	}
>  
> -	par->CursorStart = (par->RamAmountKBytes - 96) * 1024;
>  	par->CURSOR = NULL;	/* can't set this here */
>  	par->MinVClockFreqKHz = 12000;
>  	par->MaxVClockFreqKHz = par->twoStagePLL ? 400000 : 350000;
> @@ -382,6 +381,8 @@ void NVCommonSetup(struct fb_info *info)
>  	case 0x0146:
>  	case 0x0147:
>  	case 0x0148:
> +	case 0x0098:
> +	case 0x0099:
>  		mobile = 1;
>  		break;
>  	default:
> _



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
