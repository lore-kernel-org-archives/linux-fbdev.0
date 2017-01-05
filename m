From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 05 Jan 2017 12:26:07 +0000
Subject: Re: [PATCH] fbcon: Fix vc attr at deinit
Message-Id: <231ba295-087a-8913-77ba-89e0c1704709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QBrvK3lXa8gtvhd0DTl4vr0cql4nO3467"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170103150322.10350-1-tiwai@suse.de>
 <s5hfukzq6h7.wl-tiwai@suse.de>
In-Reply-To: <s5hfukzq6h7.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--QBrvK3lXa8gtvhd0DTl4vr0cql4nO3467
Content-Type: multipart/mixed; boundary="Xp1qXbChj0EXEMXhMab7q644kNVLbtkxw";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Takashi Iwai <tiwai@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <231ba295-087a-8913-77ba-89e0c1704709@ti.com>
Subject: Re: [PATCH] fbcon: Fix vc attr at deinit
References: <20170103150322.10350-1-tiwai@suse.de>
 <s5hfukzq6h7.wl-tiwai@suse.de>
In-Reply-To: <s5hfukzq6h7.wl-tiwai@suse.de>

--Xp1qXbChj0EXEMXhMab7q644kNVLbtkxw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/01/17 15:50, Takashi Iwai wrote:
> On Tue, 03 Jan 2017 16:03:22 +0100,
> Takashi Iwai wrote:
>>
>> fbcon can deal with vc_hi_font_mask (the upper 256 chars) and adjust
>> the vc attrs dynamically when vc_hi_font_mask is changed at
>> fbcon_init().  When the vc_hi_font_mask is set, it remaps the attrs in=

>> the existing console buffer with one bit shift up (for 9 bits), while
>> it remaps with one bit shift down (for 8 bits) when the value is
>> cleared.  It works fine as long as the font gets updated after fbcon
>> was initialized.
>>
>> However, we hit a bizarre problem when the console is switched to
>> another fb driver (typically from vesafb or efifb to drmfb).  At
>> switching to the new fb driver, we temporarily rebind the console to
>> the dummy console, then rebind to the new driver.  During the
>> switching, we leave the modified attrs as is.  Thus, the new fbcon
>> takes over the old buffer as if it were to contain 8 bits chars
>> (although the attrs are still shifted for 9 bits), and effectively
>> this results in the yellow color texts instead of the original white
>> color, as found in the bugzilla entry below.
>>
>> An easy fix for this is to re-adjust the attrs before leaving the
>> fbcon at con_deinit callback.  Since the code to adjust the attrs is
>> already present in the current fbcon code, in this patch, we simply
>> factor out the relevant code, and call it from fbcon_deinit().
>>
>> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=3D1000619
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>=20
> Actually not only checkpatch but also I can't find the proper
> maintainer for this...
>=20
> Tomi, could you check and take if it's OK?
>=20
> Ideally, this kind of stuff should have been in rather vt side, I
> suppose.  But since the code is already present in fbcon, it's easier
> to reuse it as a fix for now.

I'm not fbdev maintainer anymore. Added Bartlomiej (and Andrew).

 Tomi


--Xp1qXbChj0EXEMXhMab7q644kNVLbtkxw--

--QBrvK3lXa8gtvhd0DTl4vr0cql4nO3467
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJYbjtfAAoJEPo9qoy8lh71kEkP+KJ1+XsE5qI34KBdJmkXam/M
0nKn5in+8VUrDr5FxtRNf+llZEaOBAdMZw3Q0hpwgbdSQR1dzz5HcbcyYQeHUzHh
2ZUZHNlw0xgAQFDUlZwDhauJqdn1KaWzMOFsdLsbaB/cylwH/8rhr4xdSqcv9/DP
orzRihdZcDUbaKrMBQS2wr8omSIZC1goNe48sU731y5IS87PivsisE6OGAmkBHjl
UFvB6Zn6zxJ2ACeyRDPMx7D7Llcuos77MOvkN7bKB4UKLJ4yFCK+CHNMxwyEmmc6
D4WnIYKqw7EEdgkF5zsaiXLuw6USFN/GWxvT37DxQiofOY2gJbGfMlPOgRZRB67L
C8X33ZiV24JzKonYrSDGItvDYIyz63ccv2Lyq6+LuECiHHnrNi7xYywckq71IT8e
/rFCoZFBokxf6sI8Hg+7JDvm3H6VFOXSFIF+i891S+MLSJVQP2NrGochV/401ivn
ru24T3Yn0GVXVQdWgfIIOIGuS19Ipt1Qwdgbe3NrI9d99pcNkN5Y0LKHum/OLQGs
dgZQMvcA4kXddAfp+9aF8jzXDf9qPy87R0yl7oy0E8xVCGM2JwBjV+wciZB93VEk
qkRGPp0qJ3cYpXHKtDfXPuEcZ3JCOpDrfMd1sDaZF6SFQxtgxgY4yJ2HqU7h201S
TlXuf+V6CnwVYPlWLOs=
=QUZn
-----END PGP SIGNATURE-----

--QBrvK3lXa8gtvhd0DTl4vr0cql4nO3467--
