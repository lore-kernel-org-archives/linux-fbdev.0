From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 17 Jan 2019 14:23:19 +0000
Subject: Re: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd, line option
Message-Id: <91d4948b-d68c-f9d6-1ffd-e848851595ab@samsung.com>
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
 <96876402-8860-5c8a-a28f-81f8df58d0ce@samsung.com>
 <672688c8-1115-1cf8-cac9-82c19219ea3a@axentia.se>
In-Reply-To: <672688c8-1115-1cf8-cac9-82c19219ea3a@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Rosin <peda@axentia.se>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Geert Uytterhoeven <geert@linux-m68k.org>


On 01/17/2019 02:40 PM, Peter Rosin wrote:
> On 2019-01-16 17:45, Bartlomiej Zolnierkiewicz wrote:
>> On 01/07/2019 11:35 AM, Peter Rosin wrote:
>>> Right. So, here's an update...
>>>
>>> Again, it would probably be best if this went in before 5.0 is released.
>>>
>>> Changes since v1:
>>> - rename from fbcon=CEnter-logo option to fbcon=3Dlogo-pos:center (and =
adjust
>>>   the help text accordingly).
>>>
>>> Cheers,
>>> Peter
>>>
>>> From ebfb2feb7ea4298ac9c222e6ea6f9c9a92452084 Mon Sep 17 00:00:00 2001
>>> From: Peter Rosin <peda@axentia.se>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: linux-doc@vger.kernel.org
>>> To: linux-kernel@vger.kernel.org
>>> Date: Mon, 7 Jan 2019 08:35:26 +0100
>>> Subject: [PATCH v2] fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a =
cmd
>>>  line option
>>>
>>> A command line option is much more flexible than a config option and
>>> the supporting code is small. Gets rid of #ifdefs in the code too...
>>>
>>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>
>> Patch queued for 5.0, thanks.
>=20
> Hmm, I see the patch on the fbdev-for-next branch, but that sounds
> like stuff destined for 5.1? Maybe you simply don't have any
> fbdev-for-current or fbdev-fixes branch or something like that?

Yes. the single public fbdev branch has been sufficient for now
(there is no active fbdev development and patches for -rcX kernels
are even more rare). OTOH there is no problem with adding -fixes
branch once needed..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
