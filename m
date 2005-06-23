From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: atyfb h/vsync polarity
Date: Thu, 23 Jun 2005 16:48:29 +0300
Message-ID: <20050623134829.GA18960@sci.fi>
References: <20050622140842.GV20191@midgar.lan.raphnet.net> <200506231125.10848.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlS4L-00042t-6u
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 06:48:37 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlS4J-0001ea-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 06:48:37 -0700
Content-Disposition: inline
In-Reply-To: <200506231125.10848.alex.kern@gmx.de>
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
Cc: Raphael Assenat <raph@raphnet.net>

On Thu, Jun 23, 2005 at 11:25:10AM +0200, Alexander Kern wrote:
> Am Mittwoch, 22. Juni 2005 16:08 schrieb Raphael Assenat:
> > Hi,
> > I am a Linux Sparc64 user, and recently I decided to switch from 2.4
> > kernel series to 2.6 series. Everything worked well, but I had troubl=
e
> > getting the framebuffer console to work.
> >
> > In openboot, my monitor worked perfectly. But as soon as Linux
> > configured the framebuffer, my monitor would loose sync. I compared t=
he
> > output given by fbset on the working configuration (2.4 kernel) and t=
he
> > non-working configuration (2.6.12 kernel). Every setting was identica=
l,
> > except that the output on 2.4 had 'hsync high'. I tried 'fbset -hsync
> > high', but the screen still did not sync, and fbset still did not rep=
ort
> > 'hsync high', as if the setting was ignored.
> >
> > After digging a little bit, I found this in
> > drivers/video/aty/atyfb_base.c:
> >
> > if(vdisplay < 400) {
> > 		h_sync_pol =3D 1;
> > 		v_sync_pol =3D 0;
> > } else if(vdisplay < 480) {
> > 		h_sync_pol =3D 0;
> > 		v_sync_pol =3D 1;
> > } else if(vdisplay < 768) {
> > 		h_sync_pol =3D 0;
> > 		v_sync_pol =3D 0;
> > } else {
> > 		h_sync_pol =3D 1;
> > 		v_sync_pol =3D 1;
> > }
> >
> > So no mater what sync polarity we ask for, the driver overrides them.=
 I
> > commented the code above in my build, and the framebuffer console fin=
ally
> > works.
> >
> > It seems strange to me that the driver ignores the sync polarity we
> > request, but I'm sure the above code exists for a good reason so I wo=
uld
> > not suggest to simply remove it as a fix. Can anyone explain why this=
 code
> > is
> > necessary?
> this behaviour is from XFree code and more VGA like.

I don't think this sort of code really belongs in atyfb. If someone wants=
=20
to follow this rule he can simply use modelines with the appropriate sync=
=20
polarities.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
