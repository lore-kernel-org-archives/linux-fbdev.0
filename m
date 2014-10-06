From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 06 Oct 2014 12:18:57 +0000
Subject: Re: [PATCH] videomode: provide dummy of_get_display_timing helper
Message-Id: <543288B1.8060700@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XVIrHPBQJpFP2vEInKmIvfVhWhoAKXm7C"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1957575.to7BPgiTer@wuerfel>
In-Reply-To: <1957575.to7BPgiTer@wuerfel>
To: linux-fbdev@vger.kernel.org

--XVIrHPBQJpFP2vEInKmIvfVhWhoAKXm7C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/09/14 23:43, Laurent Pinchart wrote:
> Hi Arnd,
>=20
> Thank you for the patch.
>=20
> On Monday 29 September 2014 18:00:33 Arnd Bergmann wrote:
>> If CONFIG_OF is disabled but we build any driver that tries to
>> use of_get_display_timing, we get this link error:
>>
>> ERROR: "of_get_display_timing" [drivers/gpu/drm/rcar-du/rcar-du-drm.ko=
]
>> undefined!
>>
>> This adds an empty inline function as an alternative, to avoid changin=
g
>> each driver using this function when we want to build them without
>> CONFIG_OF.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Shouldn't empty functions also be defined for of_get_display_timings an=
d=20
> of_display_timings_exist ?

I took the liberty of updating the patch.=20

Btw, if I just select "Renesas ARM SoCs (non-multiplatform)", without any=
 of
the "Renesas ARM SoCs System Type" items, I get compile prints like "warn=
ing:
"__LINUX_ARM_ARCH__" is not defined".

And if I select only "ARCH_SH7372", I get "arm-linux-gnueabihf-ld: no mac=
hine
record defined".

In any case, I was able to compile the drivers/gpu/drm/rcar-du/rcar-du-dr=
m.ko,
so I believe the patch is ok.

 Tomi

=46rom bd1815e4bff50b5569d1989aaf9096d14ce71d12 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 6 Oct 2014 15:03:57 +0300
Subject: [PATCH] videomode: provide dummy inline functions for !CONFIG_OF=


If CONFIG_OF is disabled but we build any driver that tries to
use of_get_display_timing, we get this link error:

ERROR: "of_get_display_timing" [drivers/gpu/drm/rcar-du/rcar-du-drm.ko] u=
ndefined!

This adds an empty inline function as an alternative, to avoid changing
each driver using this function when we want to build them without
CONFIG_OF.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/of_display_timing.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/video/of_display_timing.h b/include/video/of_display=
_timing.h
index 79e6697af6cf..3a180c097e7c 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -15,9 +15,26 @@ struct display_timings;
=20
 #define OF_USE_NATIVE_MODE -1
=20
+#ifdef CONFIG_OF
 int of_get_display_timing(struct device_node *np, const char *name,
 		struct display_timing *dt);
 struct display_timings *of_get_display_timings(struct device_node *np);
 int of_display_timings_exist(struct device_node *np);
+#else
+static inline int of_get_display_timing(struct device_node *np, const ch=
ar *name,
+		struct display_timing *dt)
+{
+	return -ENOSYS;
+}
+static inline struct display_timings *of_get_display_timings(struct devi=
ce_node *np)
+{
+	return NULL;
+}
+static inline int of_display_timings_exist(struct device_node *np)
+{
+	return -ENOSYS;
+}
+
+#endif
=20
 #endif
--=20
2.1.1




--XVIrHPBQJpFP2vEInKmIvfVhWhoAKXm7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMoixAAoJEPo9qoy8lh71efYP/R3pM6hkCnyfXM6yjKES8e8S
EQL8ctKR3raY4uLrgsOlaDnMyiXexZJTLoPzl4VxJXoG3OeYd7udwe7ajRVaih1e
Uy5M1sGXNrqpggS/x3idTuHHmpi9pdRiFzNx2e3EL27Yi5fZNwXMIgkoKBsZhxPy
lOo0qC51JZNxt0md/elgFjAgXvpu0f93DuJyOoy+mpXrrf3lwWeluEK5aEZTp9I8
XfJo+FUINLCeAi7Y2pXbf8ZZ9SXWVE9Mi/BZTmJa86PtTUaqs9k2f4eRRUwPdY9x
ycWjHv2ejNoD1mMpfTX7ftcEV5yPwGLG5CtErjcbEm81Ba276BccybJSEJ1DOUlW
gHmjaUAAfM0N9vrxTSh8WIZvQp7+Sl1t4eDPXUySHKBY5gFkTc4STTgnBmWY9wu5
0Xi+GvI22U7Usq9f5H12QbmzwPijs3tB5rpeNgAuc27ETTEn8mjeX9/Kiqr1Cn5x
vkSmIleP+phGo9skyz0HD1uxToWydpLy549R5Y5D2r1cA43+71bxH6uplMqbrPP5
TCfUWwxbzGk5XAOxPayFVxIEnYIsiG+rfHY46etPyESKou5t/Sv3HyXkoFDUew5v
fdnYjIzaR6zPnb5K2YY8Q6yLS+ySRISTQ879B4P4FzJL4OVks6jRW7vIwRPG4PId
gdkbdkfChLY4NbHl0Ygy
=FgIx
-----END PGP SIGNATURE-----

--XVIrHPBQJpFP2vEInKmIvfVhWhoAKXm7C--
