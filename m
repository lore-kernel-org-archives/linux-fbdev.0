From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 25 Sep 2013 11:51:30 +0000
Subject: [PATCH 0/2] video: of: display_timing: fixes
Message-Id: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

Hi,

Those two independent patches fixes DT display_timings related code.
The first patch replaces of_find_node_by_name by of_get_child_by_name.
Usage of of_find_node_by_name in such context is incorrect:
- we need only direct child, and this function looks for following nodes
  on implementation internal list regardless of the hierarchy,
- there is no warranty that child nodes are after parent nodes in
  this search order, it happens to be true for DT created from FDT,
  but it is not true for dynamic DT.

The second patch just removes unused/broken function.

Regards
Andrzej

Andrzej Hajda (2):
  video: of: display_timing: correct display-timings node finding
  video: of: display_timing: remove broken of_display_timings_exist

 drivers/video/of_display_timing.c | 26 +++-----------------------
 include/video/of_display_timing.h |  1 -
 2 files changed, 3 insertions(+), 24 deletions(-)

-- 
1.8.1.2

