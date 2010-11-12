From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Nov 2010 17:22:11 +0000
Subject: Re: [PATCH 00/10] MCDE: Add frame buffer device driver
Message-Id: <AANLkTi=z4g9XKyzhRP+3TQ2s_uKL_OZHL5YyFV7EGiSu@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<AANLkTinCDFuPpx+OKYRuHbdnL5FBgCTPpUf2xYNJQC0u@mail.gmail.com>
	<F45880696056844FA6A73F415B568C69536047701B@EXDCVYMBSTM006.EQ1STM.local>
	<AANLkTi=aasEoC5ja=gHpzNjyA1h00wuJd-tWVkRaaHNd@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE0081BDCB183@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE0081BDCB183@EXDCVYMBSTM005.EQ1STM.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 12, 2010 at 11:46 AM, Marcus LORENTZON
<marcus.xm.lorentzon@stericsson.com> wrote:
> Hi Alex,
> Do you have any idea of how we should use KMS without being a "real" drm =
3D device? Do you mean that we should use the KMS ioctls on for display dri=
ver? Or do you mean that we should expose a /dev/drmX device only capable o=
f KMS and no GEM?
>

In this case I was only speaking of using the kms icotls and fbdev
emulation for modesetting as your device seems to have a fairly
complex display engine.  As for 2D/3D/video accel, that's up to you.
Each drm driver does it differently depending on how they handle
command buffers.  Intel and AMD have different sets of ioctls for
submitting 2D/3D/video commands from userspace acceleration drivers
and a different set of ioctls for memory management.

> What if we were to add a drm driver for 3D later on. Is it possible to ha=
ve a separate drm device for display and one for 3D, but still share "GEM" =
like buffers between these devices? It look like GEM handles are device rel=
ative. This is a vital use case for us. And we really don't like to entangl=
e our MCDE display driver, memory manager and 3D driver without a good reas=
on. Today they are maintained as independent drivers without code dependenc=
ies. Would this still be possible using drm? Or does drm require memory man=
ager, 3D and display to be one driver? I can see the drm=3Dgraphics card on=
 desktop machines. But embedded UMA systems doesn't really have this depend=
ency. You can switch memory mamanger, 3D driver, display manager in menucon=
fig independently of the other drivers. Not that it's used like that on one=
 particular HW, but for different HW you can use different parts. In drm it=
 looks like all these pieces belong together.
>

No one has done anything like that, but I don't think it would be an
issue, you'd just need some sort of way to get buffers in your display
driver or your 3D driver, so I'd assume they would depend on your
memory manager.  Right now the userspace 2D/3D accel drivers all talk
to the drm independently depending on what they need to do.  Whatever
your userspace stack looks like could do something similar, call into
one set of ioctls for memory, another set for modesetting, and another
for accel.  As long as the kernel memory manager is common, you should
be able to pass buffer handles between all of them.  If you wanted
separate memory managers for each, things get a bit trickier, but
that's up to you.

> Do you think the driver should live in the "gpu/drm" folder, even though =
it's not a gpu driver?
>

gpu is kind of a broad term.  It encompasses, 3D, display, video, etc.
 I don't think it really matters.

> Do you know of any other driver that use DRM/KMS API but not being a PC-s=
tyle graphics card that we could look at for inspiration?

Jordan Crouse submitted some patches for Qualcomm snapdragon a while
back although it was mostly a shim for a userspace accel driver.  He
did implement platform support in the drm however:
http://git.kernel.org/?p=3Dlinux/kernel/git/airlied/drm-2.6.git;a=3Dcommit;=
h=DCdb167402cbdca1d021bdfa5f63995ee0a79317

>
> And GEM, is that the only way of exposing graphics buffers to user space =
in drm? Or is it possible (is it ok) to expose another similar API? You men=
tioned that there are TTM and GEM, do both expose user space APIs for thing=
s like sharing buffers between processes, security, cache management, defra=
gmentation? Or are these type of features defined by DRM and not TTM/GEM?
>

GEM is not a requirement, it just happens that all the current drm
drivers use variants of it for their external memory management
interface.  However, they are free to implement the memory manager
however they like.

Alex

