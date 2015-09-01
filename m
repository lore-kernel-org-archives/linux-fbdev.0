From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Sep 2015 14:41:48 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <55E5B92C.7000202@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7WRxVeEVP0dvEs9xIhMgum9bVMUr3lE4O"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
 <CAF6AEGu54g+5Q0ZQXeMd7HLHkGWPw+sdo-FZ4qVS=9nB6nLwtw@mail.gmail.com>
 <55E57ED1.5060109@ti.com>
 <CAF6AEGtV1-tgvA0D-BFZ8NMNyNN7C8-jst5xXBKrQHGFVWCpyA@mail.gmail.com>
In-Reply-To: <CAF6AEGtV1-tgvA0D-BFZ8NMNyNN7C8-jst5xXBKrQHGFVWCpyA@mail.gmail.com>
To: Rob Clark <robdclark@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

--7WRxVeEVP0dvEs9xIhMgum9bVMUr3lE4O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/09/15 17:34, Rob Clark wrote:
> On Tue, Sep 1, 2015 at 6:32 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
>>
>>
>> On 25/08/15 22:24, Rob Clark wrote:
>>> On Tue, Aug 25, 2015 at 9:45 AM, Daniel Vetter <daniel.vetter@ffwll.c=
h> wrote:
>>>> When the usual fbcon legacy options are enabled we have
>>>> ->register_framebuffer
>>>>   ->fb notifier chain calls into fbcon
>>>>     ->fbcon sets up console on new fbi
>>>>       ->fbi->set_par
>>>>         ->drm_fb_helper_set_par exercises full kms api
>>>>
>>>> And because of locking inversion hilarity all of register_framebuffe=
r
>>>> is done with the console lock held. Which means that the first time =
on
>>>> driver load we exercise _all_ the kms code (all probe paths and
>>>> modeset paths for everything connected) is under the console lock.
>>>> That means if anything goes belly-up in that big pile of code nothin=
g
>>>> ever reaches logfiles (and the machine is dead).
>>>>
>>>> Usual tactic to debug that is to temporarily remove those console_lo=
ck
>>>> calls to be able to capture backtraces. I'm fed up writing this patc=
h
>>>> and recompiling kernels. Hence this patch here to add an unsafe,
>>>> kernel-taining option to do this at runtime.
>>>>
>>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>> Cc: linux-fbdev@vger.kernel.org
>>>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>
>>> This one was causing me some problems, if I tried to enable
>>> lockless_register_fb.  It *looks* like it should work, so I'm not
>>> quite sure what the deal is.  But I'm 110% fan of getting something
>>> like this working, because console_lock is pretty much the bane of km=
s
>>> developer's existence..
>>>
>>> I'll have to debug further on a system where I can see more than the
>>> bottom three lines of the second to last backtrace..
>>
>> Any idea if anyone has ever looked at properly fixing this?
>=20
> I hadn't had a chance to look at it further yet..  I think Daniel
> claimed it worked for him, but he was probably on intel-next, where I
> was on drm-next at the time which seemed to be having some unrelated
> i915 issues (when I was trying to debug atomic fb-helper patches).  So
> can't really say that the issue I had was actually related to this
> patch.  I'll try again later this week or next, when hopefully i915 in
> drm-next is in better shape..

Oh, I didn't mean this patch, but the whole console lock in general.
I've also banged my head to a wall because of it =3D).

 Tomi


--7WRxVeEVP0dvEs9xIhMgum9bVMUr3lE4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5bksAAoJEPo9qoy8lh71ZMsQAJoAqLP7jc4J02jsA/UIsv1/
ektwNcElWkBQ1SeVy2nVH6Uv9VQZETFAVSFBugzZBxJi9Lm82Tz2TbOUxA7uxKvY
Q9fI6+fog+46vweqUSYKwtSbNbXXK7JmS6bIU18IhppdKxoldDXRRfs0fovjx+dF
umXICWsduiUmVCHZdpES72aOfSBLpH2dnv+GrpSnLrdoNoXqIZ3N6XW4Lv9hZrmX
uk+/BLar+zD2I0N/mVl3hFPSRkvHtWV/x/JlbZAnnXl7b3gtuehyzFas7brsgAnU
y9W0kCxyFOJ78+Ug3sjn6pTKB/Mg0QS9HgZhsSycW/PNLenlBw3qYTD3StV4wFBJ
RCGKLh5zwFEelmZ6z3/c0E8yJlR71pl9kDtcOXV4PGIlYehzXq1u1sXeRXx3AYiP
LiiwKmJmPFhskMO+5ZSDsEpZEc/bwhCW3zkU+JRkMSlZY1NGcrMvVjYYRy6HsX2Q
ZT8icHU1oSY3yaLzz3AQKAG2TVFFN2d4UAu+4Q1umG0AwjILujQYVhx7Fjj1yXha
sGbmAw8Gt3JEGYaD1GnXkNsl6+7l3AIAlvJRbhaP6Tg1kDGn8vKY8HltmZLfjV4o
UaqRdet9Jgca/B94MbH9bV6CkWJ2m9p2LxlzEkNKY5oPOvhgvJPbUJ+PZcBrXpyG
1yqpgAWbRZNjjLJSrHxP
=vPZ5
-----END PGP SIGNATURE-----

--7WRxVeEVP0dvEs9xIhMgum9bVMUr3lE4O--
