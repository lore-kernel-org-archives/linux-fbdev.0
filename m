From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 18 May 2020 12:48:37 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <3bd8fb59-2a91-64d7-bef9-d5f717c49bfb@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <87d071aedu.fsf@mpe.ellerman.id.au>
 <CGME20200518112226eucas1p1aa59db1e75cf0f91454b8714c828444c@eucas1p1.samsung.com>
 <CACvgo53uWVmhwon4+Fn5=_4HPXSciqNrf1MSJjt1kA3G2wyECw@mail.gmail.com>
In-Reply-To: <CACvgo53uWVmhwon4+Fn5=_4HPXSciqNrf1MSJjt1kA3G2wyECw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, ML dri-devel <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>


On 5/18/20 1:19 PM, Emil Velikov wrote:
> Hi Michael,
>=20
> On Mon, 18 May 2020 at 08:30, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Emil Velikov <emil.l.velikov@gmail.com> writes:
>>> As mentioned in earlier commit, the riva and nvidia fbdev drivers have
>>> seen no love over the years, are short on features and overall below par
>>>
>>> Users are encouraged to switch to the nouveau drm driver instead.
>>>
>>> v2: Split configs to separate patch, enable nouveau (Bartlomiej)
>>>
>>> Cc: Antonino Daplas <adaplas@gmail.com>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>>> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1)
>>> ---
>>> Hi all unless, there are objections I would prefer to merge this via
>>> the drm tree.
>>
>> Have you tested that the resulting kernels work on the relevant
>> hardware?
>>
> Sadly, no I haven't. I'm updating the defconfigs as requested by the
> fbdev maintainer.

I've just noticed that v1 (patch #1/1) & v2 (patch #1/2) lack
Cc: to powerpc Maintainers so they cannot see the context of
changes in this patch.

Also you've proposed v1 yourself and it has already contained
modifications to defconfigs (removal of setting the config
options for the old drivers) in addition to marking the old
drivers as BROKEN.

It now turns out that v1 has also never been tested. :(

Please don't submit untested patches without marking them
as such.

>> The old drivers may be crufty but they presumably have been tested by
>> people and at least somewhat work.
>>
>> So I'd be inclined to leave the defconfigs alone until someone can test
>> that the new driver works at all.

@Michael:

Fully agreed. I would also like you to review/ack patch #1/2:

https://lore.kernel.org/dri-devel/20200517220524.4036334-1-emil.l.velikov@g=
mail.com/

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Works for me.
>=20
>> I gave it a quick spin on a G5 I have access to and dmesg has a bunch of
>> errors in it (see below). I can't actually tell if the display is
>> working because the machine is remote, and I can't go and check it at
>> the moment because the office is closed.
>>
>=20
>>From what I can see, there seems to be three bits:
>  - attempted out-of-bound attempts to read the vbios
> Genuine concern or noise? Likely using the bios from open firmware,
> check any of the other options - see NvBios in [1]
>  - cannot figure out the timer input frequency
> No idea
>  - the TV1 EDID is empty
> Is there an actual TV connected to the device, check with another cable
>=20
> Regardless of the patches, reporting [2] the above would be a nice move.
>=20
> Thanks
> Emil
> [1] https://protect2.fireeye.com/url?k=D6cf7004-8b548c67-d6cefb4b-0cc47a3=
1cdbc-7c3b251c170ed483&q=3D1&u=3Dhttps%3A%2F%2Fnouveau.freedesktop.org%2Fwi=
ki%2FKernelModuleParameters%2F
> [2] https://gitlab.freedesktop.org/xorg/driver/xf86-video-nouveau/-/issues
