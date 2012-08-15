From: Jiri Kosina <jkosina@suse.cz>
Date: Wed, 15 Aug 2012 21:32:05 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <alpine.LNX.2.00.1208152329580.7026@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home> <alpine.LNX.2.00.1208151016221.7026@pobox.suse.cz> <20120815114236.0f7db40e@neptune.home> <alpine.LNX.2.00.1208151409500.7026@pobox.suse.cz> <20120815171635.2564a4a8@neptune.home>
In-Reply-To: <20120815171635.2564a4a8@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, 15 Aug 2012, Bruno Pr=E9mont wrote:

> > I see. Alan Stern has fixed a huge pile of things in this area in 3.6-r=
c1.=20
> > I have expected all of those to actually be on theoretical problems not=
=20
> > ever having happened in the wild, but it might be that you are actually=
=20
> > chasing on of those.
> >
> > Could you please retest with latest Linus' tree (or at least eb055fd056=
0b)=20
> > to see whether this hasn't actually been fixed already by Alan's series?
>=20
> I've started trying that out, it seems Alan's work improved things.
>=20
> For the first few attempts I have not seen SLAB corruptions, though after
> a few rounds I hit accumulation of the following messages:
> [  297.174828] hid-picolcd 0003:04D8:C002.0003: output queue full
> [  297.181098] hid-picolcd 0003:04D8:C002.0003: output queue full
> [  297.187820] hid-picolcd 0003:04D8:C002.0003: output queue full
> [  297.194087] hid-picolcd 0003:04D8:C002.0003: output queue full
>=20
> with sporadically in between:
> [  292.668019] hid-picolcd 0003:04D8:C002.0003: usb_submit_urb(out) faile=
d: -1
>=20
> At first glance I think the queue filling up and never draining is caused
> by hid_hw_stop() stalling the queue and the time between both being just =
too
> short.

I don't really understand this explanation. Once usb_kill_urb() returns,=20
the URB should be available for future use (and therefore all queues=20
completely drained).

--=20
Jiri Kosina
SUSE Labs
