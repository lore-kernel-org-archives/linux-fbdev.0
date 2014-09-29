From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 29 Sep 2014 13:54:00 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929135358.GC30998@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6zdv2QT/q3FMhpsV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
In-Reply-To: <20140929113436.GA4081@lukather>
To: linux-arm-kernel@lists.infradead.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
> On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> > > >> Plus, speaking more specifically about the clocks, that won't prev=
ent
> > > >> your clock to be shut down as a side effect of a later clk_disable
> > > >> call from another driver.
> > >=20
> > > > Furthermore isn't it a bug for a driver to call clk_disable() befor=
e a
> > > > preceding clk_enable()? There are patches being worked on that will
> > > > enable per-user clocks and as I understand it they will specifically
> > > > disallow drivers to disable the hardware clock if other drivers are
> > > > still keeping them on via their own referenc.
> > >=20
> > > Calling clk_disable() preceding clk_enable() is a bug.
> > >=20
> > > Calling clk_disable() after clk_enable() will disable the clock (and
> > > its parents)
> > > if the clock subsystem thinks there are no other users, which is what=
 will
> > > happen here.
> >=20
> > Right. I'm not sure this is really applicable to this situation, though.
>=20
> It's actually very easy to do. Have a driver that probes, enables its
> clock, fails to probe for any reason, call clk_disable in its exit
> path. If there's no other user at that time of this particular clock
> tree, it will be shut down. Bam. You just lost your framebuffer.
>=20
> Really, it's just that simple, and relying on the fact that some other
> user of the same clock tree will always be their is beyond fragile.

Perhaps the meaning clk_ignore_unused should be revised, then. What you
describe isn't at all what I'd expect from such an option. And it does
not match the description in Documentation/kernel-parameters.txt either.

> > Either way, if there are other users of a clock then they will just as
> > likely want to modify the rate at which point simplefb will break just
> > as badly.
>=20
> And this can be handled just as well. Register a clock notifier,
> refuse any rate change, done. But of course, that would require having
> a clock handle.
>=20
> Now, how would *you* prevent such a change?

Like I said in the other thread. If you have two drivers that use the
same clock but need different frequencies you've lost anyway.

Thierry

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKWR2AAoJEN0jrNd/PrOhcUEP/0jkxqnjA7wPk6lBlOKvHxoV
s41AwC1mz59NB3KCEOifa7thgAFO1ubiGpZO3DwSeP7mxu6pIeCp22/wfnRX3Czt
/6s3JnRccGOIQ2WceXJNBWX34fr+b4JdAiLDfzfsMnncrW7+HzKgft2PZpxbZD6Q
1VNcqSWgQzAkn5QI4sIlKaaf2jVwItAhwT2Ze8SBokhCUY5On8qpGQyw0+vgNQXf
160Gdi7WoirvtpgNq6IqGHh8m04B+LgxQwhJTvS8wql8DrCuVcpzQLlgI8fGQarV
ypQ29KU+BdZuwDbIUV31klZ0/Rb2N/i6cXk0cgyseQddjEitLJggJLonHHcfXK1B
5Qg65bhxDUuf6bbf58ksUJ6wAngbWLPAkIqhYvVGH+DwZym95TLeQ1i0XMDMHCmd
2c9CcfqTIXedlyIpNFUjZ8z5e//20WHn4CVvRPmKylfMhlh5FH+AV9wyO6oi7PV6
zWDgbgRmbAtp6kM4Hy+QIerD2v3hUNceS+65N4/Mq4wbWiq10bAZH8Ago60y7O3t
JnthgPZsgHJ4aSFA5roC8coTnU8joOyMM6/K6gNZ5ZcPgEJgFtvlaq/0VpF0WAMs
pLVNZzSqQazKONZQzUP6AftcPFZYhg44YhPHcc5OuQdaDoYMG5Dx+0s6v2Yt1inc
bkd81BGqjdaD1oY1spal
=J2wS
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
