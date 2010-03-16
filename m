From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Tue, 16 Mar 2010 14:00:32 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <1268748032.4176.56.camel@thor.local>
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
	<1268747186.4176.38.camel@thor.local>
	<alpine.LFD.2.00.1003161353200.14714@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1003161353200.14714@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, DRI development list <dri-devel@lists.sourceforge.net>

On Tue, 2010-03-16 at 13:56 +0000, James Simmons wrote:=20
> > > The fb_ops can only be called from fbcon or the fbdev userland interf=
ace.=20
> > > The fbcon calls should only happen when the VC is in KD_TEXT mode. No=
w=20
> > > with the DRM backend we have the advantage of creating a mapping sepe=
rate=20
> > > from the console mapping. A fb_open/fb_close could be used to cleanin=
g up=20
> > > the userland mmap as well as handle the console pinning. We can suppl=
y=20
> > > your own fb_mmap hook.
> >=20
> > Again, the issue is not userspace but that fb_ops hooks can be called
> > from interrupt context etc.
>=20
> This should not happen. The VT layer is protected from calling in the=20
> interrupt context. TNor does fbcon call any fb_ops methods from a irq.

E.g. printk?


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
