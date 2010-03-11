From: James Simmons <jsimmons@infradead.org>
Date: Thu, 11 Mar 2010 02:24:54 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003110223310.13366@casper.infradead.org>
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
	<a5d587fb1003101316q25e95d02w118a009b0d76e420@mail.gmail.com>
In-Reply-To: <a5d587fb1003101316q25e95d02w118a009b0d76e420@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michal Suchanek <hramrach@centrum.cz>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>, Paulius Zaleckas <paulius.zaleckas@gmail.com>


> > I don't think the CRTC=FB_info makes much sense if the main use
> > case is fbcon. fbcon will use a single fb device and so you can't see
> > the console on multiple heads anyway which makes the whole thing
> > somewhat pointless. And if you're trying to do something more complex
> > you will be a lot better off bypassing fbdev altogether.
> >
>=20
> I guess it's also possible that somebody would want the fbdev/fbcons
> cover multiple screens. This is not particularly useful with fbcons
> (although curses WMs exist) but might be somewhat useful for graphical
> fbdev applications.

I really can't see fbcon need that.
=20
> Multiple views of the kernel virtual consoles on different heads might
> be nice toy but it's probably too hard to be worth trying. And there
> are always applications like jfbterm which could be perhaps slightly
> adapted to use one of the other devices instead of a vc.

It already exist. I guess it is one of those best kept secrets.
