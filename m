From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 12 Dec 2010 08:08:51 +0000
Subject: Re: intelfb refuses to load
Message-Id: <20101212080851.GA2254@elf.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101211221325.GA1954@elf.ucw.cz>
 <20101211234356.1e9007fe@neptune.home>
 <20101212075203.GA1934@elf.ucw.cz>
 <alpine.DEB.2.00.1012120759520.28614@skynet.skynet.ie>
In-Reply-To: <alpine.DEB.2.00.1012120759520.28614@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@linux.ie>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, mbroemme@plusserver.de, linux-fbdev@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>

Hi!

> > i915.modeset=1 video=inteldrmfb:mode24x768 fbcon=scrollback:64k 
> > 
> > on cmdline and:
> > 
> > CONFIG_DRM=y
> > CONFIG_DRM_KMS_HELPER=y
> > # CONFIG_DRM_TDFX is not set
> > # CONFIG_DRM_R128 is not set
> > # CONFIG_DRM_RADEON is not set
> > # CONFIG_DRM_I810 is not set
> > # CONFIG_DRM_I830 is not set
> > CONFIG_DRM_I915=y
> > # CONFIG_DRM_I915_KMS is not set
> > # CONFIG_DRM_MGA is not set
> > # CONFIG_DRM_SIS is not set
> > # CONFIG_DRM_VIA is not set
> > # CONFIG_DRM_SAVAGE is not set
> > # CONFIG_STUB_POULSBO is not set
> > CONFIG_VGASTATE=y
> > CONFIG_VIDEO_OUTPUT_CONTROL=y
> > CONFIG_FB=y
> > CONFIG_FIRMWARE_EDID=y
> > # CONFIG_FB_DDC is not set
> > ...
> > CONFIG_ACPI_VIDEO=y
> 
> CONFIG_FRAMEBUFFER_CONSOLE?

No, that one was set. (I see even two penguins for a short while).

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
