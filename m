From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 27 Jul 2010 07:20:46 +0000
Subject: Re: [PATCH 0/6 v3] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <w3phbjl4chc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1007211145420.16933@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1007211145420.16933@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> This patch set adds a static HDMI support to SH-Mobile SoCs, specifically, 
> to sh7372 (ap4evb) in this version. "Static" means only 720p is supported 
> ATM. Also hotplug support is implemented without changing the framebuffer 
> geometry. Dynamic geometry reconfiguration is planned for a future patch.
> 
> This series now depends on an arm-shmobile runtime PM RFC patch from 
> Magnus with my incremental patch to it [1].

I tested these Guennadi's HDMI patches + Maguns's V2 PM patch
on genesis tree.
It works well for me !!

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
--
Kuninori Morimoto
 
