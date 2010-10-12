From: Jimmy Rubin <jimmy.rubin@stericsson.com>
Subject: RFC: [PATCH 0/2] Add support for MCDE frame buffer driver
Date: Tue, 12 Oct 2010 09:42:25 +0200
Message-ID: <1286869347-8980-1-git-send-email-jimmy.rubin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Cc: Dan Johansson <dan.johansson@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

It contains a display sub system framework (DSS) which is used to
implement the frame buffer device interface and a display device
framework that is used to add support for different type of displays
such as LCD, HDMI and so on.

The current implementation supports DSI command mode displays.

Below is a short summary of the files in this patch:

mcde_fb.c
Implements the frame buffer device driver.

mcde_dss.c
Contains the implementation of the display sub system framework (DSS).
This API is used by the frame buffer device driver.

mcde_display.c
Contains default implementations of the functions in the display driver
API. A display driver may override the necessary functions to function 
properly. A simple display driver is implemented in display-generic_dsi.c.

display-generic_dsi.c
Sample driver for a DSI command mode display.

mcde_bus.c
Implementation of the display bus. A display device is probed when both
the display driver and display configuration have been registered with
the display bus.

mcde_hw.c
Hardware abstraction layer of MCDE. All code that communicates directly
with the hardware resides in this file.

board-mop500-mcde.c
The configuration of the display and the frame buffer device is handled
in this file.

Jimmy Rubin (2):
	Video: Add support for MCDE frame buffer driver
	Ux500: Add support for MCDE frame buffer driver

 drivers/video/Kconfig                         |    2 +
 drivers/video/Makefile                        |    1 +
 drivers/video/mcde/Kconfig                    |   39 +
 drivers/video/mcde/Makefile                   |   12 +
 drivers/video/mcde/display-generic_dsi.c      |  152 +
 drivers/video/mcde/dsilink_regs.h             | 2024 ++++++++++
 drivers/video/mcde/mcde_bus.c                 |  259 ++
 drivers/video/mcde/mcde_display.c             |  427 ++
 drivers/video/mcde/mcde_dss.c                 |  353 ++
 drivers/video/mcde/mcde_fb.c                  |  697 ++++
 drivers/video/mcde/mcde_hw.c                  | 2526 ++++++++++++
 drivers/video/mcde/mcde_mod.c                 |   67 +
 drivers/video/mcde/mcde_regs.h                | 5297 +++++++++++++++++++++++++
 include/video/mcde/mcde.h                     |  387 ++
 include/video/mcde/mcde_display-generic_dsi.h |   34 +
 include/video/mcde/mcde_display.h             |  139 +
 include/video/mcde/mcde_dss.h                 |   78 +
 include/video/mcde/mcde_fb.h                  |   54 +
 arch/arm/mach-ux500/Kconfig                    |    8 +
 arch/arm/mach-ux500/Makefile                   |    1 +
 arch/arm/mach-ux500/board-mop500-mcde.c        |  209 ++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-regulators.c  |   28 +++
 arch/arm/mach-ux500/board-mop500.c             |    3 +
 arch/arm/mach-ux500/devices-db8500.c           |   68 ++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    7 +
 arch/arm/mach-ux500/include/mach/devices.h     |    1 +
 arch/arm/mach-ux500/include/mach/prcmu-regs.h  |    1 +
 arch/arm/mach-ux500/include/mach/prcmu.h       |    3 +
 arch/arm/mach-ux500/prcmu.c                    |  129 +++++++++++++++

 29 files changed, 13006 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/mcde/Kconfig
 create mode 100644 drivers/video/mcde/Makefile
 create mode 100644 drivers/video/mcde/display-generic_dsi.c
 create mode 100644 drivers/video/mcde/dsilink_regs.h
 create mode 100644 drivers/video/mcde/mcde_bus.c
 create mode 100644 drivers/video/mcde/mcde_display.c
 create mode 100644 drivers/video/mcde/mcde_dss.c
 create mode 100644 drivers/video/mcde/mcde_fb.c
 create mode 100644 drivers/video/mcde/mcde_hw.c
 create mode 100644 drivers/video/mcde/mcde_mod.c
 create mode 100644 drivers/video/mcde/mcde_regs.h
 create mode 100644 include/video/mcde/mcde.h
 create mode 100644 include/video/mcde/mcde_display-generic_dsi.h
 create mode 100644 include/video/mcde/mcde_display.h
 create mode 100644 include/video/mcde/mcde_dss.h
 create mode 100644 include/video/mcde/mcde_fb.h
 create mode 100644 arch/arm/mach-ux500/board-mop500-mcde.c
