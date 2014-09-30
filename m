From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 30 Sep 2014 07:46:04 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930074604.GG4081@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9Iq5ULCa7nGtWwZS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140929155718.GD4081@lukather>
 <20140930045957.GA29874@ulmo>
In-Reply-To: <20140930045957.GA29874@ulmo>
To: linux-arm-kernel@lists.infradead.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 06:59:59AM +0200, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 05:57:18PM +0200, Maxime Ripard wrote:
> > On Mon, Sep 29, 2014 at 03:54:00PM +0200, Thierry Reding wrote:
> > > On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
> > > > On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> > > > > > >> Plus, speaking more specifically about the clocks, that won'=
t prevent
> > > > > > >> your clock to be shut down as a side effect of a later clk_d=
isable
> > > > > > >> call from another driver.
> > > > > >=20
> > > > > > > Furthermore isn't it a bug for a driver to call clk_disable()=
 before a
> > > > > > > preceding clk_enable()? There are patches being worked on tha=
t will
> > > > > > > enable per-user clocks and as I understand it they will speci=
fically
> > > > > > > disallow drivers to disable the hardware clock if other drive=
rs are
> > > > > > > still keeping them on via their own referenc.
> > > > > >=20
> > > > > > Calling clk_disable() preceding clk_enable() is a bug.
> > > > > >=20
> > > > > > Calling clk_disable() after clk_enable() will disable the clock=
 (and
> > > > > > its parents)
> > > > > > if the clock subsystem thinks there are no other users, which i=
s what will
> > > > > > happen here.
> > > > >=20
> > > > > Right. I'm not sure this is really applicable to this situation, =
though.
> > > >=20
> > > > It's actually very easy to do. Have a driver that probes, enables i=
ts
> > > > clock, fails to probe for any reason, call clk_disable in its exit
> > > > path. If there's no other user at that time of this particular clock
> > > > tree, it will be shut down. Bam. You just lost your framebuffer.
> > > >=20
> > > > Really, it's just that simple, and relying on the fact that some ot=
her
> > > > user of the same clock tree will always be their is beyond fragile.
> > >=20
> > > Perhaps the meaning clk_ignore_unused should be revised, then. What y=
ou
> > > describe isn't at all what I'd expect from such an option. And it does
> > > not match the description in Documentation/kernel-parameters.txt eith=
er.
> >=20
> > Well, it never says that it also prevent them from being disabled
> > later on. But it's true it's not very explicit.
>=20
> It says:
>=20
> 	Keep all clocks already enabled by bootloader on,
> 	even if no driver has claimed them. ...
>=20
> There's no "until" or anything there, so I interpret that as
> indefinitely.

Well, then, sorry, but that's not how it works.

> > > > > Either way, if there are other users of a clock then they will ju=
st as
> > > > > likely want to modify the rate at which point simplefb will break=
 just
> > > > > as badly.
> > > >=20
> > > > And this can be handled just as well. Register a clock notifier,
> > > > refuse any rate change, done. But of course, that would require hav=
ing
> > > > a clock handle.
> > > >=20
> > > > Now, how would *you* prevent such a change?
> > >=20
> > > Like I said in the other thread. If you have two drivers that use the
> > > same clock but need different frequencies you've lost anyway.
> >=20
> > Except that the driver that has the most logic (ie not simplefb) will
> > have a way to recover and deal with that.
>=20
> You're making an assumption here. Why would the driver have such logic
> if nothing ever prevented it from setting the rate properly before.

I'm not saying it has, but it something that can be done. You usually
have several strategies, which depending on the device, might or might
not be possible, such as reparenting, trying to use an additional
divider.

Worst case scenario, you're indeed doomed. But you do have a best case
scenario, which isn't the case with your approach. And you didn't
screw the framebuffer silently.

> > But sure, you can still try to point new issues, get an obvious and
> > robust solution, and then discard the issue when the solution doesn't
> > go your way...
>=20
> And you've already proven that you're completely unwilling to even
> consider any other solution than what was originally proposed, so I
> really don't see how discussing this further with you is going to be
> productive.

You haven't express *what* you wanted to achieve for quite some time,
but only *how*. And your how has some deficiencies that have already
been pointed out numerous times.

However, I do come to the same conclusion. I really don't see how we
can be productive. Just like I really don't see how we will ever be
able to get any DRM/KMS driver in when the time comes.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKl+8AAoJEBx+YmzsjxAgxVoQAJkM5MOCE7MwdaA6xOPSiity
hSsOPLAa6ugOyAbQTGuWrVfF9HGN6xarHwxalFBKY4DJRv7QTQ/Got7U066GJBbJ
uz9W2o6HOGXqeam27yoHXaGUw1nlD0YnFPYItL9tAXEk4I1fv63LCKo6wPdoY72k
uMYVhu2xexy0hdlydBa/AzSU61Jga/06k1nVqi7re8j6Jb6hZm1iyAFujFl8leOY
9AmVXva7IGfiFnJR6qtR3e8SYhV98W2MhTgH6SCe+M0r6B/F9ithMXHyUOU6p3wc
VvBiwNjSQWlKPRq2Y3RBai6qIBoSLYkXUo7vZ9YUs7UUcx7cBj9QHUdUD5FRMoph
/atF4Rtg1YBfj+0J/zSsV/CqltlCerOpxNp7QbuX1nf/qX7Mjcz7Y5pEgu1l8Nu8
X3DTUXgqRJLYWlvEZrkuURcYy5O3uBhokooEEXv3tvi7vCilCLpiNzihNratidSA
CdDCo+Ts2RqiBDb/hz+kDr9HXheJy7GDur2kvkJvNDQbYRBMsgtrO+3dg5dMU4VM
Td9vyGQCOZi2hX4K5J+U1a4mW2C/o4DYetGPEqS5kteXjglafxrGJVYGQSw7HZ6s
XyGfkQZwUnX2wRFWXaFt88cMBR69pSiqVVo+GYOSfGkDqu+XdkP1mIPI0l8EKI3z
isSHU+sOD71CvoK1KAA0
=1/v+
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
