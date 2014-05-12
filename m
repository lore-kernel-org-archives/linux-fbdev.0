From: Jyri Sarha <jsarha@ti.com>
Date: Mon, 12 May 2014 09:12:18 +0000
Subject: [PATCH 07/19] OMAPDSS: hdmi5_core: Fix compilation with OMAP5_DSS_HDMI_AUDIO
Message-Id: <6e02441be6a699e4376e547ae99515d14079850d.1399884780.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1399884780.git.jsarha@ti.com>
In-Reply-To: <cover.1399884780.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Use correct variable name for base address.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
index 270ebdd..af88e3c 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5_core.c
@@ -786,7 +786,7 @@ static void hdmi5_core_audio_config(struct hdmi_core_data *core,
 	REG_FLD_MOD(base, HDMI_CORE_AUD_GP_POL, 1, 0, 0);
 
 	/* unmute audio */
-	REG_FLD_MOD(core_sys_base, HDMI_CORE_FC_AUDSCONF, 0, 7, 4);
+	REG_FLD_MOD(base, HDMI_CORE_FC_AUDSCONF, 0, 7, 4);
 }
 
 static void hdmi5_core_audio_infoframe_cfg(struct hdmi_core_data *core,
-- 
1.7.9.5

