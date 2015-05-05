From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 05 May 2015 00:22:28 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <20150505002228.GF5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6WhVUa-seXOWeY+ELY5v=Rt_6DBfr==GKjP7AH3CTWJAQ@mail.gmail.com>
 <55474AFE.5040605@ti.com>
In-Reply-To: <55474AFE.5040605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Mon, May 04, 2015 at 01:33:34PM +0300, Tomi Valkeinen wrote:
> On 29/04/15 22:18, Luis R. Rodriguez wrote:
> > On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
> > <mcgrof@do-not-panic.com> wrote:
> >> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >>
> >> This series addresses simple changes to framebuffer drivers to use
> >> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
> >> missing mtrr_del() calls. These changes are pretty straight forward.
> >>
> >> Luis R. Rodriguez (17):
> >>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: gbefb: add missing mtrr_del() calls
> >>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
> >>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
> >>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
> >>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
> > 
> > Hey folks, these are all pretty straight forward, can anyone take them?
> 
> I can take these to fbdev tree.

That'd be great!

> Unfortunately I'm not familiar with x86
> nor mtrr, so I can't really say much about the patches themselves.

Boris or Andy, I think you guy are more active from the x86 side,
a secondary Reviewed-by on this series other my own SOB would be
appreciated.

 Luis
