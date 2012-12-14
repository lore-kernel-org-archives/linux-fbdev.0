From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Dec 2012 14:27:26 +0000
Subject: [RFC 0/6] Common Display Framework-T
Message-Id: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

I have been testing Common Display Framework on OMAP, and making changes that
I've discussed in the posts I've sent in reply to the CDF series from Laurent.
While my CDF code is rather hacky and not at all ready, I wanted to post the
code for comments and also as a reference code to my posts.

So here is CDF-T (Tomi-edition =). 

Changes compared to Laurent's CDF
---------------------------------

- DBI bus is removed. I don't have any DBI devices, and as I said in my posts,
  I didn't see need for a real bus for DBI (or DSI). I thus also removed the
  DBI panels.

- Split the display_entity into two parts: video_source, which is used to
  connect the display chips and panels, and display_entity, which represent
  either the panel or the whole pipeline (I'm not sure which is better).

- Added ops for DVI and DSI

- Added driver for TFP410, a DPI to DVI converter chip
- Added driver for generic DVI monitor
- Added driver for Taal, a DSI command mode panel

- Removed DISPLAY_ENTITY_STREAM_SINGLE_SHOT, and instead there's update() op.
  It's perhaps possible to use the single-shot method, but I went for a
  separate op to get a "update done"-callback implemented easily.

Notes about the code
--------------------

As I said, the code is rather untidy, but I think it's more or less
understandable. I've skipped adding any helper funcs, for example to call the
ops, so it's easier for me to change the API.

I also (ab)used some of the omapdss panel headers to ease my hacking for
omapdss+cdf. These should be quite clear.

The code, including hacks to omapdss to make it use CDF, can be found from:
git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model-cdf

The DSI part is very unfinished. I am able to use it to start up the Taal
panel, and send frames to the panel, but it's really missing lots of stuff.

About display_entity & video_source
-----------------------------------

I've discussed this split in previous posts, but I'll describe it here again.

As I see it, the connections between the display blocks, and the use of the
panel (and thus the whole pipeline) are very different things, and I think they
should be separated. So in my version I have struct video_source, used to
connect the blocks, and display_entity, representing the panel or the whole
pipeline. display_entity is probably not a good name for it anymore, but I
didn't come up with a good one yet.

As an example, let's look at chip-tfp410.c and panel-dvi.c.

tfp410 uses two video_sources, one for input and one for output. The input
comes from some other display block, in my case from OMAP display subsystem.
OMAP DSS has registered a DPI video_source, and the tfp410 driver will get this
source using video_source_find().

tfp410 registers its output as a video source, using video_source_register.
panel-dvi will in turn use video_source_find() to get it.

Both drivers use video_source to configure the input bus, i.e. tfp410
configures the DPI bus between OMAP DSS and TFP410 using, for example,
set_data_lines op to configure the number of datalines on the DPI bus.

With the video_sources in place, the whole video pipeline can be used. However,
we still need to expose an API so that somebody can actually use the pipeline.
This is done with display_entity. display_entity contains higher level ops,
which are not bus specific. The display_entity is registered by the panel at
the end of the chain.

In my model the display_entity ops go to the panel driver, which then calls ops
in the input video source to do the work. Laurent has objected to this model,
and would rather have the display_entity ops go to the DSS side (if I
understood right), which would then propagate forward towards the panel. I have
still kept my model, as I don't see the downsides with my model, nor do I see
any use for propagating the ops from DSS to the panel. But I'm happy to hear
examples how it is beneficial and could be used.


About the bus model
-------------------

Lauren't version uses a linux bus for DBI. The idea here is that DBI is the
control bus fro the panel/chip, and should thus be represented by a real bus.
While I agreed to this approach when we discussed about it, I now am slightly
against it.

My reason is that DBI (or DSI or any other similar bus) is not really control
bus, it is a video bus. It _can_ be used for control, but video is the main
purpose. This has the partical issues:

- There's never use for DBI only for control. DBI is always used for either
  video only, or control+video.

- If DBI is used only for video, there's no DBI bus. How to configure DBI in
  this case?

- If DBI is used for control and video, we have two separate APIs for the bus.
  In theory it's possible to handle this, but in practice it may be impossible,
  especially for more complex busses like DSI.

So in my version I added DSI as a plain video_source, without a real linux bus.
I think this model is a lot simpler, and works better.

 Tomi

Tomi Valkeinen (6):
  video: add display-core
  video: add generic dpi panel
  video: add tfp410
  video: add generic dvi monitor
  video: add taal panel
  video: add makefile & kconfig

 drivers/video/Kconfig                |    1 +
 drivers/video/Makefile               |    1 +
 drivers/video/display/Kconfig        |   26 +++
 drivers/video/display/Makefile       |    5 +
 drivers/video/display/chip-tfp410.c  |  164 +++++++++++++++
 drivers/video/display/display-core.c |  207 ++++++++++++++++++
 drivers/video/display/panel-dpi.c    |  155 ++++++++++++++
 drivers/video/display/panel-dvi.c    |  164 +++++++++++++++
 drivers/video/display/panel-taal.c   |  383 ++++++++++++++++++++++++++++++++++
 include/video/display.h              |  166 +++++++++++++++
 include/video/omap-panel-nokia-dsi.h |    4 +-
 include/video/omap-panel-tfp410.h    |    4 +
 include/video/panel-dpi.h            |   25 +++
 include/video/panel-dvi.h            |   18 ++
 14 files changed, 1321 insertions(+), 2 deletions(-)
 create mode 100644 drivers/video/display/Kconfig
 create mode 100644 drivers/video/display/Makefile
 create mode 100644 drivers/video/display/chip-tfp410.c
 create mode 100644 drivers/video/display/display-core.c
 create mode 100644 drivers/video/display/panel-dpi.c
 create mode 100644 drivers/video/display/panel-dvi.c
 create mode 100644 drivers/video/display/panel-taal.c
 create mode 100644 include/video/display.h
 create mode 100644 include/video/panel-dpi.h
 create mode 100644 include/video/panel-dvi.h

-- 
1.7.10.4

