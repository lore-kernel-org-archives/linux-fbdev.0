From: James Simmons <jsimmons@infradead.org>
Date: Thu, 11 Mar 2010 02:22:14 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003110212290.13366@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<a5d587fb1003030023l355eab4dtb9f4cd62058dea3e@mail.gmail.com>
	<21d7e9971003030123q2e5d073dj68a81d612e26dc94@mail.gmail.com>
	<a5d587fb1003030232s2c5bf153s5a2b67e47f28a29c@mail.gmail.com>
	<alpine.LFD.2.00.1003101804420.4419@casper.infradead.org>
	<20100310210458.GB4536@sci.fi>
In-Reply-To: <20100310210458.GB4536@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>


> > > There are other drivers that support multihead already (matroxfb, any
> > > other?) and have their own driver-specific inteface.
> >=20
> > Each crtc is treated as a seperate fbdev device. I don't recall any=20
> > special ioctls. Maybe for mirroring which was never standardized.
>=20
> matroxfb does have a bunch of custom ioctls to change the crtc<->output
> mapping.=20

Yes the mapping issue were never address.

> I don't think the CRTC=FB_info makes much sense if the main use
> case is fbcon.

Actually that is what I had in mind when I reworked the fbdev api. Plus=20
with the linux console project I got multiple VTs working at the same=20
time.

> fbcon will use a single fb device and so you can't see
> the console on multiple heads anyway which makes the whole thing
> somewhat pointless. And if you're trying to do something more complex
> you will be a lot better off bypassing fbdev altogether.

Not true. You can map different displays to different vcs. Give con2fb a=20
try some time :-) Now there is the issue of more than one keyboard being=20
mapped at a time. BTW I did getting multipe VT working at the same=20
time working in the past. It requires some cleanup on the console layer.
