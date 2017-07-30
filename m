From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Sun, 30 Jul 2017 17:12:59 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <513cfff8-e181-6533-66dc-28a831dfa18a@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi David,

I'm glad to see a new tinydrm driver!


Den 29.07.2017 21.17, skrev David Lechner:
> The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
> working. But, most of the content here is building up the infrastructure to do
> that.
>
> The controller used in the EV3 uses MIPI commands, but it uses a different
> memory layout. The current tinydrm stuff is hard-coded for RGB565, so most
> of the patches are adding support for other memory layouts.
>
> I've also made the one existing tinydrm driver generic so that it can work for
> any MIPI display rather than copying a bunch of boiler-plate code for each
> panel and/or controller.
>
> Once all of this is done, it is really easy to add a new panel. :-)

I've been down that path, and decided against it. Otherwise mi0283qt
and mipi_dbi would have been one driver. I'm not keen on having one
driver that supports 50 displays, each with their own initialization
sequence. However if the sequences are very similar, then sharing a
driver makes sense. Time will tell, it's early days for tinydrm.

With fbtft it's possible to override the init sequence, but the Device
Tree guys NAK anything that looks like setting random registers
directly from properties and certainly not delays. If we could have
copied fbtft in this respect, one mipi_dbi driver would have been enough
and the DT would contain the init sequence.
Trying to add DT properties for specific controller properties will
most likely turn into a nightmare with the complexity of the
controllers. With very simple controllers it's possible:
Documentation/devicetree/bindings/display/ssd1307fb.txt

Maybe over time a pattern emerges that gives us a simple way to describe
these panels, but until then I don't want everything in one giant file.
If someone from the industry had taken interest in this, then maybe we
could have had a useful abstraction from the get go, but alas we're
dealing with old technology here.

Now to the ST7586S:

MIPI among other things have standards for interfacing and driving
display controllers. For our purpose there are 2 important ones:
- MIPI DCS - Defines a command set for operating the controller.
- MIPI DBI - Defines controller interface modes and pixel formats (RGB)

So is the ST7586S MIPI DCS/DBI compatible?

It's missing some of the commands, but it supports the ones necessary
for mipi_dbi. Interface wise it looks to be DBI compatible, but the
pixel format isn't.

I don't want to add a lot of complexity to mipi_dbi to support a non
standard format, so for maintainability and readability it's better to
write new code for this controller. DBI supports more formats than
RGB565, but I don't expect any true DBI compatible displays to actually
use those since RGB666 has no userspace support and RGB888 kills
throughput by 30%.

I suggest you write a new standalone driver for this display including
controller code, and if at a later point another ST7586 based display
shows up, we can pull out the controller specific code into a library
like mipi_dbi does.

You can use the newly merged repaper driver (monochrome) as a template:
https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/tinydrm/repaper.c

Since the ST7586 adheres to the DBI physical interface standard, you
can unwrap this from mipi_dbi so you can use that part of the library.

You can make a patch that changes mipi_dbi_spi_init() so you can use it:

- * usual read commands and initializes @mipi using mipi_dbi_init().
+ * usual read commands.

  int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
-              struct gpio_desc *dc,
-              const struct drm_simple_display_pipe_funcs *pipe_funcs,
-              struct drm_driver *driver,
-              const struct drm_display_mode *mode,
-              unsigned int rotation)
+              struct gpio_desc *dc)
  {
[...]
-    return mipi_dbi_init(dev, mipi, pipe_funcs, driver, mode, rotation);
+    return 0;
  }

  static int mi0283qt_probe(struct spi_device *spi)
  {
[...]
-    ret = mipi_dbi_spi_init(spi, mipi, dc, &mi0283qt_pipe_funcs,
-                &mi0283qt_driver, &mi0283qt_mode, rotation);
+    ret = mipi_dbi_spi_init(spi, mipi, dc);
     if (ret)
         return ret;

+    ret = mipi_dbi_init(dev, mipi, &mi0283qt_pipe_funcs, &mi0283qt_driver,
+                &mi0283qt_mode, rotation);
+    if (ret)
+        return ret;
+

Now you can use mipi_dbi_spi_init() to get the interface abstraction,
but instead of calling mipi_dbi_init() you implement your own code.


Noralf.

> David Lechner (6):
>    drm/tinydrm: Add parameter for MIPI DCS pixel format
>    drm/tinydrm: add helpers for ST7586 controllers
>    drm/tinydrm: rename mi028qt module to mipi-panel
>    drm/tinydrm: mipi-panel: refactor to use driver id
>    drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
>    ARM: dts: da850-lego-ev3: Add node for LCD display
>
>   .../devicetree/bindings/display/mipi-panel.txt     |  27 ++
>   .../bindings/display/multi-inno,mi0283qt.txt       |  27 --
>   MAINTAINERS                                        |   6 +-
>   arch/arm/boot/dts/da850-lego-ev3.dts               |  24 ++
>   drivers/gpu/drm/tinydrm/Kconfig                    |  13 +-
>   drivers/gpu/drm/tinydrm/Makefile                   |   2 +-
>   drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     | 148 ++++++++
>   drivers/gpu/drm/tinydrm/mi0283qt.c                 | 282 ---------------
>   drivers/gpu/drm/tinydrm/mipi-dbi.c                 | 117 ++++--
>   drivers/gpu/drm/tinydrm/mipi-panel.c               | 395 +++++++++++++++++++++
>   include/drm/tinydrm/mipi-dbi.h                     |   9 +-
>   include/drm/tinydrm/st7586.h                       |  34 ++
>   include/drm/tinydrm/tinydrm-helpers.h              |   6 +
>   include/video/mipi_display.h                       |  16 +-
>   14 files changed, 759 insertions(+), 347 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/mipi-panel.txt
>   delete mode 100644 Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
>   delete mode 100644 drivers/gpu/drm/tinydrm/mi0283qt.c
>   create mode 100644 drivers/gpu/drm/tinydrm/mipi-panel.c
>   create mode 100644 include/drm/tinydrm/st7586.h
>

