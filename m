From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Wed, 28 Nov 2012 10:53:23 +0000
Subject: [PATCH 0/7] OMAPDSS: Cleanup omap_dss_features
Message-Id: <cover.1354086150.git.cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone,
this patch series aims at cleaning up of dss_features.c by moving features to
respective submodule drivers.

The 1st patch
 * moved struct omap_dss_features members burst_size_unit and buffer_size_unit
   to dispc_features
The 2nd patch
 * added definition of struct register_field
 * created enum dispc_feat_reg_field
 * moved data from dss_reg_fields to dispc_reg_fields
The 3rd patch
 * added definition of struct param_range
 * created enum dispc_range_param
 * moved data from dss_param_range to dispc_param_range
The 4th patch
 * created struct feats and initialized dsi_feats
 * created enum dsi_feat_reg_field
 * moved data from dss_reg_fields to dsi_reg_fields
 * created dsi_init_features() to initialize dsi_feats
The 5th patch
 * created enum dsi_range_param
 * moved data from dss_param_range to dsi_param_range
The 6th patch
 * added members fld_dispc_clk_switch and dss_fck_max to struct dss_features
   and initialized corresponding dss_feats
 * removed definition of dss_reg_field
 * removed respective omap2_dss_reg_fields, omap3_dss_reg_fields,
   omap4_dss_reg_fields and omap5_dss_reg_fields
 * removed members reg_fields and num_reg_fields from struct omap_dss_features
 * removed enum dss_feat_reg_field
 * removed function dss_feat_get_reg_field()
The 7th patch
 * added FEAT_PARAM_DSS_FCK to enum dsi_param_range and initialized
   corresponding elements in dsi_param_range
 * removed struct dss_param_range
 * removed enum dss_range_param
 * removed functions dss_feat_get_param_min() and dss_feat_get_param_max()

All your comments and suggestions are welcome.

I have based my patches on git://gitorious.org/linux-omap-dss2/linux.git master

Reference Tree:
git://gitorious.org/linux-omap-dss2/chandrabhanus-linux.git dss_cleanup

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (7):
  OMAPDSS: DISPC: Move burst_size and buffer_size to dispc_features
  OMAPDSS: DISPC: Move DISPC specific dss_reg_fields to dispc_features
  OMAPDSS: DISPC: Move DISPC specific dss_params to dispc_features
  OMAPDSS: DSI: Move DSI specific reg_fields to dsi_feats
  OMAPDSS: DSI: Move DSI specific dss_params to dsi_feats
  OMAPDSS: DSS: Add members fld_dispc_clk_switch and dss_fck_max
  OMAPDSS: DSI: Add FEAT_PARAM_DSS_FCK

 drivers/video/omap2/dss/dispc.c        |  188 ++++++++++++++++++++++------
 drivers/video/omap2/dss/dsi.c          |  198 ++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss.c          |   22 +++-
 drivers/video/omap2/dss/dss.h          |    8 ++
 drivers/video/omap2/dss/dss_features.c |  212 --------------------------------
 drivers/video/omap2/dss/dss_features.h |   36 ------
 6 files changed, 358 insertions(+), 306 deletions(-)

-- 
1.7.10

