From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 23 May 2014 12:43:40 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <537F427C.20505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4F9gksPOoqDQBrv8oAncfTIPccsEss7fj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--4F9gksPOoqDQBrv8oAncfTIPccsEss7fj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18/05/14 15:01, Alexander Shiyan wrote:
> Fri, 16 May 2014 15:56:26 -0700 =D0=BE=D1=82 Olof Johansson <olof@lixom=
=2Enet>:
>> On Thu, May 08, 2014 at 01:14:40PM +0300, Tomi Valkeinen wrote:
>>> On 08/05/14 11:27, Alexander Shiyan wrote:
>>>
>>>>>> At this time the driver has three user.
>>>>>> Only one of them should theoretically work.
>>>>>> clps711x-autcpu12 should not work in the absence of memblock_reser=
ve().
>>>>>> clps711x-p720t should not work due to physical address limitation =
as i
>>>>>> noticed before. Board means to use SRAM instead of SDRAM.
>>>>>> Only clps711x-edb7211 should work fine (in theory).
>>>>>> Is this a good reason to replace the driver? I think yes.
>>>>>
>>>>> Ok, if the situation is that bad, maybe we can just switch to the n=
ew
>>>>> driver. Have you verified that those boards do not work from anyone=
? Or
>>>>> asked someone to test the new driver with those boards?
>>>>
>>>> I'm not familiar with other users of this platform .
>>>> I am do not have these boards, all that I have written before that i=
t's just a theory.
>>>> Firm in which I work, uses its own board with CLPS711X CPU , this bo=
ard is the
>>>> only way to check for changes on real hardware .
>>>
>>> Ok. That makes me a bit nervous... You're removing a driver, which ma=
y
>>> (or may not) have been working for other users. And adding a new one,=

>>> which may not (or may) work for the other users.
>>
>> Keep the old one around under another Kconfig name, mark it BROKEN,
>> and if nobody speaks up in a couple of releases, remove it?
>=20
> I like this variant, Tomi are you agree with this?

I don't know. All options sound somewhat bad to me, except if it's clear
nobody uses the old driver.

Anyway, it's rather late for 3.16. I'd like the removal of the old
driver to sit in the linux-next for a while.

Would it be possible to add the new driver along the old driver, and use
the new driver only for the boards you have, and for boards for which
it's clear the the old driver is not working? This could be merged for 3.=
16.

It's not so nice to have two drivers for the same hardware, but in this
case maybe that's not an issue. The old driver doesn't support DT, so no
conflicts there, and for non-DT the driver names seem to be different.

For 3.17, we could remove the old driver, and push that change to
linux-next right after the 3.16 merge window has closed.

Or, if you're fine with it, we can also delay adding the new driver to
3.17, and do both right after the 3.16 merge window has closed. I
personally like this most, so that we have both removal of the old and
adding the new sitting in the linux-next longer, but you might possibly
want the new driver in sooner.

Maybe I'm being overly cautious here, but as I don't have any idea about
the driver and its users, I rather be too cautious than not.

 Tomi



--4F9gksPOoqDQBrv8oAncfTIPccsEss7fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTf0J8AAoJEPo9qoy8lh71ZnIP/iQ1jbfo2FNFod2CQaAzSgdw
PHo4Sz9JxDmuIu6gSFZ1H77OOplmTpnSCxG0FQdTv5FM8OhX1+SoJxJ5IymqWRAd
mNnJpmy2U9eoPEQIzVd3CA2q3opCOGbfhwCTFoz5Vz3wABf6RmLah+cqa5DjqfFR
oNtD7TB9bCXk9evXNDw0U8YJnUd32bDsSb6kTtv7oBR2xHHG2iKdditFXBslqLyp
IDNr8vnMcpCSWimeKo7m66zw/UKNkcEHYFnWpiUGyAe/qlu9O+nqRD/NwtpBwA+9
GsTEzX8UTiTSbbs9ksrrXqbKHsRx/rhD+AUWhBQuOiwAbiwlQpX46d0wDbfGeCOP
4B/8bRpYn2tL2IdJ17JnJ5/3odEUZYhYbsd5xSpNKmamiMjrARCBkCIxtAnJt/GB
97gNV9/cS1upLH19EASp++CeiyC9HsRAHESJELFcpPPI3T0OsYi7jbazytp8F+3n
ovtQrdg+ZfDXf1DAzInuWX5T5NsXOqvwVVvr6TrGsFkxkbxwkxALzX5htWKeGIBE
KEQMKCk+THvPu3tjAq0sYOXABlMr/l4NpCfkXfRJkb+mzYThdCvLZtdFjbTMbtDZ
w8B2W2BuZkH/xT06Q9FMc3zvdk2BvQC/hztGEk7UnrJYqPQpbDQSr932q5nDysB1
n6M9WAgpVNnZ6MOSz+kg
=L4aM
-----END PGP SIGNATURE-----

--4F9gksPOoqDQBrv8oAncfTIPccsEss7fj--
