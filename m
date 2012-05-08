From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 May 2012 04:05:21 +0000
Subject: [PATCH 0/4] fbdev: sh_mobile_hdmi: adds HDMI control register support
Message-Id: <87lil3mi69.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Florian
Cc: Magnus, Guennadi, Simon

These are sh_mobile_hdmi update patches to supporting
HDMI control register on latest SuperH chip

Kuninori Morimoto (4):
      fbdev: sh_mobile_hdmi: add hdmi_bit_set() function
      fbdev: sh_mobile_hdmi: add interrupt output option
      fbdev: sh_mobile_hdmi: 32bit register access support
      fbdev: sh_mobile_hdmi: add HDMI Control Register support

These patches add 32bit access support, and init control registers.
These are tested on Armadillo800eva board

Best regards
---
Kuninori Morimoto
