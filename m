From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 14 Jan 2017 07:26:13 +0000
Subject: Re: [PATCH v9 4/4] console: Make persistent scrollback a boot parameter
Message-Id: <20170114072613.GA3856@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4640722.jsFVORW8WM@amdc3058>
 <20170110212838.16175-5-manuel.schoelling@gmx.de>
 <20170110225846.gd2pqczplnkl74d3@angband.pl>
 <1484337634.1720.4.camel@gmx.de>
In-Reply-To: <1484337634.1720.4.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: Adam Borowski <kilobyte@angband.pl>, jslaby@suse.com, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jan 13, 2017 at 09:00:34PM +0100, Manuel Sch=F6lling wrote:
> On Tue, 2017-01-10 at 23:58 +0100, Adam Borowski wrote:
> > On Tue, Jan 10, 2017 at 10:28:38PM +0100, Manuel Sch=F6lling wrote:
> > > The impact of the persistent scrollback feature on the code size is
> > > rather small, so the config option is removed. The feature stays
> > > disabled by default and can be enabled by using the boot command
> > > line
> > > parameter 'vgacon.scrollback_persistent=3D1' or by setting
> > > VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=3Dy.
> > >=20
> > > Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> > > Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > +module_param_named(scrollback_persistent, scrollback_persistent,
> > > bool, 0000);
> > > +MODULE_PARM_DESC(scrollback_persistent, "Enable persistent
> > > scrollback for all vga consoles");
> >=20
> > A command-line knob settable by the end-user is something more
> > persistent
> > than a config option.=A0=A0As you're going to extend this code beyond
> > vgacon in
> > the near future, perhaps it'd be better to have a shared setting for
> > all
> > console drivers?
> According to the guys at #kernelnewbies on IRC everybody hates new
> command line options.

That was me, you can use my name here :)

> I'd rather stick to the module parameter for now and maybe introduce a=20
> new cmd line option later, once this feature has been implemented in
> several console drivers.

Yes, that should be fine.

thanks,

greg k-h
