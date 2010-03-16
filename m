From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Tue, 16 Mar 2010 13:46:26 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <1268747186.4176.38.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
	<alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
	<a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
	<alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
	<21d7e9971003121251v4bef7e96v67f3d98aa9ab384a@mail.gmail.com>
	<alpine.LFD.2.00.1003131421360.12031@casper.infradead.org>
	<21d7e9971003131301r723f3311p3553ea8a1a86bf0a@mail.gmail.com>
	<1268566880.9302.65.camel@thor.local>
	<alpine.LFD.2.00.1003151830070.16108@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1003151830070.16108@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, DRI development list <dri-devel@lists.sourceforge.net>

On Mon, 2010-03-15 at 18:38 +0000, James Simmons wrote:=20
> > > The big issue we have with resizing the buffer is userspace mmaps of =
the fbdev
> > > device, and invalidation.
> > > Previous thread of unresolvedness is here.
> > > http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg41878.=
html
> >=20
> > Actually AFAIR (and reading through it again seems to confirm this)
> > userspace mappings should be fully handled by the last patch series I
> > posted back then[0]. The problem was that the struct fb_ops hooks may be
> > called by the kernel from pretty much any context, and neither I nor
> > Thomas was sure how to handle the TTM locking given that. Maybe James
> > has ideas for this given his better familiarity with fbdev internals.
>=20
> The fb_ops can only be called from fbcon or the fbdev userland interface.=
=20
> The fbcon calls should only happen when the VC is in KD_TEXT mode. Now=20
> with the DRM backend we have the advantage of creating a mapping seperate=
=20
> from the console mapping. A fb_open/fb_close could be used to cleaning up=
=20
> the userland mmap as well as handle the console pinning. We can supply=20
> your own fb_mmap hook.

Again, the issue is not userspace but that fb_ops hooks can be called
from interrupt context etc.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
