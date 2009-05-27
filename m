From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fbdev: does not allow VESA modes
 without compiled-in drivers (bug #13249)
Date: Tue, 26 May 2009 23:15:16 -0700
Message-ID: <20090526231516.b0cf789f.akpm@linux-foundation.org>
References: <20090520142704.0de8aa81.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1M9CQp-00023C-JV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 06:16:07 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9CQl-0001BR-6X
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 06:16:07 +0000
In-Reply-To: <20090520142704.0de8aa81.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Werner, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Lemberg <wl@gnu.org>

On Wed, 20 May 2009 14:27:04 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Does not allow to accept VESA modes by the "vga=" kernel parameter
> if there is no frame buffer driver compiled-in to handle it.
> 
> Bug was reported by Werner Lemberg as kernel bug #13249
> "Intel 945GM: Boot option`vga=0x31a' breaks display of TTYs".
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> Werner, please test it. It should produce a correct display
> with intelfb compiled in (=y) and as a module (=m).
> 
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0048f11..c787357 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1122,7 +1122,7 @@ config FB_INTEL
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -	select FB_BOOT_VESA_SUPPORT
> +	select FB_BOOT_VESA_SUPPORT if FB_INTEL = y
>  	help
>  	  This driver supports the on-board graphics built in to the Intel
>            830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
> @@ -1460,7 +1460,7 @@ config FB_SIS
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -	select FB_BOOT_VESA_SUPPORT
> +	select FB_BOOT_VESA_SUPPORT if FB_SIS = y
>  	help
>  	  This is the frame buffer device driver for the SiS 300, 315, 330
>  	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.

I read through http://bugzilla.kernel.org/show_bug.cgi?id=13249 and am
now unsure what to do with this patch?



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