> /BR
> /Marcus
>
>> -----Original Message-----
>> From: Alex Deucher [mailto:alexdeucher@gmail.com]
>> Sent: den 12 november 2010 16:53
>> To: Jimmy RUBIN
>> Cc: linux-fbdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-media@vger.kernel.org; Linus WALLEIJ; Dan JOHANSSON; Marcus
>> LORENTZON
>> Subject: Re: [PATCH 00/10] MCDE: Add frame buffer device driver
>>
>> On Fri, Nov 12, 2010 at 8:18 AM, Jimmy RUBIN
>> <jimmy.rubin@stericsson.com> wrote:
>> > Hi Alex,
>> >
>> > Good point, we are looking at this for possible future improvements
>> but for the moment we feel like
>> > the structure of drm does not add any simplifications for our driver.
>> We have the display manager (MCDE DSS =3D KMS) and the memory manager
>> (HWMEM =3D GEM) that could be migrated to drm framework. But we do not
>> have drm drivers for 3D hw and this also makes drm a less obvious
>> choice at the moment.
>> >
>>
>> You don't have to use the drm strictly for 3D hardware. =A0historically
>> that's why it was written, but with kms, it also provides an interface
>> for complex display systems. =A0fbdev doesn't really deal properly with
>> multiple display controllers or connectors that are dynamically
>> re-routeable at runtime. =A0I've seen a lot of gross hacks to fbdev to
>> support this kind of stuff in the past, so it'd be nice to use the
>> interface we now have for it if you need that functionality.
>> Additionally, you can use the shared memory manager to both the
>> display side and v4l side. =A0While the current drm drivers use GEM
>> externally, there's no requirement that a kms driver has to use GEM.
>> radeon and nouveau use ttm internally for example. =A0Something to
>> consider. =A0I just want to make sure people are aware of the interface
>> and what it's capable of.
>>
>> Alex
>>
>> > Jimmy
>> >
>> > -----Original Message-----
>> > From: Alex Deucher [mailto:alexdeucher@gmail.com]
>> > Sent: den 10 november 2010 15:43
>> > To: Jimmy RUBIN
>> > Cc: linux-fbdev@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; Linus WALLEIJ;
>> Dan JOHANSSON
>> > Subject: Re: [PATCH 00/10] MCDE: Add frame buffer device driver
>> >
>> > On Wed, Nov 10, 2010 at 7:04 AM, Jimmy Rubin
>> <jimmy.rubin@stericsson.com> wrote:
>> >> These set of patches contains a display sub system framework (DSS)
>> which is used to
>> >> implement the frame buffer device interface and a display device
>> >> framework that is used to add support for different type of displays
>> >> such as LCD, HDMI and so on.
>> >
>> > For complex display hardware, you may want to consider using the drm
>> > kms infrastructure rather than the kernel fb interface. =A0It provides
>> > an API for complex display hardware (multiple encoders, display
>> > controllers, etc.) and also provides a legacy kernel fb interface for
>> > compatibility. =A0See:
>> > Documentation/DocBook/drm.tmpl
>> > drivers/gpu/drm/
>> > in the kernel tree.
>> >
>> > Alex
>> >
>> >>
>> >> The current implementation supports DSI command mode displays.
>> >>
>> >> Below is a short summary of the files in this patchset:
>> >>
>> >> mcde_fb.c
>> >> Implements the frame buffer device driver.
>> >>
>> >> mcde_dss.c
>> >> Contains the implementation of the display sub system framework
>> (DSS).
>> >> This API is used by the frame buffer device driver.
>> >>
>> >> mcde_display.c
>> >> Contains default implementations of the functions in the display
>> driver
>> >> API. A display driver may override the necessary functions to
>> function
>> >> properly. A simple display driver is implemented in display-
>> generic_dsi.c.
>> >>
>> >> display-generic_dsi.c
>> >> Sample driver for a DSI command mode display.
>> >>
>> >> mcde_bus.c
>> >> Implementation of the display bus. A display device is probed when
>> both
>> >> the display driver and display configuration have been registered
>> with
>> >> the display bus.
>> >>
>> >> mcde_hw.c
>> >> Hardware abstraction layer of MCDE. All code that communicates
>> directly
>> >> with the hardware resides in this file.
>> >>
>> >> board-mop500-mcde.c
>> >> The configuration of the display and the frame buffer device is
>> handled
>> >> in this file
>> >>
>> >> NOTE: These set of patches replaces the patches already sent out for
>> review.
>> >>
>> >> RFC:[PATCH 1/2] Video: Add support for MCDE frame buffer driver
>> >> RFC:[PATCH 2/2] Ux500: Add support for MCDE frame buffer driver
>> >>
>> >> The old patchset was to large to be handled by the mailing lists.
>> >>
>> >> Jimmy Rubin (10):
>> >> =A0MCDE: Add hardware abstraction layer
>> >> =A0MCDE: Add configuration registers
>> >> =A0MCDE: Add pixel processing registers
>> >> =A0MCDE: Add formatter registers
>> >> =A0MCDE: Add dsi link registers
>> >> =A0MCDE: Add generic display
>> >> =A0MCDE: Add display subsystem framework
>> >> =A0MCDE: Add frame buffer device driver
>> >> =A0MCDE: Add build files and bus
>> >> =A0ux500: MCDE: Add platform specific data
>> >>
>> >> =A0arch/arm/mach-ux500/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A08 +
>> >> =A0arch/arm/mach-ux500/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A01 +
>> >> =A0arch/arm/mach-ux500/board-mop500-mcde.c =A0 =A0 =A0 =A0| =A0209 ++
>> >> =A0arch/arm/mach-ux500/board-mop500-regulators.c =A0| =A0 28 +
>> >> =A0arch/arm/mach-ux500/board-mop500.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A03 +
>> >> =A0arch/arm/mach-ux500/devices-db8500.c =A0 =A0 =A0 =A0 =A0 | =A0 68 +
>> >> =A0arch/arm/mach-ux500/include/mach/db8500-regs.h | =A0 =A07 +
>> >> =A0arch/arm/mach-ux500/include/mach/devices.h =A0 =A0 | =A0 =A01 +
>> >> =A0arch/arm/mach-ux500/include/mach/prcmu-regs.h =A0| =A0 =A01 +
>> >> =A0arch/arm/mach-ux500/include/mach/prcmu.h =A0 =A0 =A0 | =A0 =A03 +
>> >> =A0arch/arm/mach-ux500/prcmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0129 ++
>> >> =A0drivers/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +
>> >> =A0drivers/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 +
>> >> =A0drivers/video/mcde/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 39 +
>> >> =A0drivers/video/mcde/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 12 +
>> >> =A0drivers/video/mcde/display-generic_dsi.c =A0 =A0 =A0 | =A0152 ++
>> >> =A0drivers/video/mcde/dsi_link_config.h =A0 =A0 =A0 =A0 =A0 | 1486
>> ++++++++++++++
>> >> =A0drivers/video/mcde/mcde_bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0259 +++
>> >> =A0drivers/video/mcde/mcde_config.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 2156
>> ++++++++++++++++++++
>> >> =A0drivers/video/mcde/mcde_display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
427 ++++
>> >> =A0drivers/video/mcde/mcde_dss.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0353 ++++
>> >> =A0drivers/video/mcde/mcde_fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0697 +++++++
>> >> =A0drivers/video/mcde/mcde_formatter.h =A0 =A0 =A0 =A0 =A0 =A0| =A078=
2 ++++++++
>> >> =A0drivers/video/mcde/mcde_hw.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 2528
>> ++++++++++++++++++++++++
>> >> =A0drivers/video/mcde/mcde_mod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 67 +
>> >> =A0drivers/video/mcde/mcde_pixelprocess.h =A0 =A0 =A0 =A0 | 1137 ++++=
+++++++
>> >> =A0include/video/mcde/mcde.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0387 ++++
>> >> =A0include/video/mcde/mcde_display-generic_dsi.h =A0| =A0 34 +
>> >> =A0include/video/mcde/mcde_display.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
139 ++
>> >> =A0include/video/mcde/mcde_dss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 78 +
>> >> =A0include/video/mcde/mcde_fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 54 +
>> >> =A031 files changed, 11248 insertions(+), 0 deletions(-)
>> >> =A0create mode 100644 arch/arm/mach-ux500/board-mop500-mcde.c
>> >> =A0create mode 100644 drivers/video/mcde/Kconfig
>> >> =A0create mode 100644 drivers/video/mcde/Makefile
>> >> =A0create mode 100644 drivers/video/mcde/display-generic_dsi.c
>> >> =A0create mode 100644 drivers/video/mcde/dsi_link_config.h
>> >> =A0create mode 100644 drivers/video/mcde/mcde_bus.c
>> >> =A0create mode 100644 drivers/video/mcde/mcde_config.h
>> >> =A0create mode 100644 drivers/video/mcde/mcde_display.c
>> >> =A0create mode 100644 drivers/video/mcde/mcde_dss.c
>> >> =A0create mode 100644 drivers/video/mcde/mcde_fb.c
>> >> =A0create mode 100644 drivers/video/mcde/mcde_formatter.h
>> >> =A0create mode 100644 drivers/video/mcde/mcde_hw.c
>> >> =A0create mode 100644 drivers/video/mcde/mcde_mod.c
>> >> =A0create mode 100644 drivers/video/mcde/mcde_pixelprocess.h
>> >> =A0create mode 100644 include/video/mcde/mcde.h
>> >> =A0create mode 100644 include/video/mcde/mcde_display-generic_dsi.h
>> >> =A0create mode 100644 include/video/mcde/mcde_display.h
>> >> =A0create mode 100644 include/video/mcde/mcde_dss.h
>> >> =A0create mode 100644 include/video/mcde/mcde_fb.h
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-
>> media" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> >>
>> >
>
