From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 02 Apr 2015 20:55:21 +0000
Subject: Re: [PATCH v1 06/47] mtrr: add __arch_phys_wc_add()
Message-Id: <20150402205520.GX5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-7-git-send-email-mcgrof@do-not-panic.com>
 <CAErSpo7wazwgkEHkLixA88Lcq1Te564Xdd6k=6292JdT3hu8pw@mail.gmail.com>
In-Reply-To: <CAErSpo7wazwgkEHkLixA88Lcq1Te564Xdd6k=6292JdT3hu8pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, Apr 02, 2015 at 03:21:22PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 20, 2015 at 6:17 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >
> > Ideally on systems using PAT we can expect a swift
> > transition away from MTRR. There can be a few exceptions
> > to this, one is where device drivers are known to exist
> > on PATs with errata,
> 
> This probably makes sense to someone steeped in MTRR and PAT, but not
> otherwise.  "One exception is where drivers are known to exist on PATs
> with errata"?  The drivers exist, independent of PAT/MTRR/errata.  Do
> you mean there are drivers that can't be converted from MTRR to PAT
> because some PATs are broken?

Well there is that but it seems we have motivation to
address the PAT broken systems so this would be one of the
lower priority reasons to consider adding this API. The
more important reason is below.

> I don't really know anything about MTRR or PAT; I'm just trying to
> figure out how to parse this paragraph.

Sure.

> > another situation is observed on
> > old device drivers where devices had combined MMIO
> > register access with whatever area they typically
> > later wanted to end up using MTRR for on the same
> > PCI BAR. This situation can still be addressed by
> > splitting up ioremap'd PCI BAR into two ioremap'd
> > calls, one for MMIO registers, and another for whatever
> > is desirable for write-combining -- in order to
> > accomplish this though quite a bit of driver
> > restructuring is required.
> >
> > Device drivers which are known to require large
> > amount of re-work in order to split ioremap'd areas
> > can use __arch_phys_wc_add() to avoid regressions
> > when PAT is enabled.
> >
> > For a good example driver where things are neatly
> > split up on a PCI BAR refer the infiniband qib
> > driver. For a good example of a driver where good
> > amount of work is required refer to the infiniband
> > ipath driver.
> >
> > This is *only* a transitive API -- and as such no new
> > drivers are ever expected to use this.
> 
> "transient"?  Do you mean you intend to remove this API in the near future?

That's correct, the problem is that in order to use PAT cleanly we'd need to
change these drivers to not overlap ioremap'd areas otherwise things can get
quite complex, and changing the way we do the ioremap() calls on a driver might
require a bit of work. The atyfb driver changes I did are an example of the
types of changes that are expected.  In the most complex worst cases there are
MTRR "hole" tricks used, and as can be observed with the atyfb driver changes
there are a series of things to consider when this is done specially in light
of eventually making strong UC the default instead of UC-.

I might be able to work around not adding this API by reviewing the users I had
in this series again and seeing if something similar to what I will do on atyfb
can be done in the meantime by using ioremap_uc(). Its not clear to me yet.

  Luis
