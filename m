From: Dave Airlie <airlied@gmail.com>
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video 
	mode
Date: Sat, 13 Mar 2010 06:51:52 +1000
Message-ID: <21d7e9971003121251v4bef7e96v67f3d98aa9ab384a@mail.gmail.com>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
	<alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
	<a5d587fb1003110747j40e5c5f1h70aab0e74f03eef2@mail.gmail.com>
	<alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LFD.2.00.1003121332470.10546@casper.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, Michal Suchanek <hramrach@centrum.cz>, Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sourceforge.net

>> >
>> >> >> It would be nice to find a way to reclaim the console memory for X,
>> >> >> but I'm not sure that can be done and still provide a good way to
>> >> >> provide oops support.
>> >> >
>> >> > What do you think the average user will care about more?
>> >> >
>> >> > =A0 =A0 =A0* Seeing kernel oops/panic output about once in a lifeti=
me.
>> >> > =A0 =A0 =A0* Being able to start/use X in the first place and enabl=
ing it to
>> >> > =A0 =A0 =A0 =A0use all of VRAM.
>> >> >
>> >> > Personally, I've never even seen any kernel oops/panic output despi=
te
>> >> > numerous opportunities for that in the couple of months I've been u=
sing
>> >> > KMS. But I have spent considerable time and effort trying to get ri=
d of
>> >> > the pinned fbcon BO. If the oops/panic output is the only thing
>> >> > preventing that, maybe that should only be enabled via some module
>> >> > option for developers.
>> >>
>> >> I'm all for it!
>> >
>> > I'm looking into the details for this. It will require some changes to
>> > internal apis to make it to work.
>> >
>>
>> Can't it print the oops on whatever is currently displayed?
>>
>> It need not be a dedicated buffer as long as there is always some buffer.
>>
>> But perhaps this is more complex than that.
>
> =A0 =A0 =A0 =A0Yes it is very complex. Reading the code and drm specs you=
 come to
> realize buffer handling is done with GEM, TTM, or for older drivers drm_m=
aps.
> Drivers often handle a combine of those, meaning no real wrapper from one
> api to another :-( From the code it appears GEM is the main userland inte=
rface
> when using KMS. Some how TTM is also usable from userland but I never fou=
nd a
> clear example of how that is done. So to the average userland app writer =
it is
> a mystery. As for hardware that has a static front buffer I can see how to
> use drm_maps or TTM but I don't see a easy way to map it to the GEM api.
> Also their exist ioctl for gem but it appears no one actually uses them
> but instead write their own :-( So you can see the confusion here.

Userspace buffer management interfaces are pre-driver, the only requirement
if that they have a 32-bit handle to identify buffers uniquely. Pre-KMS dri=
vers
don't exist for the purposes of fb interaction, so drm_maps are ignorable f=
rom
that pov.

> =A0 =A0 =A0 =A0Outside of what I described above the drm_framebuffer hand=
ling is
> a mess. From what I can see with the code you can only create a
> drm_framebuffer with the GEM api. With this case the two most important
> functions to provide are

This isn't correct. You get a drm_file and a handle, the driver then uses
these to do whatever it wants to do. This means lookup a GEM object or
whatever but there is no reliance on GEM or any other memory manager
outside the driver. Again a handle a file priv are in no way GEM specific.

>
> dev->mode_config.funcs->fb_create(dev, file_priv, r)
>
> and
>
> fb->funcs->create_handle(fb, file_priv, &r->handle);
>
> As you can see if the functions they depend on a handle and a drm_file. To
> make it possible to create a framebuffer internally using a common code we
> would remove those requirements.

We already have an internal framebuffer creation for fbdev, there is
an fb_create
callback that does this, its not up to dynamic fbdev creation.

> =A0 =A0 =A0 =A0This gets me to point of where to go from here. We have tw=
o choices.
> The first being we could just make the drm_framebuffer code totally gem
> dependent thus we could cleanup the drivers code up by moving gem code
> there. The second option is to make the drm_framebuffer code agnostic to =
the gem
> layer. So I have been pondering on how to make the second option work.
> There is one thing that all these layers do share in common. That is they
> have some sort of drm_hash with a object lookup. Still pondering how that
> would be done.

I'm not sure either of these makes sense, can you clearly state the
goal and maybe
we can work out what you need.

Dave.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--
