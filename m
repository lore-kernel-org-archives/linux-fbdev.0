From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Aug 2015 09:00:37 +0000
Subject: Re: [PATCH] fbdev: select versatile helpers for the integrator
Message-Id: <55CC5CB5.50502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lBEsar65PV6lt1UhoQFbme7QHju050Dac"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1438090272-26266-1-git-send-email-linus.walleij@linaro.org>
To: linux-fbdev@vger.kernel.org

--lBEsar65PV6lt1UhoQFbme7QHju050Dac
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/08/15 11:59, Linus Walleij wrote:
> On Mon, Aug 10, 2015 at 11:19 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>> On 10/08/15 12:03, Linus Walleij wrote:
>>> On Tue, Jul 28, 2015 at 3:31 PM, Linus Walleij <linus.walleij@linaro.=
org> wrote:
>>>
>>>> Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
>>>> "video: move Versatile CLCD helpers" missed the fact
>>>> that the Integrator/CP is also using the helper, and
>>>> as a result the platform got only stubs and no graphics.
>>>> Add this as a default selection to Kconfig so we have
>>>> graphics again.
>>>>
>>>> Fixes: 11c32d7b6274 (video: move Versatile CLCD helpers)
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> Ping on this.
>>>
>>> Shall I take this into ARM SoC instead?
>>
>> Sorry, I still haven't gotten into dealing with fbdev related mails
>> after my vacation...
>>
>> This is needed for 4.2, right? I can pick this up.
>=20
> In theory, it's not like it's regressing the world. I'm fine with
> 4.3 at this point of you just keep the Fixes:... tag.

It's in Linus' tree already.

 Tomi


--lBEsar65PV6lt1UhoQFbme7QHju050Dac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVzFy1AAoJEPo9qoy8lh71Ql0QAJNJkCHh6+I3vH/Cs0R1R1Od
gBqn/O0g6vKjXnoHl99IAFzZYj2dDjJM+pUmQLMfc/uho7LJGBm07LgQ1DyN2AMc
Dc7v7zlFdu0xv9b4ZmKZ2MyuZIbjbxo8mk9CYSfT+0ilI7yc9iExa3KhIDQB7oRf
VMOIPAzuMhEfFwL6D3U7DPYnif/2vqXF++w/s5f5FLhMo2+b9orrihq+4tFtoYCm
2hBQqMriwgRwABt2u2/3mo7GosK+BRgkjgAgdWoc/XwUCZw8St4u6pffEKrI0lkL
ArhkS7xo84Igq0nRKMsRZa5LEVJdEskjFQWoxt6uU5M6e4WwuO8VrvQ1O4IWAqg4
6imrz9cssMA0B26wofegK0UVX1CgofiI8v/Y/VDCL3XPo8PhoDOr3r+yWYzbdxXi
C+riLlP+QpLFPAQ+wPUkmqsdDkUy3NVKmXbHPeKYiKLPc/CNXxlP2ig4fU44LgSo
fHXb2CGhgi5t/X9EfRo3Lw9qtZb6AqLWrVIMBPKTQHWGOehX0PjbovMqkn+5D64C
Vy9tdeLdywpr60B/cg6+E/SWoEaAj02a/nXaT+oXovvZgWYM++c/RdsZh1apRjlC
vdggeJQLDrpOXer9LxaDl3KPNlEg5WGk15E5CFLW6e5DtvtYumqkIlFpEn5yH3lO
GVaPM+91MxqOHY71RST0
=MI/m
-----END PGP SIGNATURE-----

--lBEsar65PV6lt1UhoQFbme7QHju050Dac--
