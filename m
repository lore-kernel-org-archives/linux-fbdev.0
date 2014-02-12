From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Wed, 12 Feb 2014 20:43:11 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <20140212204311.GH3891@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>
	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>
In-Reply-To: <CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

On Thu, Feb 13, 2014 at 06:14:04AM +1000, Dave Airlie wrote:
> >
> > The biggest remaining stumbling block is the backlight API, because ope=
ning the
> > sysfs files requires root rights. I'll very likely write a little helpe=
r for this
> > for now, but in the long run it would be good to have a better solution.
> >
> > While discussion this in the graphics devroom at Fosdem, the general co=
nsensus
> > seemed to be that the current backlight API is in need of an overhaul a=
nyways.
> >
> > There are several issues with the current API:
> > -there is no reliable way to determine the relation between a backlight
> >  control in sysfs and the display it controls the backlight off
> > -on many laptops we end up with multiple providers of backlight control
> >  all battling over control of the same backlight controller through var=
ious
> >  firmware interfaces
> > -and there is no way to do acl management on it because of sysfs usage
> >
> > At Fosdem it was suggested to "simply" make the backlight a property of
> > the connector in drm/kms and let users control it that way. From an acl=
 pov
> > this makes a ton of sense, if a user controls the other display-panel s=
ettings,
> > then he should be able to control the backlight too.
> >
> > This also nicely solves the issue of userspace having to figure out whi=
ch backlight
> > control to use for a certain output.
> >
> > Last this makes it the kernels responsibility to figure out which firmw=
are interface
> > (if any) to use and tie that to the connector, rather then just exporti=
ng all of
> > them, including conflicting ones, and just hoping that userspace will f=
igure things out.
> >
> > Note that wrt the last point, the kernel is the one which should have a=
ll the hardware
> > knowledge to do this properly, after all hardware abstraction is one of=
 the tasks of
> > the kernel.
> >
> > I realize moving this more into the kernel, and tying things into drm i=
s in no means
> > easy, but it is about time we clean up this mess.
> >
> > Note that although I'm kicking of this discussion, my focus within the =
graphics team is
> > mostly on input devices, so I'm hoping that someone else will pick thin=
gs up once we've
> > a better idea of how we would like to solve this.
> >
>=20
> I hate to respond with yeah no, but yeah no,
>=20
> http://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&show_h=
tml=3Dtrue&highlight_names=3D&date 14-02-04
> http://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&show_h=
tml=3Dtrue&highlight_names=3D&date 14-02-05
>=20
> read down that until you see me and tagr talking, read it a few times,
> and the follow on chat with dvdhrm.
>=20
> The biggest problem with leaving the kernel to pick the correct one,
> is the kernel simply never knows which is the
> correct one,

That could be solved by still allowing userspace to change the
connection between the property and the actual backlight device.

With the prop approach + atomic modeset you could also do some
slightly fancier things like changing the backlight at the same
time as doing a modeset or just adjusting some other display
related properties.

> and you also have to deal with a load of problems like
> runtime module deps between very misc modules
> or using some kind of notifier mechanism that will turn into a locking
> nightmare.

This would still be an issue though.

I like the idea of the property, but I'm not volunteering to do any
of the work.

>=20
> I don't mean to dissuade you from trying to "fix" this, but actually
> getting a solution upstream is going to require a lot of messing
> around.
>=20
> Talk to Matthew Garrett, if you haven't talked to him, then you
> haven't talked to anyone who understands backlights.
>=20
> Dave.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
Intel OTC
