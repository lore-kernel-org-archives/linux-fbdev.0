From: Wink Saville <wink@saville.com>
Subject: Re: [patch 01/25] Patch for nvidia divide by
 zero error for 7600 pci-express card
Date: Tue, 07 Nov 2006 08:16:42 -0800
Message-ID: <4550B16A.2010201@saville.com>
References: <200611020550.kA25oHED002282@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhTd3-0007cz-TP for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 08:16:50 -0800
Received: from [70.91.206.233] (helo=saville.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GhTd1-0001lU-8V
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 08:16:49 -0800
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
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net

akpm@osdl.org wrote:
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
>  drivers/video/nvidia/nv_hw.c    |   12 +++++++++---
>  drivers/video/nvidia/nv_setup.c |   18 +++++++++++++++++-
>  drivers/video/nvidia/nv_type.h  |    1 +
>  drivers/video/nvidia/nvidia.c   |   24 ++++++++++++------------
>  4 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff -puN drivers/video/nvidia/nv_hw.c~patch-for-nvidia-divide-by-zero-error-for-7600 drivers/video/nvidia/nv_hw.c
> --- a/drivers/video/nvidia/nv_hw.c~patch-for-nvidia-divide-by-zero-error-for-7600
> +++ a/drivers/video/nvidia/nv_hw.c
> @@ -145,12 +145,18 @@ static void nvGetClocks(struct nvidia_pa
>  

<snip>

> +	case 0x0290:		/* GeForce 7900 */
> +	case 0x0390:		/* GeForce 7600 */
>  		arch = NV_ARCH_40;
>  		break;
>  	case 0x0020:		/* TNT, TNT2 */
> _
> 

After some trials and tribulations and help from Andrew Morton and Junio Hamano (thanks), I was able to successfully test this patch as sourced from v2.6.19-rc4-mm2. There is still the problem that the framebuffer console doesn't work, the display is blank until X comes up, but at least it doesn't crash.

I'm suspecting a configuration problem, my configuration file can be seen in my post from 10/14/2006 as seen here; http://marc.10east.com/?l=linux-fbdev-devel&m=116085527611531&w=2, if anyone has some suggestions I'll be glad to investigate further.

Regards,

Wink Saville


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
