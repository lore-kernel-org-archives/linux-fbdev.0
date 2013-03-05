From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 05 Mar 2013 05:00:33 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: fixup B side hsync adjust settings
Message-Id: <87vc96moeq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87wqtmmp59.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqtmmp59.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Magnus

> > The lcdc B side horizon output is shifted if sh_mobile_lcdc_pan() was called,
> > since driver didn't care LDHAJR mirror.
> > This patch fixup this issue
> >
> > Reported-by: Osamu Fukushima <osamu.fukushima.wr@renesas.com>
> > Signed-off-by: Hideyuki Sano <hideyuki.sano.dn@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks for this. Would it be possible for you to include information
> about which SoC and board you have tested this on?

I see. will fix in v2 patch
Thank you

Best regards
---
Kuninori Morimoto
