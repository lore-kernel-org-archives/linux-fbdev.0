From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 29 Jan 2013 12:10:19 +0000
Subject: Re: [PATCH 1/4] pwm_backlight: Fix PWM levels support in non DT case
Message-Id: <5107BC2B.5080400@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358861996-27194-1-git-send-email-peter.ujfalusi@ti.com>
 <1358861996-27194-2-git-send-email-peter.ujfalusi@ti.com>
 <20130128210123.GA24673@avionic-0098.mockup.avionic-design.de>
 <51078580.2000808@ti.com>
 <20130129101709.GC16746@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130129101709.GC16746-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On 01/29/2013 11:17 AM, Thierry Reding wrote:
> On Tue, Jan 29, 2013 at 09:17:04AM +0100, Peter Ujfalusi wrote:
>> On 01/28/2013 10:01 PM, Thierry Reding wrote:
>>> On Tue, Jan 22, 2013 at 02:39:53PM +0100, Peter Ujfalusi wrote:
>>>> It is expected that board files would have:
>>>> static unsigned int bl_levels[] =3D { 0, 50, 100, 150, 200, 250, };
>>>>
>>>> static struct platform_pwm_backlight_data bl_data =3D {
>>>> 	.levels =3D bl_levels,
>>>> 	.max_brightness =3D ARRAY_SIZE(bl_levels),
>>>> 	.dft_brightness =3D 4,
>>>> 	.pwm_period_ns =3D 7812500,
>>>> };
>>>>
>>>> In this case the max_brightness would be out of range in the levels ar=
ray.
>>>> Decrement the received max_brightness in every case (DT or non DT) whe=
n the
>>>> levels has been provided.
>>>
>>> What's wrong with specifying .max_brightness =3D ARRAY_SIZE(bl_levels) =
- 1
>>> instead?
>>
>> There is nothing wrong with that either but IMHO it is more natural for =
board
>> files to use just ARRAY_SIZE(bl_levels). In this way the handling of
>> data->max_brightness among non DT and DT booted kernel is more uniform i=
n the
>> driver itself.
>=20
> The .max_brightness field is defined to be the maximum value that you
> can set the brightness to. If you use .levels and set .max_brightness to
> ARRAY_SIZE() then that's no longer true because the maximum value for
> the brightness will actually be ARRAY_SIZE() - 1.

Yes, in conjunction with .levels it would be better to have .nr_levels inst=
ead
reusing the max_brightness.

> The reason why in the DT case we decrement .max_brightness is that it is
> used as a temporary variable to keep the number of levels, which
> corresponds to ARRAY_SIZE() in your example, and adjust it later on to
> match the definition. That's an implementation detail.
>=20
> Platform data content should be encoded properly without knowledge of
> the internal implementation.
>=20
>> Right now all board files are using only the .max_brightness to specify =
the
>> maximum value, I could not find any users of .levels in the kernel.
>=20
> Yes. But this is the legacy mode which should be considered deprecated.
> The reason why the concept of brightness-levels was introduced back when
> the DT bindings were created was that pretty much no hardware in
> existence actually works that way. This was a topic of discussion at the
> time when I first proposed these changes, see for example:
>=20
> 	http://www.mail-archive.com/devicetree-discuss@lists.ozlabs.org/msg09472=
.html

Right. Now I know the background.
However I do not agree with the conclusion. Probably it is fine in some cas=
es
to limit the number of configurable duty cycles to have only distinct steps.
To not go too far, on my laptop I have:
# cat /sys/class/backlight/acpi_video0/max_brightness
15
# cat /sys/class/backlight/intel_backlight/max_brightness
93

In this case I would be more happier if the user space would use the
intel_backlight than the acpi_video0. I'm fine if user space decides to all=
ow
me only 15 distinct steps on the intel_backlight but I would expect it to do
so in a way when I change the brightness in the UI it would step down or up=
 to
the next user configurable level. Right now it uses the acpi_video0 to cont=
rol
the levels which means that I have (ugly) jumps in the backlight every time=
 I
adjust it.

In my phone and tablet all transitions between backlight levels are smooth.
This is not a case in my laptop (with exception when the backlight is set to
auto, FW controlled).

The perceived brightness change depends on the surrounding environment, you
can not say that in high level you would need less steps or you need to have
less steps in low brightness. If you in a dark room the low changes can be
observed, while the same change when you are outside in a sunny day would n=
ot
reflect the same.

Sure we could do the ramps in driver, but what are the parameters? how many
step between the two level? What is the time between the steps?

If you are about to make a product you will end up specifying all the possi=
ble
steps to provide the best user experience. So if the PWM have 127 duty cycle
you will have levels from 0, 1, 2, 3, ...., 125, 126, 127.

--=20
P=E9ter
