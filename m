From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 14:35:03 -0500
Message-ID: <9e473391050312113532327a46@mail.gmail.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <20050312151318.GA27200@sci.fi> <1110647422.4004.456.camel@localhost>
	 <1110647557.5997.98.camel@atlantis.netenviron.com>
	 <1110655224.4010.469.camel@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DACPJ-0006aZ-0i
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 11:36:17 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DACPH-0004hZ-GL
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 11:36:16 -0800
Received: from rproxy.gmail.com ([64.233.170.207])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DACPF-000524-PU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 11:36:14 -0800
Received: by rproxy.gmail.com with SMTP id z35so1950937rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 11:35:03 -0800 (PST)
In-Reply-To: <1110655224.4010.469.camel@localhost>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 12 Mar 2005 14:20:24 -0500, Michel D=E4nzer <michel@daenzer.net> wr=
ote:
> On Sat, 2005-03-12 at 17:12 +0000, Torgeir Veimo wrote:
> > On Sat, 2005-03-12 at 12:10 -0500, Michel D=E4nzer wrote:
> > > On Sat, 2005-03-12 at 17:13 +0200, Ville Syrj=E4l=E4 wrote:
> > > >
> > > > Also adding support for FB_ACTIVATE_VBL should be quite simple now.
> > >
> > > You don't need an interrupt for that. You can choose via the
> > > CRTC_OFFSET_CNTL:CRTC_OFFSET_FLIP_CNTL bit whether the update of the
> > > CRTC offset should take effect immediately or on the next vertical
> > > blank.
> > >
> > > Personally, I'm not sure why something that needs this functionality
> > > can't use the DRM...
> >
> > My interest for adding this is video playback. It's kind of hard to do
> > through the DRM.
>=20
> You don't have to use the DRM for anything but the wait for vsync; I can
> see the effort of initializing the DRM to the point where this is
> possible being prohibitive though.
>=20
> The real point is that the usage of the interrupt needs to be
> coordinated between the framebuffer device and the DRM. Something like
> the first one to request the IRQ setting up a callback mechanism where
> the other can hook into might be a possibility? Or the shared
> mini-driver that has been proposed for years, but isn't liked by some...

When we get merged my thought was to let fbdev catch the vsync IRQ and
then chain into DRM. In that model fbdev becomes the mini-driver.
Right now I don't think there is any other solution than merging
fbdev/DRM that doesn't result in some kind of dead on VT switch
scenario.

Also, I have the hotplug monitor change interrupt hookup in my local
code but I'm waiting for BenH to finish his dual head radeonfb first.
He has said it will probably be ready this week, patches are starting
to appear on lkml from him.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
