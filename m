From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Sep 2015 12:35:27 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55ED848F.2060906@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Hx8JkPXko2nF07CurHe3xpXnMIhcS1RBe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com>
In-Reply-To: <55DC6CB9.5060301@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--Hx8JkPXko2nF07CurHe3xpXnMIhcS1RBe
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/08/15 16:25, Jacek Anaszewski wrote:
> Hi Tomi,
>=20
> Thanks for the patch. Generally, I'd prefer to add files
> drivers/leds/of.c and include/linux/of_leds.h and put related functions=

> there. Those functions' names should begin with "of_". Please provide

Ok, I'll do that. I do need to export something from led-class in that
case, so that the of.c gets hold of 'leds_class' pointer, either
directly or indirectly.

> also no-op versions of the functions to address configurations when
> CONFIG_OF isn't enabled. I have also few comments below.

Yep. No-ops for the purpose of making the kernel image smaller? I do
think the current code compiles and works fine with CONFIG_OF disabled
(although I have to say I don't remember if I actually tested it).

>> +struct led_classdev *of_led_get(struct device_node *np)
>> +{
>> +    struct device *led_dev;
>> +    struct led_classdev *led_cdev;
>> +    struct device_node *led_node;
>> +
>> +    led_node =3D of_parse_phandle(np, "leds", 0);
>> +    if (!led_node)
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    led_dev =3D class_find_device(leds_class, NULL, led_node,
>> +        led_match_led_node);
>=20
> Single of_node_put(led_node) here will do.

Right.

>> +    if (!led_dev) {
>> +        of_node_put(led_node);
>> +        return ERR_PTR(-EPROBE_DEFER);
>> +    }
>> +
>> +    of_node_put(led_node);
>=20
>> +    led_cdev =3D dev_get_drvdata(led_dev);
>> +
>> +    if (!try_module_get(led_cdev->dev->parent->driver->owner))
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    return led_cdev;
>> +}
>> +EXPORT_SYMBOL_GPL(of_led_get);
>> +/**
>> + * led_put() - release a LED device
>> + * @led_cdev: LED device
>> + */
>> +void led_put(struct led_classdev *led_cdev)
>> +{
>> +    module_put(led_cdev->dev->parent->driver->owner);
>> +}
>> +EXPORT_SYMBOL_GPL(led_put);
>=20
> Please move it to include/linux/leds.h, make static inline and provide
> also no-op version for the case when CONFIG_LEDS_CLASS isn't enabled.

Ok. Why do you want it as static inline in the leds.h? I usually like to
keep the matching functions (get and put here) in the same place.

 Tomi


--Hx8JkPXko2nF07CurHe3xpXnMIhcS1RBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7YSPAAoJEPo9qoy8lh71A3QP/jfR9Ge+HTiCkZ4qUHKP0eUh
am/5tldsmYplARlWqJb5mY+67kab5AiFdlVmw2RwMaa5Wh4jldOWICzR68BCvyPF
3d8BlHvuxWOykAxAdbu2i3p0E2WN56UpilW70ZDmC9uN7YsHvijFfm5hQEosA3sk
y7xSfxW4af7VqPXdrHUJHXfBuwFo8kna4ouTISJV9DbrpI3cNHfAK6SB3q4BFtW4
YrCvMTBkxgvi350r1E/FWqqxdvDCWweaXTE0t20U/fFtGuJi4VGMhYesREY2UTmK
F5yyNqq2+qimD1AaWVIAJqTSp7y5Ovm7VOb4tHHFfjd9FSMWJXdZbPOlLbLfuLD/
60eM/Xdx9SHZkRg2hUpLckeuw+oKaKGZHk8mNUD3YK+Ij36sSIjtIKJoNaU87ipH
nG0172HQNswFlxhB1mSpYefuY77pRbpqFd4Yjr9BFiXd7uq8gyaCEj973ZY+0d1l
DnyURCVK/nFfPLlGc6w3NKfeCA7HijmJU+Cu7XOnrqAgPr3sNbAiFsOgBfDneWLk
6iQF7hf7lq+7l6q7e7vcsOFxVbaAqc7lKVEnIvydXmhMCeCL4lXg4p5UFc2JjJCA
lJydyPPKLYYhpA/HfHBjL0JIKDFVjTc9zC/FpwuuSCqRocaRmOCZYh9Jz1WL6rOu
mi2q7AGxLxtutjSQt4Ef
=To3T
-----END PGP SIGNATURE-----

--Hx8JkPXko2nF07CurHe3xpXnMIhcS1RBe--
