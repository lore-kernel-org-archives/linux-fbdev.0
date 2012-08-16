From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Thu, 16 Aug 2012 16:30:21 +0000
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Message-Id: <20120816183021.68c37f37@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home>
	<alpine.LNX.2.00.1208151016221.7026@pobox.suse.cz>
	<20120815114236.0f7db40e@neptune.home>
	<alpine.LNX.2.00.1208151409500.7026@pobox.suse.cz>
	<20120815171635.2564a4a8@neptune.home>
	<alpine.LNX.2.00.1208152329580.7026@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1208152329580.7026@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, 15 August 2012 Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 15 Aug 2012, Bruno Pr=C3=A9mont wrote:
> > > I see. Alan Stern has fixed a huge pile of things in this area in 3.6=
-rc1.=20
> > > I have expected all of those to actually be on theoretical problems n=
ot=20
> > > ever having happened in the wild, but it might be that you are actual=
ly=20
> > > chasing on of those.
> > >
> > > Could you please retest with latest Linus' tree (or at least eb055fd0=
560b)=20
> > > to see whether this hasn't actually been fixed already by Alan's seri=
es?
> >=20
> > I've started trying that out, it seems Alan's work improved things.
> >=20
> > For the first few attempts I have not seen SLAB corruptions, though aft=
er
> > a few rounds I hit accumulation of the following messages:
> > [  297.174828] hid-picolcd 0003:04D8:C002.0003: output queue full
> > [  297.181098] hid-picolcd 0003:04D8:C002.0003: output queue full
> > [  297.187820] hid-picolcd 0003:04D8:C002.0003: output queue full
> > [  297.194087] hid-picolcd 0003:04D8:C002.0003: output queue full
> >=20
> > with sporadically in between:
> > [  292.668019] hid-picolcd 0003:04D8:C002.0003: usb_submit_urb(out) fai=
led: -1
> >=20
> > At first glance I think the queue filling up and never draining is caus=
ed
> > by hid_hw_stop() stalling the queue and the time between both being jus=
t too
> > short.
>=20
> I don't really understand this explanation. Once usb_kill_urb() returns, =

> the URB should be available for future use (and therefore all queues=20
> completely drained).

I won't have time today to check, though my guess is that on each
echo $usb-id > bind; echo $usb-id > unbind
under /sys/bus/hid/drivers/hid-picolcd/ the USB urb queue fills a bit does
not get cleared.

Is usb_kill_urb() called when unbinding just the specific hid driver? If so
my short timing between bind/unbind must be triggering something else...

Otherwise I'm missing something as at first time I got no "output queue ful=
l"
messages, but as I repeated the bind/unbind sequences the prints per bind/u=
nbind
iteration increased in number.

Anyhow, on Friday evening/week-end I will continue digging and report back =
with my
findings.

Thanks,
Bruno
