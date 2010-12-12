From: Alessandro Suardi <alessandro.suardi@gmail.com>
Date: Sun, 12 Dec 2010 12:10:37 +0000
Subject: Re: intelfb refuses to load
Message-Id: <AANLkTimmRPcu_Ld7_hBqOrgo4PGDuO6ym0edt7SXz+Je@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101211221325.GA1954@elf.ucw.cz>
	<20101211234356.1e9007fe@neptune.home>
	<20101212075203.GA1934@elf.ucw.cz>
	<alpine.DEB.2.00.1012120759520.28614@skynet.skynet.ie>
	<20101212080851.GA2254@elf.ucw.cz>
In-Reply-To: <20101212080851.GA2254@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Airlie <airlied@linux.ie>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, mbroemme@plusserver.de, linux-fbdev@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>

On Sun, Dec 12, 2010 at 9:08 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > i915.modeset=3D1 video=3Dinteldrmfb:mode=1024x768 fbcon=3Dscrollback:6=
4k
>> >
>> > on cmdline and:
>> >
>> > CONFIG_DRM=3Dy
>> > CONFIG_DRM_KMS_HELPER=3Dy
>> > # CONFIG_DRM_TDFX is not set
>> > # CONFIG_DRM_R128 is not set
>> > # CONFIG_DRM_RADEON is not set
>> > # CONFIG_DRM_I810 is not set
>> > # CONFIG_DRM_I830 is not set
>> > CONFIG_DRM_I915=3Dy
>> > # CONFIG_DRM_I915_KMS is not set
>> > # CONFIG_DRM_MGA is not set
>> > # CONFIG_DRM_SIS is not set
>> > # CONFIG_DRM_VIA is not set
>> > # CONFIG_DRM_SAVAGE is not set
>> > # CONFIG_STUB_POULSBO is not set
>> > CONFIG_VGASTATE=3Dy
>> > CONFIG_VIDEO_OUTPUT_CONTROL=3Dy
>> > CONFIG_FB=3Dy
>> > CONFIG_FIRMWARE_EDID=3Dy
>> > # CONFIG_FB_DDC is not set
>> > ...
>> > CONFIG_ACPI_VIDEO=3Dy
>>
>> CONFIG_FRAMEBUFFER_CONSOLE?
>
> No, that one was set. (I see even two penguins for a short while).
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> # CONFIG_VGACON_SOFT_SCROLLBACK is not set
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> CONFIG_FONTS=3Dy

What works for me (without boot command line options):

[asuardi@duff linux-2.6.37-rc5-git3]$ egrep
'DRM|FB|VIDEO|VGA|FRAMEBUFFER' .config | grep -v "^#"
CONFIG_ACPI_VIDEO=3Dm
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=3D4
CONFIG_DRM=3Dm
CONFIG_DRM_KMS_HELPER=3Dm
CONFIG_DRM_I915=3Dm
CONFIG_DRM_I915_KMS=3Dy
CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
CONFIG_FB=3Dy
CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_VESA=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK_SIZEd
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy

[asuardi@duff linux-2.6.37-rc5-git3]$ dmesg|grep intel
intel_idle: MWAIT substates: 0x3122220
intel_idle: does not run on family 6 model 23
agpgart-intel 0000:00:00.0: Intel GM45 Chipset
agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappa=
ble
agpgart-intel 0000:00:00.0: detected 32768K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
fbcon: inteldrmfb (fb0) is primary device
fb0: inteldrmfb frame buffer device


--alessandro

=A0"There's always a siren singing you to shipwreck"

=A0=A0 (Radiohead, "There There")
