From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 02 Oct 2014 08:12:38 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141002081236.GA30167@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140930213753.19023.17605@quantum>
 <20141001073043.GA18463@ulmo>
 <CAPtuhTgJ7TLg8CKe3pQiBeEw9s33UrYEXPj6SDCga2yAh7WfEA@mail.gmail.com>
In-Reply-To: <CAPtuhTgJ7TLg8CKe3pQiBeEw9s33UrYEXPj6SDCga2yAh7WfEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 11:17:23AM -0700, Mike Turquette wrote:
> On Wed, Oct 1, 2014 at 12:30 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Sep 30, 2014 at 02:37:53PM -0700, Mike Turquette wrote:
> >> Quoting Thierry Reding (2014-09-29 06:54:00)
> >> > On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
> >> > > On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> >> > > > > >> Plus, speaking more specifically about the clocks, that won=
't prevent
> >> > > > > >> your clock to be shut down as a side effect of a later clk_=
disable
> >> > > > > >> call from another driver.
> >> > > > >
> >> > > > > > Furthermore isn't it a bug for a driver to call clk_disable(=
) before a
> >> > > > > > preceding clk_enable()? There are patches being worked on th=
at will
> >> > > > > > enable per-user clocks and as I understand it they will spec=
ifically
> >> > > > > > disallow drivers to disable the hardware clock if other driv=
ers are
> >> > > > > > still keeping them on via their own referenc.
> >> > > > >
> >> > > > > Calling clk_disable() preceding clk_enable() is a bug.
> >> > > > >
> >> > > > > Calling clk_disable() after clk_enable() will disable the cloc=
k (and
> >> > > > > its parents)
> >> > > > > if the clock subsystem thinks there are no other users, which =
is what will
> >> > > > > happen here.
> >> > > >
> >> > > > Right. I'm not sure this is really applicable to this situation,=
 though.
> >> > >
> >> > > It's actually very easy to do. Have a driver that probes, enables =
its
> >> > > clock, fails to probe for any reason, call clk_disable in its exit
> >> > > path. If there's no other user at that time of this particular clo=
ck
> >> > > tree, it will be shut down. Bam. You just lost your framebuffer.
> >> > >
> >> > > Really, it's just that simple, and relying on the fact that some o=
ther
> >> > > user of the same clock tree will always be their is beyond fragile.
> >> >
> >> > Perhaps the meaning clk_ignore_unused should be revised, then. What =
you
> >> > describe isn't at all what I'd expect from such an option. And it do=
es
> >> > not match the description in Documentation/kernel-parameters.txt eit=
her.
> >>
> >> From e156ee56cbe26c9e8df6619dac1a993245afc1d5 Mon Sep 17 00:00:00 2001
> >> From: Mike Turquette <mturquette@linaro.org>
> >> Date: Tue, 30 Sep 2014 14:24:38 -0700
> >> Subject: [PATCH] doc/kernel-parameters.txt: clarify clk_ignore_unused
> >>
> >> Refine the definition around clk_ignore_unused, which caused some
> >> confusion recently on the linux-fbdev and linux-arm-kernel mailing
> >> lists[0].
> >>
> >> [0] http://lkml.kernel.org/r/<20140929135358.GC30998@ulmo>
> >>
> >> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> >> ---
> >> Thierry,
> >>
> >> Please let me know if this wording makes the feature more clear.
> >
> > I think that's better than before, but I don't think it's accurate yet.
> > As pointed out by Maxime unused clock may still be disabled if it's part
> > of a tree and that tree is being disabled because there are no users
> > left.
>=20
> It is entirely accurate. This feature does in fact "prevent the clock
> framework from *automatically* gating clock ...".

According to what Maxime said if an unused clock is a sibling (has the
same parent) of a clock that is used and then gets disabled, then if the
parent has no other clocks that are enabled, the unused clock will still
be disabled.

That's still counts as "automatically" to me. Not automatically would
mean that the clock needs to be disabled explicitly for it to become
disabled. Disabling it as a side-effect of its parent getting disabled
is still automatic.

> And it was merged by Olof so that he could use simplefb with the
> Chromebook!

And presumably it does work for that specific Chromebook. It seems,
though that for hardware with a somewhat whackier clock tree it doesn't
work so well. As far as I can tell that's the reason for this patch and
the ensuing discussion in the first place.

Although, perhaps nobody ever really tested whether or not the above
scenario was actually a problem for sunxi and maybe clk_ignore_unused
would work for them. But as I understand they don't want to use it, so
this whole debate about this kernel parameter is a bit moot.

> > What I had argued is that it's unexpected behavior, because the clock
> > is still unused (or becomes unused again), therefore shouldn't be
> > disabled at that point either.
>=20
> Leaving clocks enabled because nobody claimed them is not an option.

But that's exactly what clk_ignore_unused is, isn't it? I'm now totally
confused.

> > So if you want to keep the current behaviour where an unused clock can
> > still be disabled depending on what other users do, then I think it'd be
> > good to mention that as a potential caveat.
>=20
> Do you have a suggestion on the wording?

Perhaps something like this:

	Note that if an unused clock shares a parent with clocks that
	are used, the unused clock may still become disabled as a side-
	effect of the parent clock being disabled when none of the
	children that are used remain enabled.

?

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJULQj0AAoJEN0jrNd/PrOh9zEP/1RRetva4IyFI1x8J4vI1z9D
prPi/TVYq2hW6EUlrczf/nCGV16HfAacpJAgDvukQo6WuKgHGipg80oUCSy4nY+i
/EaSO/GtAHQW5+w+2uX+oC9QHiXycEoFyf2FO0zcVtaJwx/Om/3KXSmWIaD+X+/z
5GhcDQ5tsQzxw1J4DgBoXusfisdiImcgTN6mVDddprQTMSqz8dImZgLHpdGXwN9j
Rabeow7zp0KFjcZDQqobTp4Iwjc45SFfdOv4JqrKtyUkUdZNkGhdKKV+5LIia9Up
n2G9whVTmAtGhi3MCndzi6MzqX5B48Lov0oPjyutrfoJlKxmjpVKwlvsBXKrVhiO
fh/51IFVk0gM9WHS/bOfcH5nfEj2a5tlcHohN2NF0niZPWuVQPfu+RB61lhu8GqK
/D2xC/oi++0wQU7V+izNOUGyuK6WqI7g9KHm3ZmMcloBaapl7pLQOodhg0tBDVhL
UxKLQCw+SS4ZRIIyE3/tFuOB6dKTkjMkmdOB1PzcERbIbU/mDT9qwaNRXUCDySfO
sLFMbJANmeMGSt0ZAUsD0TXuX1tCe2lE5dkX57CwenVygexW90LVWaLhXQDNKkkX
TWnXqnSs94CEJ0iL1Sjj9sKsF/n6hsss/gRvqtRkcQQUaBtsmLFdI8Xw93Ms8VQe
x+i3Xan+zkU/G0u/lJo0
=9lkO
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
