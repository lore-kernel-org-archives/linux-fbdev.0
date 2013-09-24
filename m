From: Andrzej Hajda <a.hajda@samsung.com>
Date: Tue, 24 Sep 2013 14:23:12 +0000
Subject: [RFC PATCH 0/4] CDFv3: MIPI DSI bus implementation
Message-Id: <1380032596-18612-1-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Hi Laurent,

This is my MIPI DSI bus implementation. The patchset
contains also two drivers:
- DSI bus master driver for Exynos,
- DSI slave driver for s6e8aa0 panel family.
All code has been tested on real device - Exynos 4210 based 'Trats'.

This is not final version, there are still some things to do.

DSI bus code is based on mipi-dbi-bus, with few major changes.
1. I have replaced three DBI opses:
- write_command,
- write_data,
- read_data
with one op 'transfer', this way it better fits to
MIPI DSI standard, I wonder if this cannot be adapted to DBI also.
The only things which bothers me is number of arguments,
maybe struct should be used instead.

I have added DCS helpers functions which use 'transfer' op:
- mipi_dsi_dcs_read
- mipi_dsi_dcs_write
and two macros which allow to pass variable number of bytes
as arguments, example usage in panel driver code:
- mipi_dsi_dcs_write_seq
- mipi_dsi_dcs_write_static_seq

I have added also following opses:
- set_stream - to enable/disable streaming on DSI master,
- set_power - I have temporarily dropped idea of using runtime_pm
    due to compliacted power on sequence of panel/dsi,
    which would probably require different op anyway.

struct mipi_dsi_device contains videomode and mipi_dsi_interface_params fields.
Those fields are read by opses, I wonder if it would not be better to
pass them directly to opses as arguments.

TODO:
- helpers for non-DT drivers,
- minor power management issues,
- better error handling
- ...

Regards
Andrzej

Andrzej Hajda (4):
  mipi-dsi-bus: add MIPI DSI bus support
  mipi-dsi-exynos: add driver
  panel-s6e8aa0: add driver
  ARM: dts: exynos4210-trats: add panel and dsi nodes

 arch/arm/boot/dts/exynos4210-trats.dts  |   54 ++
 drivers/video/display/Kconfig           |   14 +
 drivers/video/display/Makefile          |    3 +
 drivers/video/display/mipi-dsi-bus.c    |  332 ++++++++
 drivers/video/display/mipi-dsi-exynos.c | 1310 +++++++++++++++++++++++++++++++
 drivers/video/display/panel-s6e8aa0.c   | 1286 ++++++++++++++++++++++++++++++
 include/video/display.h                 |    3 +
 include/video/mipi-dsi-bus.h            |  144 ++++
 include/video/mipi-dsi-exynos.h         |   41 +
 include/video/panel-s6e8aa0.h           |   42 +
 10 files changed, 3229 insertions(+)
 create mode 100644 drivers/video/display/mipi-dsi-bus.c
 create mode 100644 drivers/video/display/mipi-dsi-exynos.c
 create mode 100644 drivers/video/display/panel-s6e8aa0.c
 create mode 100644 include/video/mipi-dsi-bus.h
 create mode 100644 include/video/mipi-dsi-exynos.h
 create mode 100644 include/video/panel-s6e8aa0.h

-- 
1.8.1.2

