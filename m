From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 19 Nov 2011 12:35:52 +0000
Subject: Re: [PATCH] fb: split out framebuffer initialization from
Message-Id: <20111119133552.6585fd2a@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321308088-6327-1-git-send-email-timur@freescale.com>
In-Reply-To: <1321308088-6327-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Florian,

On Sat, 19 November 2011 Florian Tobias Schandinat <FlorianSchandinat@gmx.d=
e> wrote:
> On 11/19/2011 11:47 AM, Bruno Pr=C3=A9mont wrote:
> > On Sat, 19 November 2011 Florian Tobias Schandinat <FlorianSchandinat@g=
mx.de> wrote:
> >> On 11/17/2011 08:19 PM, Timur Tabi wrote:
> >>> Timur Tabi wrote:
> >>>> Introduce functions framebuffer_init() and framebuffer_cleanup() to =
allow
> >>>> the initialization of a user-allocated fb_info object.
> >>>>
> >>>> framebuffer_alloc() allows for appending a private data structure wh=
en it
> >>>> allocates the fb_info object.  However, a driver that registers mult=
iple
> >>>> framebuffers for one device may also need another private data struc=
ture
> >>>> for the device itself.  framebuffer_init() allows such drivers to st=
ore
> >>>> the fb_info objects in the device-specific private data structure,
> >>>> thereby simplifying memory allocation.
> >>>>
> >>>> Signed-off-by: Timur Tabi <timur@freescale.com>
> >>>
> >>> Florian,
> >>>
> >>> Any comments on this patch?  If you're okay with the change, I want t=
o take
> >>> advantage of it in my framebuffer driver.
> >>
> >> Of course you want, otherwise I'd be wondering why you are sending thi=
s patch
> >> at all.
> >>
> >> But I don't see any advantages of your approach. Instead of pointers t=
o fb_info
> >> with this patch you could embed fb_info directly in your data structur=
e but that
> >> is barely a difference for a programmer I'd think. You'd still have to=
 call your
> >> new functions on init/exit so the amount of function calls needed is t=
he same
> >> with or without the patch (I could see an advantage if alloc and relea=
se were
> >> pure memory allocations). Or is this all about handling the case when =
fb_alloc
> >> fails?
> >> Historically some drivers don't even call alloc but have their own fb_=
info and
> >> call only register. I do not want to add yet another way of doing fram=
ebuffer
> >> initialization unless you can clearly show its benefits.
> >=20
> > Wouldn't it even make sense to move some more of the initialization of =
fb_info
> > out of fb registration into this new init funtion? (I'm thinking about =
initializing
> > mutexes and the like)
>=20
> This would require someone going through all framebuffers and change them=
 to use
> the new fb_init function if they don't use fb_alloc. I'd accept this patc=
h as an
> improvement iff someone would do this. Than the number of variation of do=
ing
> framebuffer initialization would remain the same. Of course the same shou=
ld be
> done for fb_cleanup.

I agree, though (in a first step) alloc_framebuffer() could call init_frame=
buffer()
by itself (same goes for cleanup on release) so that only those doing the m=
emory
allocation manually have to be changed (though I'm wondering if those are n=
ot already
wrong with regard to fb_info.bl_curve_mutex which is being initialized in
alloc_framebuffer() - but then again they will not use backlight).

I might give it a try once I'm no more busy with system administration.

Bruno

> > This way fb_info could be used before being registered. Registration wo=
uld then
> > be reduced to makeing the framebuffer visible to userspace and listed in
> > registered_fb[].
> >=20
> > This way framebuffer_alloc() would be no more that kzalloc(), framebuff=
er_init()
> > would setup all "non-zero" fields of fb_info (including setup of all mu=
texes, one
> > of which is currently being done by framebuffer_alloc() and the rest by
> > do_register_framebuffer()!).
