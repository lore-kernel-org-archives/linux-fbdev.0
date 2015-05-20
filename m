From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 20 May 2015 18:58:33 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <20150520185833.GX23057@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6WhVUa-seXOWeY+ELY5v=Rt_6DBfr==GKjP7AH3CTWJAQ@mail.gmail.com>
 <55474AFE.5040605@ti.com>
 <CALCETrVdAG1NFA_dYHhOyCbwKR3msHZaaVs0MZMkW33_Sw=Kqg@mail.gmail.com>
 <20150514142645.GU23057@wotan.suse.de> <555C4ADE.6030400@ti.com>
In-Reply-To: <555C4ADE.6030400@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: cocci@systeme.lip6.fr

On Wed, May 20, 2015 at 11:50:38AM +0300, Tomi Valkeinen wrote:
>=20
>=20
> On 14/05/15 17:26, Luis R. Rodriguez wrote:
>=20
> > Tomi,
> >=20
> > Any chance you can consider this series again? I realize you say you are
> > not familiar with MTRR but given its prevalence use on framebuffer devi=
ce
> > drivers and since you are a framebuffer subsystem maintainer I think its
> > perhaps fair to ask one of you become familiar with this stuff, or ask
> > questions if there are any. If its of any help this patch which adds
> > ioremap_uc() already got merged and the logic to phase MTRR is described
> > there too:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit=
/?id=E4b6be33c28923d8cde53023e0888b1c5d1a9027
> >=20
> > That patch won't even be needed on this series, this series happens to =
be
> > straight forward: if you just ioremap_nocache() once and use mtrr_add()
> > then conver over to ioremap_wc() and use arch_phys_wc_add(). If it alre=
ady
> > used ioremap_wc() just convert over from mtrr_add() to arch_phys_wc_add=
()
> >=20
> > Not sure if you will get an Acked-by by x86 folks on this series as they
> > are busy, but I'm adding bp and hpa just in case.
>=20
> These are now queued for 4.2. Sorry it took so long. I've been away and
> my bandwidth for the fbdev maintainership has been rather limited lately.

Great thanks for the heads up!

  Luis
