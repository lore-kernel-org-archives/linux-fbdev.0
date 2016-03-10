From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 10 Mar 2016 17:54:38 +0000
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Message-Id: <20160310175438.GA5648@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160203145337.GD9650@ulmo>
 <CAD=FV=U_x1cxx6RrHuVgVV8GbOwm9DXXJcyiArbbQySUOaxrvQ@mail.gmail.com>
 <20160222175929.GA23899@ulmo>
 <CAD=FV=UCErW3EjYRtwt49_ztNR7cyY4U0o4R_dxdomer-Ac2Dg@mail.gmail.com>
 <20160223143859.GA27656@ulmo>
 <CAD=FV=UvxG3MYD4MKQJqN7W68uMjd-s+FH-e8tkrLCpS0RLmZQ@mail.gmail.com>
 <20160223181448.GA14754@ulmo.nvidia.com>
 <CAD=FV=VM3cOQ0HqwLANBw9MVBCyFTrSyPe_dGzgPucuMUEWRKA@mail.gmail.com>
 <CAD=FV=VckTVD8b1g+f0G2kMeoTjvY0pAGhoDnWQN_dAmqSxBxg@mail.gmail.com>
 <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
In-Reply-To: <CAD=FV=W3KPf8tyMviVNB9=HjefMdP+FBbN01Zhh7RKH+gkj2WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 08:34:19AM -0800, Doug Anderson wrote:
> Thierry,
>=20
> On Thu, Feb 25, 2016 at 3:14 PM, Doug Anderson <dianders@google.com> wrot=
e:
> > So just to summarize:
> >
> > * Add pwm_get_state(), pwm_apply_state(), pwm_get_args().
> > pwm_get_state() initially returns 0 for duty cycle if driver doesn't
> > support readout.
> >
> > * Re-implement pwm_get_period() (and maybe other similar functions)
> > atop pwm_get_state() as you describe earlier in the thread.
> >
> > * Document pwm_get_period() (and maybe other similar functions) as depr=
ecated.
> >
> > * Fix drivers for all current 2 users of PWM regulator to support
> > hardware readout.
> >
> > * Update PWM regulator as you described earlier in the thread (Feb 23).
> >
> > * If PWM regulator is ever used on a new board whose PWM doesn't
> > support hardware readout, the voltage will change at probe time.
> >
> >
> > Did I get all that right?  Thanks!
>=20
> Can you provide a "yes, you got that right" or a "no, you didn't
> understand"?  That will unblock Boris, I think.

Sounds about right. Hopefully this will eliminate any objections that
others had about the series.

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW4bTZAAoJEN0jrNd/PrOhfFMP/i39c8UFiwiFql3iBo11t0Fl
ZCb1wOtEkvJlJHsE4wdS05PwMtP51e/2k96Swnusv26ODELfBYBRjEAiecuY7pdZ
wpypYzEc/95+2KT5/qJt/bMVhlydF/Gdv45Ri5gXJcTDsmEcVxt1K2C6BsyxUELF
ukSgK6aDeje8cqBkqYkoJ9OpsQFRn8MvVPwhWj3YtiEFape0DZnNVUorJSRH+AGq
9rcfK2lnMMbs0tqCHB8R/QIOhKhdWnOnZc6//M5xAcGaEo0FZFJKvl07Tu2p6LGn
nPgvOUVkyXNekKfU6M7BhRcaQC1P7i5v90PLISxKHcXlXld2Z1jZmXThSy1hXPlb
ZYlG+AXoOTes48yul+HfIj0y9ng+5QnbuWibbkepHHhZTyDLeiLi8ekzNAWoARJ9
Fu0BHuH6afcJroymsI77/SHFn0cSJesTl3yzDT0zrqQ0AWKMvr+qetxn4OUKESSV
qmbDoed9SfrlKFwKKldhuk9L0OallHC0iEetSQTDbaue7opRq4tH1F/4ZtUEeRZW
t7g6ll9NNMILuRQplvT8L1t+CgFtifey+QA69NSm+Q9OZmRWngN1W7N5WbEdj4I5
OdGG1MgLxWPf69v+5iBZezneMsCNxGmkpYKEbDyXFPAaQ+AljQ6crIlj8qnjby2+
w+ceXXTMzJ3e9BfUd6Y0
=HFNr
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
