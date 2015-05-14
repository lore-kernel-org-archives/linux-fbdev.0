From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 14 May 2015 14:26:45 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <20150514142645.GU23057@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6WhVUa-seXOWeY+ELY5v=Rt_6DBfr==GKjP7AH3CTWJAQ@mail.gmail.com>
 <55474AFE.5040605@ti.com>
 <CALCETrVdAG1NFA_dYHhOyCbwKR3msHZaaVs0MZMkW33_Sw=Kqg@mail.gmail.com>
In-Reply-To: <CALCETrVdAG1NFA_dYHhOyCbwKR3msHZaaVs0MZMkW33_Sw=Kqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: cocci@systeme.lip6.fr

On Tue, May 05, 2015 at 06:47:31AM -0700, Andy Lutomirski wrote:
> On Mon, May 4, 2015 at 3:33 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> > On 29/04/15 22:18, Luis R. Rodriguez wrote:
> >> On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
> >> <mcgrof@do-not-panic.com> wrote:
> >>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >>>
> >>> This series addresses simple changes to framebuffer drivers to use
> >>> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
> >>> missing mtrr_del() calls. These changes are pretty straight forward.
> >>>
> >>> Luis R. Rodriguez (17):
> >>>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: gbefb: add missing mtrr_del() calls
> >>>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
> >>>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
> >>>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
> >>>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
> >>
> >> Hey folks, these are all pretty straight forward, can anyone take them?
> >
> > I can take these to fbdev tree. Unfortunately I'm not familiar with x86
> > nor mtrr, so I can't really say much about the patches themselves.
> >
>=20
> I'm on vacation and there's no way I'll be able to usefully review
> these in the next two weeks.  I can describe what's going on in case
> it helps:
>=20
> On x86 there are two ways to get a write-combining MMIO mapping.  The
> sane way is ioremap_wc, and the ridiculous way is mtrr_add.
> ioremap_wc does exactly what it appears to do, whereas mtrr_add acts
> on physical addresses, requires power-of-two alignment, and is
> unreliable.
>=20
> On all recent hardware, ioremap_wc works, and mtrr_add is problematic
> on all hardware even if it often works.  The silly thing is that
> mtrr_add pokes at the registers it uses even on hardware with working
> ioremap_wc.  This causes problems (those resources are a very limited
> resource).
>=20
> The solution I came up with a couple years ago is a new API
> arch_phys_wc_add.  It is a hint that a physical address range should
> be write-combining.  On hardware with working ioremap_wc, it's a
> no-op.  On x86 hardware without working ioremap_wc, it just calls
> mtrr_add.
>=20
> The upshot is that changing mtrr_add with a WC type to
> arch_phys_wc_add is OK as long as the driver also uses ioremap_wc or
> similar _wc APIs.  Once everything has been converted, we can unexport
> mtrr_add, which will have all kinds of benefits.

Tomi,

Any chance you can consider this series again? I realize you say you are
not familiar with MTRR but given its prevalence use on framebuffer device
drivers and since you are a framebuffer subsystem maintainer I think its
perhaps fair to ask one of you become familiar with this stuff, or ask
questions if there are any. If its of any help this patch which adds
ioremap_uc() already got merged and the logic to phase MTRR is described
there too:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=
=E4b6be33c28923d8cde53023e0888b1c5d1a9027

That patch won't even be needed on this series, this series happens to be
straight forward: if you just ioremap_nocache() once and use mtrr_add()
then conver over to ioremap_wc() and use arch_phys_wc_add(). If it already
used ioremap_wc() just convert over from mtrr_add() to arch_phys_wc_add()

Not sure if you will get an Acked-by by x86 folks on this series as they
are busy, but I'm adding bp and hpa just in case.

  Luis
