From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 20 Apr 2011 09:56:31 +0000
Subject: Re: [2.6.39-rc2, framebuffer] use after free oops
Message-Id: <20110420105631.70695dfa@lxorguk.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTi=8U3=E0=j8MJ-r70O_aO8Pxvv9Nw@mail.gmail.com>
	<BANLkTi=F8u7oZM+=W+5vzmvf1b0YiN0fQg@mail.gmail.com>
	<20110420080535.3edd11ac@pluto.restena.lu>
In-Reply-To: <20110420080535.3edd11ac@pluto.restena.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?ISO-8859-14?B?UHLpbW9udA==?= <bonbons@linux-vserver.org>
Cc: Daniel J Blueman <daniel.blueman@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, 20 Apr 2011 08:05:35 +0200
Bruno Pr=E9mont <bonbons@linux-vserver.org> wrote:

> On Wed, 20 Apr 2011 13:50:10 Daniel J Blueman <daniel.blueman@gmail.com> =
wrote:
> > Any ideas on how best to address this issue [0], since it causes
> > silent corruption, or at best crashes?
>=20
> There is probably no easy short-term fix to this...=20

The short term fix would be to deliberately leak the buffer. That should
go into 2.6.39-rc right now with a comment explaining the situation.
Otherwise who knows what corruption may occur to user data if unlucky.

The other 'cheat' might be to tweak the API so the removal API isn't a
'destroy' interface but a 'shut down' and has a matching 'restart' one
for when the intelfb unloads at which point vga16fb can carry on with the
original fb_info 8)

Alan
