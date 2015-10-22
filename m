From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2015 14:38:48 +0000
Subject: Re: [GIT PULL] On-demand device probing
Message-Id: <20151022143848.GB21861@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com>
 <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
 <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
 <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
In-Reply-To: <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>Jingoo Han <j>

On Thu, Oct 22, 2015 at 11:05:11AM +0200, Tomeu Vizoso wrote:
> On 21 October 2015 at 23:50, Frank Rowand <frowand.list@gmail.com> wrote:
> > On 10/21/2015 2:12 PM, Rob Herring wrote:
> >> On Wed, Oct 21, 2015 at 1:18 PM, Frank Rowand <frowand.list@gmail.com>=
 wrote:
> >>> On 10/21/2015 9:27 AM, Mark Brown wrote:
> >>>> On Wed, Oct 21, 2015 at 08:59:51AM -0700, Frank Rowand wrote:
> >>>>> On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:
> >>>>
> >>>>>> To be clear, I was saying that this series should NOT affect total
> >>>>>> boot times much.
> >>>>
> >>>>> I'm confused.  If I understood correctly, improving boot time was
> >>>>> the key justification for accepting this patch set.  For example,
> >>>>> from "[PATCH v7 0/20] On-demand device probing":
> >>>>>
> >>>>>    I have a problem with the panel on my Tegra Chromebook taking lo=
nger
> >>>>>    than expected to be ready during boot (St=E9phane Marchesin repo=
rted what
> >>>>>    is basically the same issue in [0]), and have looked into ordered
> >>>>>    probing as a better way of solving this than moving nodes around=
 in the
> >>>>>    DT or playing with initcall levels and linking order.
> >>>>>
> >>>>>    ...
> >>>>>
> >>>>>    With this series I get the kernel to output to the panel in 0.5s,
> >>>>>    instead of 2.8s.
> >>>>
> >>>> Overall boot time and time to get some individual built in component=
 up
> >>>> and running aren't the same thing - what this'll do is get things up
> >>>> more in the link order of the leaf consumers rather than deferring t=
hose
> >>>> leaf consumers when their dependencies aren't ready yet.
> >>>
> >>> Thanks!  I read too much into what was being improved.
> >>>
> >>> So this patch series, which on other merits may be a good idea, is as
> >>> a by product solving a specific ordering issue, moving successful pan=
el
> >>> initialization to an earlier point in the boot sequence, if I now
> >>> understand more correctly.
> >>>
> >>> In that context, this seems like yet another ad hoc way of causing the
> >>> probe order to change in a way to solves one specific issue?  Could
> >>> it just as likely move the boot order of some other driver on some
> >>> other board later, to the detriment of somebody else?
> >>
> >> Time to display on is important for many products. Having the console
> >> up as early as possible is another case. CAN bus is another. This is a
> >> real problem that is not just bad drivers.
> >
> > Yes, I agree.
> >
> > What I am seeing is that there continues to be a need for the ability
> > to explicitly order at least some driver initialization (at some
> > granularity), despite the push back against explicit ordering that
> > has been present in the past.
>=20
> The important point that I have struggled to explain is that right now
> for downstreams to influence the order in which devices are probed,
> they have to carry a substantial amount of patches that cannot be ever
> upstreamed. This fiddling with initcall levels and link order means
> changing files that are very frequently changing, increasing the
> amount of work when rebasing and increasing the probability of
> regressions after a rebase.
>=20
> This just adds up to other shortcomings of mainline and ends up with
> the net result of vendors getting stuck with 3.4 kernels on SoCs that
> start production in 2015. Another consequence is that vendors don't
> have a chance to upstream their stuff even if they cared. The
> overarching goal of the project I'm in is to reduce those shortcomings
> that downstreams have to workaround, to facilitate their involvement
> upstream.

The init order of drivers has no influence at all on the ability for
companies to have their individual drivers merged upstream, please don't
be so dramatic about this.

Worst case, a vendor keeps a single patch to drivers/Makefile in their
tree that reorders things, yes it will get conflicts on every release,
but really, it's trivial to maintain if they wish to keep doing this
type of thing.

Again, it is _not_ the reason that we are living with 2million+ lines of
code in vendor kernels.

thanks,

greg k-h
