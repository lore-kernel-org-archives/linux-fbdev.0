From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 17 Aug 2016 19:36:42 +0000
Subject: Re: [drm-intel-nightly] 2016y-07m-14d-21h-13m-02s UTC: locking dependency: drm_modeset_lock_all() ||
Message-Id: <1471462602.5173.13.camel@sipsolutions.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUUUUCybFnneuhVVT4Z_vymMcLp4HdCe3CDY5SerFnP+tg@mail.gmail.com>
 <20160715084045.GD1841@nuc-i3427.alporthouse.com>
 <CA+icZUWn+zFjCHT+O6ihb7+kQDmn9N3Y588F45_=U=KYHZsoAw@mail.gmail.com>
In-Reply-To: <CA+icZUWn+zFjCHT+O6ihb7+kQDmn9N3Y588F45_=U=KYHZsoAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>, Chris Wilson <chris@chris-wilson.co.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thorsten Leemhuis <thl@ct.de>

On Wed, 2016-08-17 at 19:27 +0000, Sedat Dilek wrote:
>=C2=A0
> > > The call-trace is reproducible with my setup and seen on every
> > > boot.

Might have been nice to keep the backtrace when adding new people :)

I found it here:
https://lists.freedesktop.org/archives/intel-gfx/2016-July/100695.html

> [ CC Peter, Johannes and Thorsten "The regression reporter" ]
>=20
> Peter has 2 fixes from Johannes in peterz/queue.git#locking/urgent
> which fix the issue for me.
>=20
> [1/2] Revert "drm/fb-helper: Reduce READ_ONCE(master) to
> lockless_dereference"
> [2/2] locking/barriers: suppress sparse warnings in
> lockless_dereference()

I don't see how those could fix it. The second one is a pure compile-
time issue, so it's completely irrelevant - it should not change code
generation in any way.

The first one, reverting to READ_ONCE(), does change the code a bit,
but since lockless_dereference() has no lockdep involvement, I don't
see how that could have any impact on a lockdep report.

Judging from the lockdep report, you have a pretty simple ABBA deadlock
there, but I really don't see how the changes could have any impact.

johannes
