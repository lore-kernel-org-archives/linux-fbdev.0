From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2/2] [VIDEO FRAMEBUFFER] Blackfin
	BF54x framebuffer	device driver for a SHARP LQ043T1DG01 TFT LCD
Date: Sat, 29 Sep 2007 08:09:30 +0800
Message-ID: <1191024570.5273.4.camel@daplas>
References: <1190778219.18676.13.camel@roc-laptop>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbPtt-00029E-GW for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 17:09:41 -0700
Received: from an-out-0708.google.com ([209.85.132.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbPts-0001Ir-1G
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 17:09:40 -0700
Received: by an-out-0708.google.com with SMTP id b38so601948ana
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 17:09:37 -0700 (PDT)
In-Reply-To: <1190778219.18676.13.camel@roc-laptop>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: bryan.wu@analog.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>, Michael Hennerich <michael.hennerich@analog.com>

On Wed, 2007-09-26 at 11:43 +0800, Bryan Wu wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> Date: Wed, 26 Sep 2007 11:33:01 +0800
> Subject: [PATCH 2/2] [VIDEO FRAMEBUFFER] Blackfin BF54x framebuffer device driver for a SHARP LQ043T1DG01 TFT LCD
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> ---
>  drivers/video/Kconfig                         |    9 +
>  drivers/video/Makefile                        |    1 +
>  drivers/video/bf54x-lq043.c                   |  786 +++++++++++++++++++++++++
>  include/asm-blackfin/mach-bf548/bf54x-lq043.h |   30 +
>  4 files changed, 826 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/bf54x-lq043.c
>  create mode 100644 include/asm-blackfin/mach-bf548/bf54x-lq043.h
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 5216c11..41fae00 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -535,6 +535,15 @@ config FB_VGA16
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vga16fb.
>  
> +config FB_BF54X_LQ043
> +	tristate "SHARP LQ043 TFT LCD (BF548 EZKIT)"
> +	depends on FB && (BF54x)
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	help
> +	 This is the framebuffer device driver for a SHARP LQ043T1DG01 TFT LCD
> +
>  config FB_STI
>  	tristate "HP STI frame buffer device support"
>  	depends on FB && PARISC
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 06eec7b..359e560 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -122,6 +122,7 @@ obj-$(CONFIG_FB_OF)               += offb.o
>  
>  # the test framebuffer is last
>  obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
> +obj-$(CONFIG_FB_BF54X_LQ043)	  += bf54x-lq043.o

It's standard that we suffix all framebuffer drivers with an 'fb'. I'm
making it so in my tree.

Also, you shouldn't place your driver after vfb, that's why there's a
comment that the test framebuffer is last. If someone accidentally
enables vfb, he/she will get a blank screen. So I'm moving it under the
platform driver section. 

Tony




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
