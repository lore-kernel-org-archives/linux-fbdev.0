From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 11 May 2011 06:11:05 +0000
Subject: RE: [PATCH 8/8] OMAP: DSS2: OMAPFB: Reduce stack usage
Message-Id: <1305094265.2097.0.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
	 ,<1305044656-31512-9-git-send-email-tomi.valkeinen@ti.com>
	 <CA1B555B4D79E3448D96A7C9847C7D9805EFB4C7@008-AM1MPN1-031.mgdnok.nokia.com>
In-Reply-To: <CA1B555B4D79E3448D96A7C9847C7D9805EFB4C7@008-AM1MPN1-031.mgdnok.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: aaro.koskinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 2011-05-10 at 19:08 +0000, aaro.koskinen@nokia.com wrote:
> Hi,
> 
> Tomi Valkeinen [tomi.valkeinen@ti.com]:
> > omapfb_mode_to_timings() had struct fb_info, struct fb_var and struct
> > fb_ops allocated from stack. This caused the stack usage grow quite
> > high.
> >
> > Use kzalloc to allocate the structs instead.
> 
> [...]
> 
> > +       fbi = kzalloc(sizeof(*fbi), GFP_KERNEL);
> > +       var = kzalloc(sizeof(*var), GFP_KERNEL);
> > +       fbops = kzalloc(sizeof(*fbops), GFP_KERNEL);
> > +       fbi->fbops = fbops;
> 
> You should check and prepare for allocation failures.

So I should. Thanks!

 Tomi


