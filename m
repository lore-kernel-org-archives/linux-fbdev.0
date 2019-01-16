From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 16 Jan 2019 16:45:52 +0000
Subject: Re: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd, line option
Message-Id: <96876402-8860-5c8a-a28f-81f8df58d0ce@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126215725.2548-1-peda@axentia.se>
 <20181126215725.2548-3-peda@axentia.se>
 <CAMuHMdVfoRP_yNL5HcmwwV3fn9GqnsbORtG_hOhWw3qUeMKFKQ@mail.gmail.com>
 <37be75aa-7a63-a937-6de7-777a31af741b@axentia.se>
 <CAMuHMdXR2iuftV26s-EnKo74vZxcW2w_R1dD_Mk+Ug8MsNwL3Q@mail.gmail.com>
 <cb772a2f-2d33-6d0e-9ea6-ba9eb49023f9@axentia.se>
 <662db203-ae18-4a11-7b10-3d7d480f6f37@axentia.se>
 <CAMuHMdXMidVgtz-T8PZDUrKAwJmz9B4g1hNgw6FwrCpU-m5Gew@mail.gmail.com>
 <CGME20190107103630epcas3p1939481c5a659d9dd0f11d026d7f4c4e1@epcas3p1.samsung.com>
 <6a9be31e-0bb4-d477-99e6-6cac3cd5087f@axentia.se>
In-Reply-To: <6a9be31e-0bb4-d477-99e6-6cac3cd5087f@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Geert Uytterhoeven <geert@linux-m68k.org>


On 01/07/2019 11:35 AM, Peter Rosin wrote:
> On 2019-01-07 10:11, Geert Uytterhoeven wrote:
>> Hi Peter,
>>
>> On Mon, Jan 7, 2019 at 10:03 AM Peter Rosin <peda@axentia.se> wrote:
>>> On 2019-01-07 09:59, Peter Rosin wrote:
>>>> On 2019-01-07 09:40, Geert Uytterhoeven wrote:
>>>>> On Mon, Jan 7, 2019 at 9:26 AM Peter Rosin <peda@axentia.se> wrote:
>>>>>> On 2019-01-06 10:33, Geert Uytterhoeven wrote:
>>>>>>> On Mon, Nov 26, 2018 at 10:59 PM Peter Rosin <peda@axentia.se> wrot=
e:
>>>>>>>> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of the=
se
>>>>>>>> extra logos are not considered when centering the first logo verti=
cally.
>>>>>>>>
>>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>>
>>>>>>>> --- a/drivers/video/logo/Kconfig
>>>>>>>> +++ b/drivers/video/logo/Kconfig
>>>>>>>> @@ -10,6 +10,15 @@ menuconfig LOGO
>>>>>>>>
>>>>>>>>  if LOGO
>>>>>>>>
>>>>>>>> +config FB_LOGO_CENTER
>>>>>>>> +       bool "Center the logo"
>>>>>>>> +       depends on FB=3Dy
>>>>>>>> +       help
>>>>>>>> +         When this option is selected, the bootup logo is centere=
d both
>>>>>>>> +         horizontally and vertically. If more than one logo is di=
splayed
>>>>>>>> +         due to multiple CPUs, the collected line of logos is cen=
tered
>>>>>>>> +         as a whole.
>>>>>>>> +
>>>>>>>
>>>>>>> Isn't a kernel command line option more suitable to configure the p=
osition
>>>>>>> of the logo?
>>>>>>
>>>>>> That didn't occur to me previously, but it does make sense now that =
you
>>>>>> mention it. This is on top of v5.0-rc1, and if applied before v5.0 we
>>>>>> can avoid possible regressions for folks who might start to rely on
>>>>>> CONFIG_FB_LOGO_CENTER if v5.0 is released w/o this.
>>>>>>
>>>>>> Cheers,
>>>>>> Peter
>>>>>>
>>>>>> From de7353ab519ba9b5c9ea3f62d607bb8e94b687cc Mon Sep 17 00:00:00 20=
01
>>>>>> From: Peter Rosin <peda@axentia.se>
>>>>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>>> Cc: Peter Rosin <peda@axentia.se>
>>>>>> Cc: dri-devel@lists.freedesktop.org
>>>>>> Cc: linux-fbdev@vger.kernel.org
>>>>>> Cc: linux-doc@vger.kernel.org
>>>>>> To: linux-kernel@vger.kernel.org
>>>>>> Date: Mon, 7 Jan 2019 08:35:26 +0100
>>>>>> Subject: [PATCH] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a =
cmd line
>>>>>>  option
>>>>>>
>>>>>> A command line option is much more flexible than a config option and
>>>>>> the supporting code is small. Gets rid of #ifdefs in the code too...
>>>>>>
>>>>>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/Documentation/fb/fbcon.txt
>>>>>> +++ b/Documentation/fb/fbcon.txt
>>>>>> @@ -163,6 +163,12 @@ C. Boot options
>>>>>>         be preserved until there actually is some text is output to =
the console.
>>>>>>         This option causes fbcon to bind immediately to the fbdev de=
vice.
>>>>>>
>>>>>> +7. fbcon=CEnter-logo
>>>>>> +
>>>>>> +       When this option is selected, the bootup logo is centered bo=
th
>>>>>> +       horizontally and vertically. If more than one logo is displa=
yed due to
>>>>>> +       multiple CPUs, the collected line of logos is centered as a =
whole.
>>>>>> +
>>>>>
>>>>> What about making this more generic, than an option specific for cent=
ering?
>>>>> Else people want fbcon=3Dleft-logo or fbcon=3Dright-logo soon?
>>>>>
>>>>>     fbcon=3Dlogo-pos:<pos>
>>>>>
>>>>> With <pos> being "center", "left", "top", "right", "bottom", and comb=
inations
>>>>> like "top,center"? Or is that complicating stuff too much?
>>>>
>>>> I'm not too keen on implementing all that when I have zero use for it.=
 I can
>>>> however rename the trigger for the existing fb_center_logo bool to
>>>>
>>>>       fbcon=3Dlogo-pos:center
>>>>
>>>> and add a check for "top,left" to reset the bool to false. Then the ot=
her
>>>> variants can be added later by whomever and when needed.
>>>>
>>>> Is that good enough?
>>>
>>> Ouch, I just realized that using a comma is a no-go, as that is already
>>> separating fbcon suboptions, so I suggest top-left instead.
>>
>> Sure, sounds fine to me.  I just want to avoid having a parameter system
>> that complicates future extension.
>> I think you can drop the check for top-left, as the bool defaults to fal=
se.
>=20
> Right. So, here's an update...
>=20
> Again, it would probably be best if this went in before 5.0 is released.
>=20
> Changes since v1:
> - rename from fbcon=CEnter-logo option to fbcon=3Dlogo-pos:center (and ad=
just
>   the help text accordingly).
>=20
> Cheers,
> Peter
>=20
> From ebfb2feb7ea4298ac9c222e6ea6f9c9a92452084 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Date: Mon, 7 Jan 2019 08:35:26 +0100
> Subject: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd
>  line option
>=20
> A command line option is much more flexible than a config option and
> the supporting code is small. Gets rid of #ifdefs in the code too...
>=20
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Patch queued for 5.0, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
