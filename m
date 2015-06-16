From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Jun 2015 06:43:09 +0000
Subject: Re: [PATCH v4 3/3] video: fbdev: vesafb: use arch_phys_wc_add()
Message-Id: <557FC57D.7020607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="flpeUBqK3wC8Wo9wVpxgRBMjWdj1mqpxI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433436288-16792-1-git-send-email-mcgrof@do-not-panic.com> <1433436288-16792-4-git-send-email-mcgrof@do-not-panic.com> <557AA08E.6050606@ti.com> <20150615222750.GF11147@wotan.suse.de>
In-Reply-To: <20150615222750.GF11147@wotan.suse.de>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, plagnioj@jcrosoft.com, bp@suse.de, hpa@zytor.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, toshi.kani@hp.com, sbsiddha@gmail.com, mingo@elte.hu, tglx@linutronix.de, jgross@suse.com, daniel.vetter@ffwll.ch, airlied@redhat.com, adaplas@gmail.com, robdclark@gmail.com, jg1.han@samsung.com, wsa@the-dreams.de, linux-kernel@vger.kernel.org

--flpeUBqK3wC8Wo9wVpxgRBMjWdj1mqpxI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 16/06/15 01:27, Luis R. Rodriguez wrote:
> On Fri, Jun 12, 2015 at 12:04:14PM +0300, Tomi Valkeinen wrote:
>>
>>
>> On 04/06/15 19:44, Luis R. Rodriguez wrote:
>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>>
>>> This driver uses the same area for MTRR as for the ioremap_wc(), if
>>> anything it just uses a smaller size in case MTRR reservation fails.
>>> ioremap_wc() API is already used to take advantage of architecture
>>> write-combining when available.
>>>
>>> Convert the driver from using the x86 specific MTRR code to
>>> the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
>>> will avoid MTRR if write-combining is available.
>>>
>>> There are a few motivations for this:
>>>
>>> a) Take advantage of PAT when available
>>>
>>> b) Help bury MTRR code away, MTRR is architecture specific and on
>>>    x86 its replaced by PAT
>>>
>>> c) Help with the goal of eventually using _PAGE_CACHE_UC over
>>>    _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
>>>    de33c442e titled "x86 PAT: fix performance drop for glx,
>>>    use UC minus for ioremap(), ioremap_nocache() and
>>>    pci_mmap_page_range()")
>>>
>>> The conversion done is expressed by the following Coccinelle
>>> SmPL patch, it additionally required manual intervention to
>>> address all the #ifdery and removal of redundant things which
>>> arch_phys_wc_add() already addresses such as verbose message
>>> about when MTRR fails and doing nothing when we didn't get
>>> an MTRR.
>>>
>>> @ mtrr_found @
>>> expression index, base, size;
>>> @@
>>>
>>> -index =3D mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
>>> +index =3D arch_phys_wc_add(base, size);
>>>
>>> @ mtrr_rm depends on mtrr_found @
>>> expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
>>> @@
>>>
>>> -mtrr_del(index, base, size);
>>> +arch_phys_wc_del(index);
>>>
>>> @ mtrr_rm_zero_arg depends on mtrr_found @
>>> expression mtrr_found.index;
>>> @@
>>>
>>> -mtrr_del(index, 0, 0);
>>> +arch_phys_wc_del(index);
>>>
>>> @ mtrr_rm_fb_info depends on mtrr_found @
>>> struct fb_info *info;
>>> expression mtrr_found.index;
>>> @@
>>>
>>> -mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
>>> +arch_phys_wc_del(index);
>>>
>>> @ ioremap_replace_nocache depends on mtrr_found @
>>> struct fb_info *info;
>>> expression base, size;
>>> @@
>>>
>>> -info->screen_base =3D ioremap_nocache(base, size);
>>> +info->screen_base =3D ioremap_wc(base, size);
>>>
>>> @ ioremap_replace_default depends on mtrr_found @
>>> struct fb_info *info;
>>> expression base, size;
>>> @@
>>>
>>> -info->screen_base =3D ioremap(base, size);
>>> +info->screen_base =3D ioremap_wc(base, size);
>>>
>>> Generated-by: Coccinelle SmPL
>>> Cc: Toshi Kani <toshi.kani@hp.com>
>>> Cc: Suresh Siddha <sbsiddha@gmail.com>
>>> Cc: Ingo Molnar <mingo@elte.hu>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>> Cc: Dave Airlie <airlied@redhat.com>
>>> Cc: Antonino Daplas <adaplas@gmail.com>
>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>> Cc: Rob Clark <robdclark@gmail.com>
>>> Cc: Jingoo Han <jg1.han@samsung.com>
>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
>>> ---
>>>  drivers/video/fbdev/vesafb.c | 29 ++++++++---------------------
>>>  1 file changed, 8 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesaf=
b.c
>>> index 3db3908..528fe91 100644
>>> --- a/drivers/video/fbdev/vesafb.c
>>> +++ b/drivers/video/fbdev/vesafb.c
>>> @@ -19,10 +19,9 @@
>>>  #include <linux/init.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/screen_info.h>
>>> +#include <linux/io.h>
>>> =20
>>>  #include <video/vga.h>
>>> -#include <asm/io.h>
>>> -#include <asm/mtrr.h>
>>> =20
>>>  #define dac_reg	(0x3c8)
>>>  #define dac_val	(0x3c9)
>>> @@ -180,16 +179,10 @@ static int vesafb_setcolreg(unsigned regno, uns=
igned red, unsigned green,
>>> =20
>>>  static void vesafb_destroy(struct fb_info *info)
>>>  {
>>> -#ifdef CONFIG_MTRR
>>>  	struct vesafb_par *par =3D info->par;
>>> -#endif
>>> =20
>>>  	fb_dealloc_cmap(&info->cmap);
>>> -
>>> -#ifdef CONFIG_MTRR
>>> -	if (par->wc_cookie >=3D 0)
>>> -		mtrr_del(par->wc_cookie, 0, 0);
>>> -#endif
>>> +	arch_phys_wc_del(par->wc_cookie);
>>>  	if (info->screen_base)
>>>  		iounmap(info->screen_base);
>>>  	release_mem_region(info->apertures->ranges[0].base, info->apertures=
->ranges[0].size);
>>> @@ -420,7 +413,6 @@ static int vesafb_probe(struct platform_device *d=
ev)
>>>  	request_region(0x3c0, 32, "vesafb");
>>> =20
>>>  	if (mtrr =3D=3D 3) {
>>> -#ifdef CONFIG_MTRR
>>>  		unsigned int temp_size =3D size_total;
>>> =20
>>>  		/* Find the largest power-of-two */
>>> @@ -428,18 +420,16 @@ static int vesafb_probe(struct platform_device =
*dev)
>>> =20
>>>  		/* Try and find a power of two to add */
>>>  		do {
>>> -			par->wc_cookie =3D mtrr_add(vesafb_fix.smem_start,
>>> -						  temp_size,
>>> -						  MTRR_TYPE_WRCOMB, 1);
>>> +			par->wc_cookie =3D
>>> +				arch_phys_wc_add(vesafb_fix.smem_start,
>>> +						 temp_size);
>>>  			temp_size >>=3D 1;
>>> -		} while (temp_size >=3D PAGE_SIZE && par->wc_cookie =3D=3D -EINVAL=
);
>>> -#endif
>>> +		} while (temp_size >=3D PAGE_SIZE && par->wc_cookie < 0);
>>> +
>>
>> Looks like arch_phys_wc_add prints a warning if it fails, and the abov=
e
>> loop may retry it many (?) times. Probably not a big issue, but may be=

>> somewhat confusing.
>=20
> On most systems arch_phys_wc_add() won't ever run so I think that's a
> fair compromise to reach as we phase out MTRR. If we really wanted
> to fix this one could generalize the whole loop control stuff and use
> a new arch_phys API to generalize all that code as tons of drivers
> borrow the same logic. I decided this was pointless as we're phasing
> this out anyway and this code will simply be a no-op on most systems
> now.
>=20
> Let me know if you have any other preference or ideas.

Ok, sounds fine to me. I'll queue these for 4.2.

 Tomi


--flpeUBqK3wC8Wo9wVpxgRBMjWdj1mqpxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVf8V9AAoJEPo9qoy8lh71AbAP/1HHM6JIoXpvtrDe9Ct7xkf5
W2eXnhctbNft6qyuF4nJjtnREH/maU1OSE637SuPhGazoVccHe1fVu0MvQ5q1Eep
tv13n1KapMtg4i2fA6E/u1z2P85WP/uMkpwZo6Xj4wz3q6OTOn76pHVTZjB3bAU3
wY530Nnb+s0raa7bDVeSs5XKtYk8MQyDBGYCqFsQ7uqM0m1lGpeNXeCEK75Oeo72
c8PDZmgyGIAfyfc6ya0DlADxZs2lqG2mE5qkaUzoA7g6M3FiPpflh5fmDTeR8AVn
KT0rNCURGY3Suae8ulRCCVFhQQHvIdywfzxccZyP1/1akfuLKeEDDK9bROOUO3Sk
yTgzOha9jaVRwl9vpfoNmAmEQGrGs7JcneH6vWpMGRMddeVp5kTHrzpFKqIgjSS2
DnKmBn9R+G1oaF4op67n+2lstAku0qmd9deK/0dT9geIwORv16Di3br0dz33nmZm
I6oB7C48cKa1gKk3LXD/EaHPAZ76BtihlEmKzn4aAOgeaeDxF4HUi84+QGl+rZiP
QwwuVXfQKQq/TUirD3I54Eyb9pzFcRZNvP2zwaqjX/8AzrmMmzAjuOFUT/GrRwyV
BvOMgR41o5X//kqYir9mAzNYN3jM4rlPzi9/8IBqDHcCdADL/dXxiwFkxp5G1Eb4
kAof3qi86qBkyTQJMTT5
=X30b
-----END PGP SIGNATURE-----

--flpeUBqK3wC8Wo9wVpxgRBMjWdj1mqpxI--
