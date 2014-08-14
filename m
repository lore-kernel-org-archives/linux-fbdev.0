From: Luc Verhaegen <libv@skynet.be>
Date: Thu, 14 Aug 2014 10:57:12 +0000
Subject: Re: [linux-sunxi] [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140814105711.GC1000@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <53EC834F.6020307@redhat.com>
 <9B9D62CA-8037-4653-BCF0-C79BFFEB4279@dominion.thruhere.net>
In-Reply-To: <9B9D62CA-8037-4653-BCF0-C79BFFEB4279@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 14, 2014 at 12:31:50PM +0200, Koen Kooi wrote:
> 
> How many DRM drivers are there on ARM and what's the size impact of building them all into the kernel? I know from experience that it's not possible on x86 especially with efifb in the mix, but I wonder what the situation on ARM is. I only have TI, sunxi and exynos boards to test on and building in both TI drm drivers and the exynos one seems to work. 
> Note that I'm not talking about the non-DRM abortions that maskerade as graphics drivers for ARM SoCs, only proper DRM ones.
> 
> regards,
> 
> Koen

A quick check tells me that my current sunxi-3.4 sunxi_drm.ko measures 
1.7MB, for currently about 8kloc (the binary seems excessively big 
though), which is just display. This still lacks many key features (lcd 
gpio, backlight pwm, lvds, ints), so it will grow ~1kloc still.

Also, i constantly am re-loading this (how else does one develop any 
sizable amount of code?), so it does that cleanly and correctly, which 
seems quite contrary to your experience with ARM drm drivers.

Luc Verhaegen.
