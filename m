From: Marek Vasut <marex@denx.de>
Date: Mon, 18 Mar 2013 13:58:17 +0000
Subject: Re: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
Message-Id: <201303181458.17656.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <51471293.5070105@freescale.com>
 <20130318130108.GE12462@S2101-09.ap.freescale.net>
In-Reply-To: <20130318130108.GE12462@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Dear Shawn Guo,

> On Mon, Mar 18, 2013 at 10:11:47AM -0300, Fabio Estevam wrote:
> > Shawn Guo wrote:
> > > Since it touches mach-mxs as well, let me send it through arm-soc tree
> > > as fix for 3.9.
> > 
> > Please CC stable as well, so that we can have X11 functional with 3.8.
> 
> Ok, done.

Shawn, I think this patch applies to 3.9-rc but there's one more platform in 
mach-mxs.c in 3.9-rc thus this will have compile issue. Just renaming those two 
FB_SYNC_ values to MXSFB_SYNC_ fixes the compile issue on 3.9-rc. Also the 
commit log doesn't look all that cool .... I probably should have marked the 
patch as RFC.

Shall I send you one for 3.9-rc and one for stable maybe ?

Best regards,
Marek Vasut
