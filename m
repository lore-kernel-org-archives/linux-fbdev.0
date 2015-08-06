From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 06 Aug 2015 18:41:23 +0000
Subject: [PATCH 0/2] OMAPDSS: Fix of-node refcount issues
Message-Id: <cover.1438885638.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I found couple of refcounting issues related to OMAP DSS of-node
handling. Second patch should fix the "ERROR: Bad of_node_put() on
/encoder@0/ports/port@1" -problem.

In the long run it would make sense start using of_graph_*() functions
in OMAP DSS too. However the semantics of of_graph_*() functions are
quite different from omapdss_of_*() counterparts. So it better to just
fix these bugs first.

Jyri Sarha (2):
  OMAPDSS: dss-of: Fix node refcount leak in omapdss_of_get_next_port()
  OMAPDSS: of-dss: omap_dss_find_output_by_port_node() keep port
    refcount

 drivers/video/fbdev/omap2/dss/dss-of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1

