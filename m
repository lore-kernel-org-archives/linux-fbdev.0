From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Sep 2015 11:58:19 +0000
Subject: Re: [PATCH v2 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <55E6E45B.5030500@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aIAxc5BEDwbmcsxmoaXr7QMErPqVEhc4K"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437192539-14150-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55E5A7BC.8060003@ti.com> <20150901135514.GB15833@sudip-pc>
In-Reply-To: <20150901135514.GB15833@sudip-pc>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org

--aIAxc5BEDwbmcsxmoaXr7QMErPqVEhc4K
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 01/09/15 16:55, Sudip Mukherjee wrote:
> On Tue, Sep 01, 2015 at 04:27:24PM +0300, Tomi Valkeinen wrote:
>>
>>
>> On 18/07/15 07:08, Sudip Mukherjee wrote:
>>> Now since all cleanups are done and the code is ready to be merged le=
ts
>>> move it out of staging into fbdev location.
>>
>> Have you considered writing a DRM driver for this? I'm not happy at al=
l
>> adding new fbdev drivers, as the DRM framework is much better,
>> supported, and continuously improved. With fbdev you end up with thing=
s
>> like module parameters used to define video modes etc, which is just u=
gly.
> Yes, I am working on a DRM driver, but since these are all voluntary
> work it is taking time. And Greg has already merged it.
>>
>> Anyway, some comments below.
> Some replies inline and remaining I will fix and send patches to you.

Wouldn't the time be better spent on the DRM driver?

This driver will be obsolete immediately when there's a DRM driver for
this device, and then it'll be yet another obsoleted fbdev driver we
need to maintain.

>>> +static const struct vesa_mode vesa_mode_table[] =3D {
>>> +	{"0x301", 640,  480,  8},
>>> +	{"0x303", 800,  600,  8},
>>> +	{"0x305", 1024, 768,  8},
>>> +	{"0x307", 1280, 1024, 8},
>>> +
>>> +	{"0x311", 640,  480,  16},
>>> +	{"0x314", 800,  600,  16},
>>> +	{"0x317", 1024, 768,  16},
>>> +	{"0x31A", 1280, 1024, 16},
>>> +
>>> +	{"0x312", 640,  480,  24},
>>> +	{"0x315", 800,  600,  24},
>>> +	{"0x318", 1024, 768,  24},
>>> +	{"0x31B", 1280, 1024, 24},
>>> +};
>>
>> We have "vesa_modes" in include/linux/fb.h. What is the above table fo=
r?
> The resolutions that are supported along with the kernel boot parameter=

> to point to the resolution to boot with.

Why does the user need to give such hex values? Why not modes according
to Documentation/fb/modedb.txt?

>>> +
>>> +/*******************************************************************=
***
>>> +			 SM712 Mode table.
>>> + *******************************************************************=
***/
>>> +static const struct modeinit vgamode[] =3D {
>>> +	{
> <snip>=09
>>> +		{	/*  Init_CR90_CRA7 */
>>> +			0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
>>> +			0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
>>> +			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
>>> +		},
>>> +	},
>>> +};
>>
>> What are these tables above for?
> Different register settings based on the display resolution. Do you wan=
t
> me to do anything with these vgamode table and the vesa_mode_table?

The vgamode table looks quite horrible. It's unmaintainable, and with a
quick look it seems to have lots of repetition. Large blocks of the data
for different modes are the same.

I don't know what the register there are, but I'd imagine you could
write generic functions like, say, "set_timings", which takes normal
linux videomode struct and writes those settings to the registers.

There should be no such bulk-write register tables in a proper driver,
except in some very special cases.

 Tomi


--aIAxc5BEDwbmcsxmoaXr7QMErPqVEhc4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5uRbAAoJEPo9qoy8lh71b4EQAKMO+1IVzdXaRXYsBm9qsIIS
4PJnw5gHNPOVp+Hh/XPWMbz8uJgygci2x8YIE6hr/ceYbVqnOstbvjXCYBmlebu9
PaKeQcNnGNnG/yJ/8l+oK6t5QOgDFhVj1O/eCsdCAg1o1xZ/4p89+4wm8c3YwAOc
7RtJKXjPAhI/2FkuTnCn8NuWL5oy1DJu6hjAsp3ufkwriQo4+nihRF1AhGJpv9z2
WAC8PRRtpxLmfO5ennPaTK2a+HxnNXAxokj4NkfS98yeHHN7A8FmKZTv+NDPupTa
SVrmRGdHB7/8b1SmsW3uUCn/kL3IGGv5I4hKf9AVL7Ifuz3M0r+IOQgQDvbgbsgg
5QC9obRxsVO6OlTZBteYc5Cvf9QZPJ0HkaEdyY0X/Wjg1/a1kJTKXb7tYBpr5LGk
45D2DgwKUd+l6dYcNULq/vHXFaTq4jIKFvkjbRU1Dm9jHxBe3QFeJOvLQNEL0+nV
bV2TRzc2dxfxw07JlPKNMI4NOPvpJFEQNq7N0+oBSPDdf2Cak+2GNtVwh6/nSPBR
o7068RjGYpNaFjT3qL6PrkYMbkY/+rS15Xk1ICZiIxlmQwdsN1aBCGBveGyNNuxS
TleUtvbOoM4ncZqLseNlU1eY4HoPadhCr0my6xFEGl/8uUkEcHo/inmM51XkFH3K
RxZeKr0hiCiZOK+0sk1q
=gFFb
-----END PGP SIGNATURE-----

--aIAxc5BEDwbmcsxmoaXr7QMErPqVEhc4K--
