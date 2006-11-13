From: James Simmons <jsimmons@infradead.org>
Subject: Re: [patch 01/25] Patch for nvidia divide by
 zero error for 7600 pci-express card
Date: Mon, 13 Nov 2006 16:03:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611131603140.2366@pentafluge.infradead.org>
References: <200611020550.kA25oHED002282@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjeHT-0006S0-Rg for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 08:03:32 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GjeHQ-0002m6-0Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 08:03:31 -0800
In-Reply-To: <200611020550.kA25oHED002282@shell0.pdx.osdl.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org


Acked-by: James Simmons <jsimmons@infradead.org>

On Wed, 1 Nov 2006, akpm@osdl.org wrote:

> From: Wink Saville <wink@saville.com>
>
> The following patch resolves the divide by zero error I encountered on my system:
>
> 	http://marc.10east.com/?l=linux-fbdev-devel&m=116058257024413&w=2
>
> I accomplished this by merging what I thought was appropriate from:
>
> 	http://webcvs.freedesktop.org/xorg/driver/xf86-video-nv/src/
>
>
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
> drivers/video/nvidia/nv_hw.c    |   12 +++++++++---
> drivers/video/nvidia/nv_setup.c |   18 +++++++++++++++++-
> drivers/video/nvidia/nv_type.h  |    1 +
> drivers/video/nvidia/nvidia.c   |   24 ++++++++++++------------
> 4 files changed, 39 insertions(+), 16 deletions(-)
>
> diff -puN drivers/video/nvidia/nv_hw.c~patch-for-nvidia-divide-by-zero-error-for-7600 drivers/video/nvidia/nv_hw.c
> --- a/drivers/video/nvidia/nv_hw.c~patch-for-nvidia-divide-by-zero-error-for-7600
> +++ a/drivers/video/nvidia/nv_hw.c
> @@ -145,12 +145,18 @@ static void nvGetClocks(struct nvidia_pa
>
> 	if (par->Architecture >= NV_ARCH_40) {
> 		pll = NV_RD32(par->PMC, 0x4020);
> -		P = (pll >> 16) & 0x03;
> +		P = (pll >> 16) & 0x07;
> 		pll = NV_RD32(par->PMC, 0x4024);
> 		M = pll & 0xFF;
> 		N = (pll >> 8) & 0xFF;
> -		MB = (pll >> 16) & 0xFF;
> -		NB = (pll >> 24) & 0xFF;
> +		if(((par->Chipset & 0xfff0) == 0x0290) ||
> +		((par->Chipset & 0xfff0) == 0x0390)) {
> +			MB = 1;
> +			NB = 1;
> +		} else {
> +			MB = (pll >> 16) & 0xFF;
> +			NB = (pll >> 24) & 0xFF;
> +		}
> 		*MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;
>
> 		pll = NV_RD32(par->PMC, 0x4000);
> diff -puN drivers/video/nvidia/nv_setup.c~patch-for-nvidia-divide-by-zero-error-for-7600 drivers/video/nvidia/nv_setup.c
> --- a/drivers/video/nvidia/nv_setup.c~patch-for-nvidia-divide-by-zero-error-for-7600
> +++ a/drivers/video/nvidia/nv_setup.c
> @@ -359,6 +359,7 @@ int NVCommonSetup(struct fb_info *info)
> 	case 0x0186:
> 	case 0x0187:
> 	case 0x018D:
> +	case 0x0228:
> 	case 0x0286:
> 	case 0x028C:
> 	case 0x0316:
> @@ -382,6 +383,10 @@ int NVCommonSetup(struct fb_info *info)
> 	case 0x034C:
> 	case 0x0160:
> 	case 0x0166:
> +	case 0x0169:
> +	case 0x016B:
> +	case 0x016C:
> +	case 0x016D:
> 	case 0x00C8:
> 	case 0x00CC:
> 	case 0x0144:
> @@ -639,12 +644,23 @@ int NVCommonSetup(struct fb_info *info)
> 		par->fpHeight = NV_RD32(par->PRAMDAC, 0x0800) + 1;
> 		par->fpSyncs = NV_RD32(par->PRAMDAC, 0x0848) & 0x30000033;
>
> -		printk("Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
> +		printk("nvidiafb: Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
> 	}
>
> 	if (monA)
> 		info->monspecs = *monA;
>
> +	if (!par->FlatPanel || !par->twoHeads)
> +		par->FPDither = 0;
> +
> +	par->LVDS = 0;
> +	if (par->FlatPanel && par->twoHeads) {
> +		NV_WR32(par->PRAMDAC0, 0x08B0, 0x00010004);
> +		if (par->PRAMDAC0[0x08b4] & 1)
> +			par->LVDS = 1;
> +		printk("nvidiafb: Panel is %s\n", par->LVDS ? "LVDS" : "TMDS");
> +	}
> +
> 	kfree(edidA);
> 	kfree(edidB);
> done:
> diff -puN drivers/video/nvidia/nv_type.h~patch-for-nvidia-divide-by-zero-error-for-7600 drivers/video/nvidia/nv_type.h
> --- a/drivers/video/nvidia/nv_type.h~patch-for-nvidia-divide-by-zero-error-for-7600
> +++ a/drivers/video/nvidia/nv_type.h
> @@ -129,6 +129,7 @@ struct nvidia_par {
> 	int fpHeight;
> 	int PanelTweak;
> 	int paneltweak;
> +	int LVDS;
> 	int pm_state;
> 	u32 crtcSync_read;
> 	u32 fpSyncs;
> diff -puN drivers/video/nvidia/nvidia.c~patch-for-nvidia-divide-by-zero-error-for-7600 drivers/video/nvidia/nvidia.c
> --- a/drivers/video/nvidia/nvidia.c~patch-for-nvidia-divide-by-zero-error-for-7600
> +++ a/drivers/video/nvidia/nvidia.c
> @@ -1160,20 +1160,20 @@ static u32 __devinit nvidia_get_arch(str
> 	case 0x0340:		/* GeForceFX 5700 */
> 		arch = NV_ARCH_30;
> 		break;
> -	case 0x0040:
> -	case 0x00C0:
> -	case 0x0120:
> +	case 0x0040:		/* GeForce 6800 */
> +	case 0x00C0:		/* GeForce 6800 */
> +	case 0x0120:		/* GeForce 6800 */
> 	case 0x0130:
> -	case 0x0140:
> -	case 0x0160:
> -	case 0x01D0:
> -	case 0x0090:
> -	case 0x0210:
> -	case 0x0220:
> +	case 0x0140:		/* GeForce 6600 */
> +	case 0x0160:		/* GeForce 6200 */
> +	case 0x01D0:		/* GeForce 7200, 7300, 7400 */
> +	case 0x0090:		/* GeForce 7800 */
> +	case 0x0210:		/* GeForce 6800 */
> +	case 0x0220:		/* GeForce 6200 */
> 	case 0x0230:
> -	case 0x0240:
> -	case 0x0290:
> -	case 0x0390:
> +	case 0x0240:		/* GeForce 6100 */
> +	case 0x0290:		/* GeForce 7900 */
> +	case 0x0390:		/* GeForce 7600 */
> 		arch = NV_ARCH_40;
> 		break;
> 	case 0x0020:		/* TNT, TNT2 */
> _
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
