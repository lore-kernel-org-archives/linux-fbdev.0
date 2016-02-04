From: Mark Brown <broonie@kernel.org>
Date: Thu, 04 Feb 2016 11:02:03 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20160204110203.GL4455@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LR9UEBmNK407lwl9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <2341981.a79ioYM9Es@diego> <20151110173416.GB21727@ulmo>
 <CAD=FV=WL3jYEgVe-m6QcAyQwfJgdX4J5OtKisKwyoKOrTSpEQA@mail.gmail.com>
 <20160125170855.GA10182@ulmo>
 <CAD=FV=Xvxeqo3imUmjukC5iYk3EZkrJ04G7C1B-w4xyr-r6-2Q@mail.gmail.com>
 <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
In-Reply-To: <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--LR9UEBmNK407lwl9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 03, 2016 at 11:04:20AM -0800, Doug Anderson wrote:

> Sure.  ...but you agree that somehow you need a new API call for this,
> right?  Somehow the PWM regulator needs to be able to say that it
> wants the hardware state, not the initial state as specified in the
> device tree.

Wouldn't the most direct way to do that be to just not specify anything
in the DT?  If there *is* something in DT but we ignore it that's a bit
weird.

--LR9UEBmNK407lwl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWsy+qAAoJECTWi3JdVIfQasQH/jly2TuqsSN80W79jFE40xcP
EjcALazQvBo6F7kQRHkoN7oOkWy296LiyTlZwmDsbTZ9B+LK9UEKXEbXIwVlLQwl
eEa+15AX+Ie3hadCAesTlNu53xBD7tSgmSnDuW8KZOhA0muY3pXphZ7ALzf5YbjJ
dOXSegG8NkdfoIpf0WUn9Q77BlH+ElKY/bqUu+qa486oGf4WNXqRBxnvUjQON8jG
wnWeWpSTRJLv2NHh/dE1FpTtLGySioUEUsQGa9A4/AgL4eABrHkyVQ8UPdcOTjtC
2D6RCtFzyPCPwaiOd2MgKWE2eIrPU+rFTH6Fytb0Q01k29XPB5SeqjEMDzaOKNM=
=TeUF
-----END PGP SIGNATURE-----

--LR9UEBmNK407lwl9--
