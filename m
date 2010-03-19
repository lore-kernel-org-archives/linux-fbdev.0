From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Date: Fri, 19 Mar 2010 12:23:13 +0000
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
Message-Id: <20100319122313.GO18243@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
 <20100317173407.GD30422@localhost>
 <20100317201425.GI18243@nokia.com>
 <20100318085239.GE30422@localhost>
 <20100318152604.GM18243@nokia.com>
 <20100319074604.GA19537@localhost>
In-Reply-To: <20100319074604.GA19537@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 19, 2010 at 08:46:04AM +0100, Deak Imre (Nokia-D/Helsinki) wrot=
e:
> On Thu, Mar 18, 2010 at 04:26:04PM +0100, Syrjala Ville (Nokia-D/Helsinki=
) wrote:
> > [...]
> > > > Just tried it and seems to be mostly OK. We get lockdep checking as=
 a
> > > > bonus. It didn't like setup_plane taking the same rwsem twice so I
> > > > added a check to see if the old and new regions are the same and ju=
st
> > > > lock once in that case. I thought rwsem was supposed to be OK with
> > > > read recursion but perhaps I was mitaken, or perhaps it's just lock=
dep
> > > > that's misbehaving.
> > >=20
> > > Ah ok, so it's not so obvious change. Nested read locks could really =
lead
> > > to a deadlock I think. A read lock will block if there is a write wai=
ter
> > > in the queue to avoid write starvation..
> >=20
> > Yes but I think in out case it should be fine because if we hit this:
> >=20
> >  t  thread 1     thread 2
> >  |
> >  |  down_read(0)
> >  |               down_write(1)
> >  v  down_read(1)
> >=20
> > then thread 2 will eventually do a up_write() without taking any
> > other region rwsem, and thread 1 can then continue.
>=20
> Yes and things will work fine with the extra ordering you added. But
> lockdep was right in that without the ordering you can get - the not
> too likely - scenario:
>=20
> t thread 1        thread 2       thread 3      thread 4
> | down_read(0)
> |                 down_write(0)
> |                                down_read(1)
> |                                              down_write(1)
> | down_read(1)
> v                                down_read(0)

Right. I didn't actually consider the case with so many threads. It's
good that lockdep was smarter than me :)

--=20
Ville Syrj=E4l=E4
