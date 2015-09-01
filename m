From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Sep 2015 10:32:49 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <55E57ED1.5060109@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LMdBoKwa5SSFDqNE5OtRS1uRl1Tx4DFLX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
 <CAF6AEGu54g+5Q0ZQXeMd7HLHkGWPw+sdo-FZ4qVS=9nB6nLwtw@mail.gmail.com>
In-Reply-To: <CAF6AEGu54g+5Q0ZQXeMd7HLHkGWPw+sdo-FZ4qVS=9nB6nLwtw@mail.gmail.com>
To: Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

--LMdBoKwa5SSFDqNE5OtRS1uRl1Tx4DFLX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/08/15 22:24, Rob Clark wrote:
> On Tue, Aug 25, 2015 at 9:45 AM, Daniel Vetter <daniel.vetter@ffwll.ch>=
 wrote:
>> When the usual fbcon legacy options are enabled we have
>> ->register_framebuffer
>>   ->fb notifier chain calls into fbcon
>>     ->fbcon sets up console on new fbi
>>       ->fbi->set_par
>>         ->drm_fb_helper_set_par exercises full kms api
>>
>> And because of locking inversion hilarity all of register_framebuffer
>> is done with the console lock held. Which means that the first time on=

>> driver load we exercise _all_ the kms code (all probe paths and
>> modeset paths for everything connected) is under the console lock.
>> That means if anything goes belly-up in that big pile of code nothing
>> ever reaches logfiles (and the machine is dead).
>>
>> Usual tactic to debug that is to temporarily remove those console_lock=

>> calls to be able to capture backtraces. I'm fed up writing this patch
>> and recompiling kernels. Hence this patch here to add an unsafe,
>> kernel-taining option to do this at runtime.
>>
>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
> This one was causing me some problems, if I tried to enable
> lockless_register_fb.  It *looks* like it should work, so I'm not
> quite sure what the deal is.  But I'm 110% fan of getting something
> like this working, because console_lock is pretty much the bane of kms
> developer's existence..
>=20
> I'll have to debug further on a system where I can see more than the
> bottom three lines of the second to last backtrace..

Any idea if anyone has ever looked at properly fixing this?

 Tomi


--LMdBoKwa5SSFDqNE5OtRS1uRl1Tx4DFLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5X7RAAoJEPo9qoy8lh71paQP/0VPZE+7qoVhK9wNgVB+4gOS
mShzhakw4aSMRwfKEWxlsDMG+x5nHe6c0o+WAjOxclptDQLE1Y2KmkD7qvnVIVnW
ahShFt79v3v6TwUtcACKsU1GRA0qZR6Zjh4ZZMU2/YIBYMnYLJhR6I1qtNxRx1Lq
5N8WbLXPJX+0tkRqWdvWIuG5lu9LkpldGpw1WZpSPFYhlG7tnaeEWMbXq/PJ65Tb
pjX/IZhBZ8cf/dZzgU+UCkPyHx/k83dm3xyG+OpVuRdX1Q2Riafj6eBUABcuWhgq
klAin2VPM/MswpZ9Gli+L1RN7xUzFSs3kWzPbigDhfh8gwSM9zyIRxRo/n7cew13
lGJQcbsn9mQr8XZXRpPXg8BDXJyS4dBnyqHyJdDTAdCAv7CW5Lw/O2JqoEueJZB2
hxH1Gp72z2LmJ1dsDEBYm0hLorDVvRlABSclW4bPl+ES1N22W44SVxc4T8QjQdI/
+6JJYkrMSopzPXALWFvqhI51n9JONVF5uaVYAMg5RZrdFOUZONELmPhXXA9ZpzoK
sXYfNVZwdeiRotQQZC7Rw0mHEB1BYRSOZFMFRZLTVu8OezJzBIJLidy0oiuEaLOJ
iqD/bL4AKPC4+UFihFqXSDg59xTkXsvM+Bf5jfe+9QfLxm84qT85y7fRXud6Eae8
DNS0VWUGuWXj8b/8Kfws
=BL2F
-----END PGP SIGNATURE-----

--LMdBoKwa5SSFDqNE5OtRS1uRl1Tx4DFLX--
