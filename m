From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>
Date: Sat, 21 Mar 2015 18:23:00 +0000
Subject: Re: [RFC 0/7] staging: fbtft: minimize coupling to the fbdev subsystem
Message-Id: <550DB704.4000909@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425293669-15754-1-git-send-email-noralf@tronnes.org>
In-Reply-To: <1425293669-15754-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, noralf@tronnes.org
Cc: driverdev-devel@linuxdriverproject.org


Den 02.03.2015 11:54, skrev Noralf Trønnes:
> Hi,
>
> This patchset introduces a new API to minimize the coupling to the
> fbdev graphics subsystem. There have been calls to deprecate fbdev and
> new fbdev drivers are discouraged.
> Currently the FBTFT drivers are tightly coupled to fbdev through the
> fbtft module and the fbtft_par structure.
>
> What is FBTFT?
> FBTFT is a framework for writing drivers for MIPI DCS/DBI [1] like controllers.
> These controllers have the following characteristics:
> - Onchip graphics RAM that is scanned out to the display panel.
> - Registers to set operational parameters and write pixel data
> - SPI, I2C and/or parallel interface
>
> To provide better layering and provide opportunity for reuse,
> I propose the following layers:
>
> +-----------------------------+
> |          fbdev              |
> +-----------------------------+
> |          fbtft              |
> +-------------------------+---+
> |      Display driver     |   |
> +---+---------------------+   |
> |   |     lcdctrl             |
> |   +-------------------------+
> |         lcdreg              |
> +-----------------------------+
> |  Interface (SPI, parallel)  |
> +-----------------------------+
>
> lcdreg
> ------
> This layer deals with the various LCD controller interface
> implementations (SPI, Intel 8080, I2C). It provides a simple interface
> for reading and writing to the LCD controller register.
> Especially the SPI interface has several modes and variations that
> makes it rather complex.
>
> lcdreg can be reused by drivers that drive these same controllers in
> digital RGB interface mode (MIPI DPI). Even when the parallel RGB
> interface is used for pixeldata, the controller some times has to be
> configured. This is usually done through a SPI interface.
>
> lcdctrl
> -------
> Layer providing an abstraction of the LCD controller and it's
> principal funtions:
> - Poweron initialization
> - Set display rotation
> - Set pixel format
> - Display blanking
> - Update grahics RAM
>
> This decouples the controller implementation from the graphics subsystem,
> and prepares for a possible future move to DRM or other grahics subsystems.
> The controller specific functionality is kept in library modules.
>
> fbtft
> -----
> The fbtft module gets some helper functions in fbtft-lcdctrl to map
> the lcdtrl functions into the fbtft_par structure.
> Later when all the drivers have been converted, large parts of the
> fbtft module can be removed.
>
>
> The I2C implementation of lcdreg is used in this proposal, because of
> it's simplicity. This is to keep focus on the architectural design.
> Implementations for SPI and the Intel 8080 bus interface exists.
>
> Display or Controller driver?
> Currently FBTFT has drivers for each controller it supports.
> Each driver has a default controller setup which often matches many
> displays, but no all (fbtftops.init_display()). A different init
> sequence (register values and delays) can be passed in using
> platform_data or as a DT property.
> I made a post to the DT mailinglist [2] about setting an init sequence
> from the Device Tree, but didn't get any replies. Based on an earlier
> post and comments I've read, it's looks like init sequence in DT is
> not going to happen. That's why this proposal shifts to having display
> drivers, with controller specific code in library modules.
>
> Device Tree questions
> - What about Device Tree property names that are used by all drivers
>    (initialized, format, rotation)? Should they be prefixed in any way?
> - Device Tree compatible string. If a driver supports both SPI and I2C,
>    can the same compatible string be used for both busses (ada-ssd1306fb)?
>    I have seen examples where the bus is added as a postfix (-i2c).
>    And which one is preferred: 'ada-ssd1306' or 'ada-ssd1306fb'?
>
> Why RFC?
> I did this because of some uncertainties I have with this proposal:
> 1. This changes almost the entire FBTFT stack. Would it be better to
>     just move directly to DRM? DRM is the preferred way to write graphics
>     drivers now, but fbdev is really a perfect match for FBTFT.
>     And DRM doesn't have deferred io support AFAICT.
> 2. The change from controller centric drivers to display drivers is
>     that correct?
>     This will deprecate all of the current controller drivers.
>
> So any help in pinning down the path for moving FBTFT forward is appreciated.
>
>
> [1]: MIPI Alliance Display Interface Specifications:
>       MIPI DCS - Display Command Set
>       MIPI DBI - Display Bus Interface
>       MIPI DPI - Display Pixel Interface
>       http://mipi.org/specifications/display-interface
> [2]: http://article.gmane.org/gmane.linux.drivers.devicetree/109103
>

Hi,

I didn't get any comments to my questions in this cover letter,
so I'm bumping it.
The fbdev mailinglist is included this time, as I'm hoping to receive
comments about a future move of fbtft into fbdev.

I have also started writing code for drm/kms integration
of this patchset, too see what that look's like.


Regards,
Noralf Trønnes

