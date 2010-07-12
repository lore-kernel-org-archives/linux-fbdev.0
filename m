From: Jiri Kosina <jkosina@suse.cz>
Date: Mon, 12 Jul 2010 16:09:49 +0000
Subject: Re: [PATCH 1/4 - adjusted changelog] HID: picolcd: fix deferred_io
Message-Id: <alpine.LNX.2.00.1007121809170.4741@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home> <AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com> <20100510080047.5adade6f@pluto.restena.lu> <20100526215829.28a4aa47@neptune.home> <20100530130945.5c03797f@neptune.home> <20100623123225.4c16e653@neptune.home>
 <alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz> <20100628222641.489c955a@neptune.home> <20100628222920.1127f8eb@neptune.home> <AANLkTingjmM4OmkdXl9IOUe5zsj0QxTdix1h34pVHWGl@mail.gmail.com> <20100630075657.47a325a6@pluto.restena.lu> <20100630223631.49ab1c85@neptune.home>
 <alpine.LNX.2.00.1007112258270.4741@pobox.suse.cz> <20100712081711.25793f9d@pluto.restena.lu> <alpine.LNX.2.00.1007121804290.4741@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1007121804290.4741@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 12 Jul 2010, Jiri Kosina wrote:

> > > > Adjust ordering if framebuffer (un)registration and defio
> > > > init/cleanup to match the correct order (init defio, register
> > > > FB ... unregister FB, cleanup defio)
> > > >=20
> > > > Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> > > > Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> > > > ---
> > > > I consider Jaya's reply as an ack to the patch.
> > >=20
> > > Applied, thanks Bruno.
> >=20
> > Thanks for applying, what about the 3 other patches of the series?
>=20
> Hi Bruno,
>=20
> I have come from vacation, so I have quite some backlog, but will get to =

> your patches hopefully soon. Thanks for patience.

OK, I have now applied the patches. Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
