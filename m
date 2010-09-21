From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Tue, 21 Sep 2010 07:02:55 +0000
Subject: Re: [Patch, RFC] Make struct fb_info ref-counted with kref
Message-Id: <20100921090255.410da2d7@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100919172833.14bf291e@neptune.home>
	<4C963E99.9080207@gmx.de>
	<20100919190240.65762511@neptune.home>
	<4C97B079.8050707@gmx.de>
	<20100920213258.1218b284@neptune.home>
	<4C97BF40.6030708@gmx.de>
	<20100920223608.19b4d177@neptune.home>
	<4C97E00B.6090103@gmx.de>
	<20100921075610.1c016c12@pluto.restena.lu>
	<4C985309.5020205@gmx.de>
In-Reply-To: <4C985309.5020205@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>

On Tue, 21 Sep 2010 08:39:05 Florian Tobias Schandinat <FlorianSchandinat@g=
mx.de> wrote:
> Bruno Pr=C3=A9mont schrieb:
> > On Tue, 21 Sep 2010 00:28:27 Florian Tobias Schandinat <FlorianSchandin=
at@gmx.de> wrote:
> >>> Tracking if/how often framebuffer is opened as such is a separate thi=
ng (though
> >>> all users that have the framebuffer opened hold a reference to fb_inf=
o).
> >> That's what I said. So as long as refcount <=3D 1 it does not matter w=
hether you=20
> >> just count on open/release or additionally on every framebuffer operat=
ion, just=20
> >> that the later produces more noise.
> >=20
> > Hm, I don't count on every framebuffer operation... in most cases
> > fb_info is provided as function argument, in which case no further
> > counting is needed as the caller has a valid reference.
> >=20
> > With my patch applied refcount for registered but unsed framebuffer was
> > 2 (once for the driver, once for registered_fb entry) and went up to 3
> > when userspace opened framebuffer. fbcon's usage only incremented
> > refcount for very short timeframes when effectively using fb_info.
> >=20
> > When starting with the FB minor I have to take a new reference.
> > (though I maybe should check if file's private data is set and use
> > that reference instead of looking up fb_info by minor as is currently
> > done)
> >=20
> > For fbcon all the references are taken by FB minor (I wondered why
> > fbcon only remembers index into registered_fb aka minor instead of
> > fb_info itself)
>=20
> True, I guess fb infrastructure and fbcon both could use a lot of work. A=
t the=20
> moment I am more at fixing my driver but once that's done to an acceptabl=
e level=20
> I think I'll give it a try, too.

This year someone said he/she would look at making it possible to have
multiple concurrently active consoles on distinct framebuffers.
Hopefully something is happening on that front (that would certainly
also include some fbcon cleanup)

Maybe I should first change fbcon to stop using indexes into
registered_fb but use fb_info right away (this would also make it
possible to soften/drop the max_fb limit of 15 at a later time, e.g. by
using dynamic major/minors)
This way fbcon would not by affected (or at least much less affected)
by the refcounting of fb_info.

> >> So I still don't see any advantage in counting users + uses.
> >> Please note that I do not object the idea of the patch itself, it's on=
ly that I=20
> >> have a different preference on what to count. I only want to express t=
hat your=20
> >> way is more complicated than what I would recommend.
> >=20
> > I don't think I see how you would do the refcounting... would you just
> > drop the changes in fb_open() and fb_release()?
> > Could you describe your approach (with pseudo-code) or the differences
> > to mine?
>=20
> No, quite the opposite.
> I would increase the refcount in fb_open in fbmem.c and in fbcon.c where =

> fbops->fb_open is called; decrease the refcount on fb_release in fbmem.c =
and in=20
> fbcon.c where fbops->fb_release is called. This would be only 6 places in=
 total=20
> which need to be changed and would be the same as what you said is curren=
tly used.
> As we agree (I hope) that for framebuffer operations an already open fram=
ebuffer=20
> is required this would not change when the framebuffer will be freed (com=
pared=20
> to your counting) so the part changing how a framebuffer is shut down can=
 be=20
> changed just as you proposed. The advantage is that it does not require c=
hanges=20
> to framebuffer ioctls/read/write/mmap and probably also much less changes=
 in=20
> fbcon. And if this is also what drivers want and there is no conflict wit=
h what=20
> you want, I don't see any reason to not provide this service but force th=
em to=20
> do this kind of refcounting on their own.

Ok, will see if I can do it that way. But from Guennadi's reply it
seems users that can be synchronously notified of fb-changes would need
to be accounted for separately from the others (maybe they don't need
to be accounted for at all)

Though I definitely don't like current access to registered_fb
array which looks racy (I've seen nothing that prevents two
register_framebuffer() calls to race for the same minor or even
unregister_framebuffer to race with register_framebuffer())
fbcon's access should be safe enough though via the notification events
that are serialized with console sem.

Thanks,
Bruno


> Thanks,
>=20
> Florian Tobias Schandinat
>=20
