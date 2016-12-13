From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Date: Tue, 13 Dec 2016 07:18:49 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <de9b257e-1ce1-c5ca-b3b4-8fce369361a7@daenzer.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <20161209084154.rp4wqzv46tuvf3jv@phenom.ffwll.local>
 <1481284087.27965.13.camel@kernel.crashing.org>
 <20161209133512.nuohi42ho3rgghau@phenom.ffwll.local>
 <1481315223.17253.15.camel@kernel.crashing.org>
In-Reply-To: <1481315223.17253.15.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On 10/12/16 05:27 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2016-12-09 at 14:35 +0100, Daniel Vetter wrote:
>>> As for multi userspace client, well, swapping an mmap between HW and
>>> memory backing store is a somewhat solved problem already.
>>
>> Hm, I didn't know that, but then all existing drm drivers have fairly
>> simplistic fbdev mmap implementations.
>=20
> Hrm, I though the TTM did it ... I remember talking with Thomas
> Hellstrom about that back in the day... you use unmap_mapping_range
> to unmap the existing mappings basically so you can take new faults
> and route them to a different page, but I can't see a call in there
> so maybe he ended up not doing it.

I think he did, it was working fine for userspace mappings when I tried
making radeon use a non-pinned BO for fbdev years ago (the problem was
fbcon potentially trying to access the framebuffer at the most
inconvenient times). There's still ttm_fbdev_mmap, but I'm not sure
everything to make this fully work for userspace fbdev mappings is still
there.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd.c=
om
Libre software enthusiast             |             Mesa and X developer
