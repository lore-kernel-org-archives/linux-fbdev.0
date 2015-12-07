From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 17:32:42 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <5665C2BA.3010304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4DMaTjWEWvCl9VmTsfL2uenAP4d7ET4Jw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
In-Reply-To: <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

--4DMaTjWEWvCl9VmTsfL2uenAP4d7ET4Jw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 25/08/15 16:45, Daniel Vetter wrote:
> When the usual fbcon legacy options are enabled we have
> ->register_framebuffer
>   ->fb notifier chain calls into fbcon
>     ->fbcon sets up console on new fbi
>       ->fbi->set_par
>         ->drm_fb_helper_set_par exercises full kms api
>=20
> And because of locking inversion hilarity all of register_framebuffer
> is done with the console lock held. Which means that the first time on
> driver load we exercise _all_ the kms code (all probe paths and
> modeset paths for everything connected) is under the console lock.
> That means if anything goes belly-up in that big pile of code nothing
> ever reaches logfiles (and the machine is dead).
>=20
> Usual tactic to debug that is to temporarily remove those console_lock
> calls to be able to capture backtraces. I'm fed up writing this patch
> and recompiling kernels. Hence this patch here to add an unsafe,
> kernel-taining option to do this at runtime.

I think this was never merged. This was part 4 of 4, were there
dependencies or...? Should I apply this for 4.5?

But then... I think my issues with console lock have been later at
runtime, not at register. Maybe we need a module option to disable the
console lock altogether. I wonder how much havoc that might create, thoug=
h.

 Tomi


--4DMaTjWEWvCl9VmTsfL2uenAP4d7ET4Jw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZcK6AAoJEPo9qoy8lh71ZxQP/2IkxUy+T9xpqrsLKNnyaeiy
+HLcqMYOI5SWeTOAxtHvMYAF8fsZcBiC7UG6q87jyqXdBC4yIffo43bAeFFPZr8e
XKetCGnv6QsNhn6odjOF/i0sbxHPSHL42Cbu/CVORdm3aup8R1Dd7S20I58X9Rwj
dlRZUOuobYtyf6piip616t/c7bWUTNbVAk2k5t8PrXgFE+CcQK7cdNMKK0f11NsT
E7v3Ds4Yv64gLBgppfL7hKuqpumw41/MU2x/GCJ4+RjMrNW6VEjlGkooDtz7E9/1
3f/Dh8f9SkZgQAls10kYh55HNojIwOEn0EKt0G+BHLiwfj4UFOIaV//hO2FRwLgX
e2KvUWEOIfvFY0VzZ6xT6/DOLdneqep9BS9nfm8HAFfd0+3ETERFfAchVn74WyJ4
LoyJ+WQekAxcbrVfPx4R6vZfSuNA79lrghGVAUXC5eczfLPelPRakIRck4bqleTP
y83+A5HbyREdb/Q+d5YuhQP3LoZJSZ+pU9BCfVOP/Pe7yoMtG1E52ZnwsLNpJdCb
8uS+LhQFF4Fwr7NdkG4qxYkbtr6mFn5FUYa/kPLBrVsLK6KW4Wqzux6/OmKS0rj8
XOkAn5oR3EysSPPdROp3t3vgymAQvcDY+2aNiCHo/Rkir0sHc8pbNugWTSSagMDC
o5chJakCZDoFGhz3Dl3R
=jt40
-----END PGP SIGNATURE-----

--4DMaTjWEWvCl9VmTsfL2uenAP4d7ET4Jw--
