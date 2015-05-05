From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 05 May 2015 07:35:16 +0000
Subject: Re: [PATCH v4 2/6] x86: document WC MTRR effects on PAT / non-PAT pages
Message-Id: <20150505073516.GK5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343851-967-3-git-send-email-mcgrof@do-not-panic.com>
 <20150504122303.GD4096@pd.tnic>
In-Reply-To: <20150504122303.GD4096@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Borislav Petkov <bp@alien8.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, bp@suse.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@intel.com, airlied@linux.ie, dledford@redhat.com, awalls@md.metrocast.net, syrjala@sci.fi, luto@amacapital.net, mst@redhat.com, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Jonathan Corbet <corbet@lwn.net>, Dave Hansen <dave.hansen@linux.intel.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, linux-fbdev@vger.kernel.org

On Mon, May 04, 2015 at 02:23:03PM +0200, Borislav Petkov wrote:
> On Wed, Apr 29, 2015 at 02:44:07PM -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >=20
> > As part of the effort to phase out MTRR use document
> > write-combining MTRR effects on pages with different
> > non-PAT page attributes flags and different PAT entry
> > values. Extend arch_phys_wc_add() documentation to
> > clarify power of two sizes / boundary requirements as
> > we phase out mtrr_add() use.
> >=20
> > Lastly hint towards ioremap_uc() for corner cases on
> > device drivers working with devices with mixed regions
> > where MTRR size requirements would otherwise not
> > enable write-combining effective memory types.
> >=20
> > Cc: Toshi Kani <toshi.kani@hp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Suresh Siddha <sbsiddha@gmail.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Davidlohr Bueso <dbueso@suse.de>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> > ---
> >  Documentation/x86/mtrr.txt      | 18 +++++++++++++++---
> >  Documentation/x86/pat.txt       | 40 +++++++++++++++++++++++++++++++++=
++++++-
> >  arch/x86/kernel/cpu/mtrr/main.c |  3 +++
> >  3 files changed, 57 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/x86/mtrr.txt b/Documentation/x86/mtrr.txt
> > index cc071dc..a111a6c 100644
> > --- a/Documentation/x86/mtrr.txt
> > +++ b/Documentation/x86/mtrr.txt
> > @@ -1,7 +1,19 @@
> >  MTRR (Memory Type Range Register) control
> > -3 Jun 1999
> > -Richard Gooch
> > -<rgooch@atnf.csiro.au>
> > +
> > +Richard Gooch <rgooch@atnf.csiro.au> - 3 Jun 1999
> > +Luis R. Rodriguez <mcgrof@do-not-panic.com> - April 9, 2015
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> > +Phasing MTRR use
>=20
> "Phasing out...".

Fixed all, will send another version.

  Luis
