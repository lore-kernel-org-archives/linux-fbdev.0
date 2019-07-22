From: Douglas Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2019 18:24:35 +0000
Subject: [PATCH 0/4] video: of: display_timing: Adjust err printing of of_get_display_timing()
Message-Id: <20190722182439.44844-1-dianders@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Russell King <linux@armlinux.org.uk>, Daniel Vetter <daniel@ffwll.ch>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

As reported by Sam Ravnborg [1], after commit b8a2948fa2b3
("drm/panel: simple: Add ability to override typical timing") we now
see a pointless error message printed on every boot for many systems.
Let's fix that by adjusting who is responsible for printing error
messages when of_get_display_timing() is used.

Most certainly we can bikeshed the topic about whether this is the
right fix or we should instead add logic to panel_simple_probe() to
avoid calling of_get_display_timing() in the case where there is no
"panel-timing" sub-node.  If there is consensus that I should move the
fix to panel_simple_probe() I'm happy to spin this series.  In that
case we probably should _remove_ the extra prints that were already
present in the other two callers of of_get_display_timing().

While at it, fix a missing of_node_put() found by code inspection.

NOTE: amba-clcd and panel-lvds were only compile-tested.

[1] https://lkml.kernel.org/r/20190721093815.GA4375@ravnborg.org


Douglas Anderson (4):
  video: of: display_timing: Add of_node_put() in
    of_get_display_timing()
  video: of: display_timing: Don't yell if no timing node is present
  drm: panel-lvds: Spout an error if of_get_display_timing() gives an
    error
  video: amba-clcd: Spout an error if of_get_display_timing() gives an
    error

 drivers/gpu/drm/panel/panel-lvds.c |  5 ++++-
 drivers/video/fbdev/amba-clcd.c    |  4 +++-
 drivers/video/of_display_timing.c  | 11 +++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog
