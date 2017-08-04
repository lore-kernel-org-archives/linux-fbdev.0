From: David Lechner <david@lechnology.com>
Date: Fri, 04 Aug 2017 01:16:54 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <959f607c-f2ee-51d8-db39-1ef91859f22f@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <5d8f6518-8d7e-c029-2da4-e3417afb3e40@lechnology.com>
 <28188f5c-1daf-121b-6daf-1899668c3875@tronnes.org>
 <1ce36d43-b9dd-807e-23aa-bac4fda70fdc@lechnology.com>
 <bfb3d541-856b-0233-dd85-72512788939f@tronnes.org>
 <bbec0574-311a-e1b4-d7fd-f6fb15b078d2@lechnology.com>
 <b8ec0511-afd1-2a1b-6ffe-dfe951d79bf7@tronnes.org>
 <cf740449-c952-08d4-d63c-d92e71fa3092@lechnology.com>
 <CAHp75Vdaq0ersEa2_XneUQtsJMj2GCRZL4Wi=1HQorLkb4SaVg@mail.gmail.com>
 <CAHp75Vf2GVASatG_aJrBPNHR-jQLoYtOPan5ezcoWRDuEsXbNw@mail.gmail.com>
 <260320c5-8064-6388-168b-acad5a1aa0f2@tronnes.org>
 <03f423be-7b4c-13ec-7126-c0d9af6ebe4a@lechnology.com>
In-Reply-To: <03f423be-7b4c-13ec-7126-c0d9af6ebe4a-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>

On 08/03/2017 08:08 PM, David Lechner wrote:
> On 08/03/2017 03:11 PM, Noralf Tr=C3=B8nnes wrote:
>>
>> Den 03.08.2017 19.11, skrev Andy Shevchenko:
>>> On Thu, Aug 3, 2017 at 8:09 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Thu, Aug 3, 2017 at 6:18 PM, David Lechner <david@lechnology.com>=20
>>>> wrote:
>>>>
>>>>> The particular display I have is this one:
>>>>> http://wiki.seeed.cc/Grove-OLED_Display_1.12inch/
>>>>>
>>>>> It looks like it uses a command/data scheme like the MIPI displays,=20
>>>>> but
>>>>> doesn't use any of the standard values for the commands. The=20
>>>>> controller can
>>>>> do parallel, SPI and I2C, but the display I have is wired for I2C.
>>>> It looks very similar to ssd1306. Some description refers to ssd1308.
>>> http://www.mouser.com/catalog/specsheets/Seeed_104030008.pdf
>>>
>>
>> That pdf refers to another one:=20
>> http://wiki.seeed.cc/Grove-OLED_Display_0.96inch/
>> There's an fbdev driver that supports ssd1305, ssd1306, ssd1307 and=20
>> ssd1309:
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/display/ssd=
1307fb.txt=20
>>
>> http://elixir.free-electrons.com/linux/latest/source/drivers/video/fbdev=
/ssd1307fb.c=20
>>
>> Maybe the ssd1308 will work with that driver...
>>
>=20
> The display I have uses a ssd1327 controller. It is 16-bit grayscale.=20
> The ssd130x are all 1-bit monochrome. So, probably more like the ssd1325 =

> driver in fbftf.

correction, 4-bit grayscale
