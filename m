From: Adam Borowski <kilobyte@angband.pl>
Date: Fri, 03 Feb 2017 16:45:52 +0000
Subject: Re: [PATCH v9 4/4] console: Make persistent scrollback a boot parameter
Message-Id: <20170203164552.mirdwyatkeseyfxq@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4640722.jsFVORW8WM@amdc3058>
 <20170110212838.16175-1-manuel.schoelling@gmx.de>
 <20170110212838.16175-5-manuel.schoelling@gmx.de>
 <CAP=VYLpBfFdixRm5=gQOqjxc+Qpy-Kk1oa1uMQjUnXTJO3fqrg@mail.gmail.com>
 <1486137855.17160.19.camel@gmx.de>
In-Reply-To: <1486137855.17160.19.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, Andrew Morton <akpm@linux-foundation.org>, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Fri, Feb 03, 2017 at 05:04:15PM +0100, Manuel Sch=F6lling wrote:
> On Thu, 2017-02-02 at 15:07 -0500, Paul Gortmaker wrote:
> > On Tue, Jan 10, 2017 at 4:28 PM, Manuel Sch=F6lling
> > <manuel.schoelling@gmx.de> wrote:
> > > The impact of the persistent scrollback feature on the code size is
> > > rather small, so the config option is removed. The feature stays
> > > disabled by default and can be enabled by using the boot command
> > > line
> > > parameter 'vgacon.scrollback_persistent=3D1' or by setting
> > > VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=3Dy.
> >=20
> > [...]
> >=20
> > > +module_param_named(scrollback_persistent, scrollback_persistent,
> > > bool, 0000);
> > > +MODULE_PARM_DESC(scrollback_persistent, "Enable persistent
> > > scrollback for all vga consoles");
> >=20
> > Since this hasn't got widespread deployment yet and=A0=A0only exists
> > in Greg's tree, can we please fix the above to use setup_param or
> > similar, since there is nothing modular about this code at all.
> Not sure what you mean here.
> If this is not the right may to declare it I'd be more than happy to
> change this. But I could not find any function/macro named setup_param
> [1].
> It would be great if you could give me a hint what function to use
> here!
>=20
> [1] http://lxr.free-electrons.com/ident?i=3Dsetup_param

That shows only exact matches.

You want "git grep setup_param", which shows __setup_param() plus some
unrelated stuff.  I see only four uses in the kernel, but that's enough
to see how to use it.


Meow!
--=20
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=3Dzx-spectrum --build=3Dpdp11
