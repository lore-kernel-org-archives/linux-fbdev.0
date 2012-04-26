From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 26 Apr 2012 06:44:11 +0000
Subject: Re: [PATCH 0/4] video: add support for the AUO-K190X epd controllers
Message-Id: <4F98EEBB.5030704@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203281932.55438.heiko@sntech.de>
In-Reply-To: <201203281932.55438.heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Heiko,

On 04/24/2012 01:44 PM, Heiko St=FCbner wrote:
> Hi Florian,
>=20
> Am Mittwoch, 28. M=E4rz 2012, 19:32:54 schrieb Heiko St=FCbner:
>> This series adds basic support for the AUO-K190X family of epaper
>> controllers which consists at the moment of the K1900 and K1901.
>>
>> These controllers are used mostly in the OEM line of Qisda ebook readers
>> sold under different brands worldwide. Among those are the Medion/Thalia
>> Oyo 1 + 2, the bq Avant and Avant 3, the Asus eeeReader DR-900, BenQ K60
>> and dozens more.
>>
>> The _dpy_update, _dpy_update_pages and _need_refresh functions are
>> intentional duplicated. Currently they do the same, but as the
>> controllers emit a greatly different runtime behaviour there is a lot
>> of room for future controller-specific performance improvements.
>>
>> The series also includes the patch which adds a first_io callback to
>> defio. This creates a nice way to parallelise the wakup when it is known
>> that the controller is needed at the end of the defio cycle.
>=20
> ping on this series?
>=20
> Is anything more needed?

I wanted to do do a patch to show you what I want but didn't find the
time to do so, so I'll try to explain it:

If I remember correctly the problem with the patches is the Kconfig menu
structure as "make menuconfig" shows it: Your driver ends up in the
graphics system and not in the framebuffer subsystem. The problem is the
invisible entry you add, it has no dependency on the FB subsystem and
therefore terminates the framebuffer menuconfig. The easy fix would be
to make it depend on fb but I'd consider it nicer to change the hidden
entry into a menunconfig one and let the individual drivers depend on it
rather than select it.


Best regards,

Florian Tobias Schandinat

>=20
>=20
> Thanks
> Heiko
>=20
>> Heiko Stuebner (4):
>>   fb_defio: add first_io callback
>>   video: auo_k190x: add code shared by controller drivers
>>   video: auo_k190x: add driver for AUO-K1900 variant
>>   video: auo_k190x: add driver for the AUO-K1901 variant
>>
>>  drivers/video/Kconfig       |   28 ++
>>  drivers/video/Makefile      |    3 +
>>  drivers/video/auo_k1900fb.c |  198 ++++++++
>>  drivers/video/auo_k1901fb.c |  251 +++++++++++
>>  drivers/video/auo_k190x.c   | 1038
>> +++++++++++++++++++++++++++++++++++++++++++ drivers/video/auo_k190x.h   =
|=20
>> 129 ++++++
>>  drivers/video/fb_defio.c    |    4 +
>>  include/linux/fb.h          |    1 +
>>  include/video/auo_k190xfb.h |  106 +++++
>>  9 files changed, 1758 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/video/auo_k1900fb.c
>>  create mode 100644 drivers/video/auo_k1901fb.c
>>  create mode 100644 drivers/video/auo_k190x.c
>>  create mode 100644 drivers/video/auo_k190x.h
>>  create mode 100644 include/video/auo_k190xfb.h
>=20
>=20

