From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Mar 2012 00:12:58 +0000
Subject: Re: [PATCH] fbdev: remove "default y" from FB_SH_MOBILE_MERAM
Message-Id: <87hay2wprv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nu7bcd3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nu7bcd3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi Laurent, Hayama-san

Thank you for your advice

> > On Friday 02 March 2012 01:06:53 Kuninori Morimoto wrote:
> >> "default y" of FB_SH_MOBILE_MERAM was overkill option.
> >> "depends on FB_SH_MOBILE_LCDC" is very enough here.
> > 
> > Actually the sh_mobile_meram driver doesn't depend on the LCDC driver. What 
> > would you think about removing both the dependency and the default=y ?
> 
> I agree with Laurent here. MERAM can be used for other IP blocks as well
> in the future, e.g. the CEU driver. The LCDC was the only driver using
> it, but doesn't necessarily mean that the MERAM driver depends on the
> LCDC. In some case, you might even want to disable MERAM for the LCDC if
> there's not enough memory on MERAM.

Thanks.
I send v2 patch.


Best regards
---
Kuninori Morimoto
