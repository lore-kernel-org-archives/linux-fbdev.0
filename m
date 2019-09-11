From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 11 Sep 2019 18:44:01 +0000
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <3d8237d0-4e36-3787-6050-b0e75f2fa8c3@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190910212909.18095-1-andreas@kemnade.info>
 <20190910212909.18095-2-andreas@kemnade.info>
 <20190911100851.f4rnldghtmly26oo@holly.lan>
In-Reply-To: <20190911100851.f4rnldghtmly26oo@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Andreas

On 9/11/19 5:08 AM, Daniel Thompson wrote:
> On Tue, Sep 10, 2019 at 11:29:08PM +0200, Andreas Kemnade wrote:
>> add enable-gpios to describe HWEN pin
>>
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>> ---
>> changes in v2: add example
>>   .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-ba=
cklight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-bac=
klight.yaml
>> index dc129d9a329e..1fa83feffe16 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight=
.yaml
>> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight=
.yaml
>> @@ -29,6 +29,10 @@ properties:
>>     '#size-cells':
>>       const: 0
>>  =20
>> +  enable-gpios:
>> +    description: GPIO to use to enable/disable the backlight (HWEN pin).
>> +    maxItems: 1
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -92,6 +96,7 @@ examples:
>>       i2c {
>>           #address-cells =3D <1>;
>>           #size-cells =3D <0>;
>> +        enable-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>;

This is in the wrong place.=C2=A0 This is implying that the gpio is for the=
=20
i2c parent

This needs to go under the led-controller node below

Dan

>>  =20
>>           led-controller@38 {
>>                   compatible =3D "ti,lm3630a";
>> --=20
>> 2.20.1
>>
