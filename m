From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 02 Feb 2013 10:39:59 +0000
Subject: Re: [RFC PATCH 0/4] Common Display Framework-TF
Message-Id: <4292748.rtElrP8BXd@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359560343-31636-1-git-send-email-t.figa@samsung.com>
In-Reply-To: <1359560343-31636-1-git-send-email-t.figa@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomasz Figa <t.figa@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, tomasz.figa@gmail.com, Daniel Vetter <daniel@ffwll.ch>, Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>, rob@ti.com, tomi.valkeinen@ti.com, Vikas Sajjan <vikas.sajjan@linaro.org>, inki.dae@samsung.com, dh09.lee@samsung.com, ville.syrjala@intel.com, s.nawrocki@samsung.com

Hi Tomasz,

Thank you for your RFC.

On Wednesday 30 January 2013 16:38:59 Tomasz Figa wrote:
> Hi,
> 
> After pretty long time of trying to adapt Exynos-specific DSI display
> support to Common Display Framework I'm ready to show some preliminary RFC
> patches. This series shows some ideas for CDF that came to my mind during
> my work, some changes based on comments received by Tomi's edition of CDF
> and also preliminarys version of Exynos DSI (video source part only, still
> with some FIXMEs) and Samsung S6E8AX0 DSI panel drivers.
> 
> It is heavily based on Tomi's work which can be found here:
> http://thread.gmane.org/gmane.comp.video.dri.devel/78227
> 
> The code might be a bit hacky in places, as I wanted to get it to a kind
> of complete and working state first. However I hope that some of the ideas
> might useful for further works.
> 
> So, here comes the TF edition of Common Clock Framework.
> --------------------------------------------------------
> 
> Changes done to Tomi's edition of CDF:
> 
>  - Replaced set_operation_mode, set_pixel_format and set_size video source
>    operations with get_params display entity operation, as it was originally
>    in Laurent's version.
> 
>    We have discussed this matter on the mailing list and decided that it
>    would be better to have the source ask the sink for its parameter
>    structure and do whatever appropriate with it.

Could you briefly outline the rationale behind this ?

I'm wondering whether get_params could limit us if a device needs to modify 
parameters at runtime. For instance a panel might need to change clock 
frequencies or number of used data lane depending on various runtime 
conditions. I don't have a real use case here, so it might just be a bit of 
over-engineering.

>  - Defined a preliminary set of DSI bus parameters.
> 
>    Following parameters are defined:
> 
>    1. Pixel format used for video data transmission.
>    2. Mode flags (several bit flags ORed together):
>      a) DSI_MODE_VIDEO - entity uses video mode (as opposed to command
>         mode), following DSI_MODE_VIDEO_* flags are relevant only if this
>         flag is set.
>         b) DSI_MODE_VIDEO_BURST - entity uses burst transfer for video data
>         c) DSI_MODE_VIDEO_SYNC_PULSE - entity uses sync pulses (as opposed
>            to sync events)
>         d) DSI_MODE_VIDEO_AUTO_VERT - entity uses automatic video mode
>            detection
>         e) DSI_MODE_VIDEO_HSE - entity needs horizontal sync end packets
>         f) DSI_MODE_VIDEO_HFP - entity needs horizontal front porch area
>         g) DSI_MODE_VIDEO_HBP - entity needs horizontal back porch area
>         h) DSI_MODE_VIDEO_HSA - entity needs horizontal sync active area
>      i) DSI_MODE_VSYNC_FLUSH - vertical sync pulse flushes video data
>      j) DSI_MODE_EOT_PACKET - entity needs EoT packets
>    3. Bit (serial) clock frequency in HS mode.
>    4. Escape mode clock frequency.
>    5. Mask of used data lanes (each bit represents single lane).

From my experience with MIPI CSI (Camera Serial Interface, similar to DSI) 
some transceivers can reroute data lanes internally. Is that true for DSI as 
well ? In that case we would need a list of data lanes, not just a mask.

>    6. Command allow area in video mode - amount of lines after transmitting
>       video data when generic commands are accepted.
> 
>    Feel free to suggest anything missing or wrong, as the list of
>    parameters is based merely on what was used in original Exynos MIPI
>    DSIM driver.
> 
>  - Redesigned source-entity matching.
> 
>    Now each source has name string and integer id and each entity has
>    source name and source id. In addition, they can have of_node specified,
>    which is used for Device Tree-based matching.
> 
>    The matching procedure is as follows:
> 
>    1. Matching takes place when display entity registers.
>      a) If there is of_node specified for the entity then "video-source"
>         phandle of this node is being parsed and list of registered sources
>         is traversed in search of a source with of_node received from
>         parsing the phandle.
>      b) Otherwise the matching key is a pair of source name and id.
>    2. If no matching source is found, display_entity_register returns
>       -EPROBE_DEFER error which causes the entity driver to defer its
>       probe until the source registers.
>    3. Otherwise an optional bind operation of video source is called,
>       sink field of source and source field of entity are set and the
>       matching ends successfully.
> 
>  - Some initial concept of source-entity cross-locking.
> 
>    Only video source is protected at the moment, as I still have to think
>    a bit about locking the entity in a way where removing it by user request
>    is still possible.

One of the main locking issues here are cross-references. The display entity 
holds a reference to the video source (for video operations), and the display 
controller driver holds a reference to the display entity (for control 
operations), resulting in a cross-references lock situation. One possible 
solution would be to first unbind the display entity device from its driver to 
break the cycle.

>  - Dropped any panels and chips that I can't test.
> 
>    They are irrelevant for this series, so there is no point in including
>    them.
> 
>  - Added Exynos DSI video source driver.
> 
>    This is a new driver for the DSI controller found in Exynos SoCs. It
>    still needs some work, but in current state can be considered an example
>    of DSI video source implementation for my version of CDF.
> 
>  - Added Samsung S6E8AX0 DSI panel driver.
> 
>    This is the old Exynos-specific driver, just migrated to CDF and with
>    some hacks to provide control over entity state to userspace using
>    lcd device. However it can be used to demonstrate video source ops in
>    use.
> 
> Feel free to comment as much as you can.
> 
> Tomasz Figa (4):
>   video: add display-core
>   video: add makefile & kconfig
>   video: display: Add exynos-dsi video source driver
>   video: display: Add Samsung s6e8ax0 display panel driver
> 
>  drivers/video/Kconfig                     |    1 +
>  drivers/video/Makefile                    |    1 +
>  drivers/video/display/Kconfig             |   16 +
>  drivers/video/display/Makefile            |    3 +
>  drivers/video/display/display-core.c      |  295 +++++++
>  drivers/video/display/panel-s6e8ax0.c     | 1027 ++++++++++++++++++++++
>  drivers/video/display/source-exynos_dsi.c | 1313 ++++++++++++++++++++++++++
>  include/video/display.h                   |  230 +++++
>  include/video/exynos_dsi.h                |   41 +
>  include/video/panel-s6e8ax0.h             |   41 +
>  10 files changed, 2968 insertions(+)
>  create mode 100644 drivers/video/display/Kconfig
>  create mode 100644 drivers/video/display/Makefile
>  create mode 100644 drivers/video/display/display-core.c
>  create mode 100644 drivers/video/display/panel-s6e8ax0.c
>  create mode 100644 drivers/video/display/source-exynos_dsi.c
>  create mode 100644 include/video/display.h
>  create mode 100644 include/video/exynos_dsi.h
>  create mode 100644 include/video/panel-s6e8ax0.h
-- 
Regards,

Laurent Pinchart
