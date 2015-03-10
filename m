From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 11:28:25 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <54FED559.2030506@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KIng2nT6r7IquauMWVweR5qQVnqgpwGSc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>	<1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>	<20150207111821.GN2079@lukather>	<20150207163541.30047a33@maestro.intranet>	<20150212151121.GJ2079@lukather> <20150214152212.1643da7d@maestro.intranet>
In-Reply-To: <20150214152212.1643da7d@maestro.intranet>
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org

--KIng2nT6r7IquauMWVweR5qQVnqgpwGSc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/02/15 16:22, Thomas Niederpr=C3=BCm wrote:
> Am Thu, 12 Feb 2015 16:11:21 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
>> On Sat, Feb 07, 2015 at 04:35:41PM +0100, Thomas Niederpr=C3=BCm wrote=
:
>>> Am Sat, 7 Feb 2015 12:18:21 +0100
>>> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>>>
>>>> Hi,
>>>>
>>>> On Fri, Feb 06, 2015 at 11:28:10PM +0100, niederp@physik.uni-kl.de
>>>> wrote:
>>>>> From: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
>>>>>
>>>>> It makes sense to use vmalloc to allocate the video buffer
>>>>> since it has to be page aligned memory for using it with mmap.
>>>>
>>>> Please wrap your commit log at 80 chars.
>>>
>>> I'll try to do so in future, sorry for that.
>>>
>>>>
>>>> It looks like there's numerous fbdev drivers using this
>>>> (especially since you copy pasted that code, without mentionning
>>>> it).
>>>
>>> Yes, I should have mentioned that in the commit message. As
>>> implicitly indicated in the cover letter the rvmalloc() and
>>> rvfree() are copy pasted from the vfb driver. Honestly, I didn't
>>> give this one too much thought. It seemed a viable solution to the
>>> mmap problem. For a bit more history on that, see my comment below.
>>>
>>>>
>>>> That should be turned into an allocator so that drivers all get
>>>> this right.
>>>>
>>>>> Also deffered io seems buggy in combination with kmalloc'ed
>>>>> memory (crash on unloading the module).
>>>>
>>>> And maybe that's the real issue to fix.
>>>
>>> The problem is solved by using vmalloc ;)
>>
>> Yep, but why do you need to mark the reserved pages?
>>
>> ...
>=20
> As far as I understood mmaped memory is marked as userspace memory in
> the page table and is therefore subject to swapping. The pages are
> marked reserved to make clear that this memory can not be swapped and
> thus lock the pages in memory. See discussions [0,1,2].=20

Why is it a problem if it is swapped? Only CPU uses the memory, as far
as I can see.

Also, isn't doing __pa() for the memory returned by vmalloc plain wrong?

What was the crash about when using kmalloc? It would be good to fix
defio, as I don't see why it should not work with kmalloced memory.

 Tomi



--KIng2nT6r7IquauMWVweR5qQVnqgpwGSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/tVZAAoJEPo9qoy8lh71okcP/R/2rfVseQN+YBGA/ztVgCzz
kjDbYu65jut9Kf3QMnWIiRR7e5DFXj5BZwIE/oVs3hNf7rmZFXed3sWbSO854h3I
oOoIvuO/PI8a8SiVambedlt7gO16u88Vg6xkcqCFsAZh+rJSZbXho5kVnFVy9e9Q
PjxiCWZI7xqFkDAvBsmhfSCR/+LDveUN4e5F/AozolJ7SpMPlYstAlIUi4gqrIS4
ECa1c7jw2qCSDlqD7O74Sij8skGGzPmNFrMRmekgRc5Eh6PalWWLp+Ed6cr0qRxx
RMC86iemXkkBd62pgFL2SyuL0wL0RBdrIJD2B3PvrWuCVejVGFI0HB+z98hxjJg2
d+FRQkWngsITe5XNeYnh3WvHWyKZRDVAF4FXNL/eptPGVuOxo1ObbGt/xONvIbFB
GJkuzrqHXtZrSWAl4RJglvs43aO5W45wRLhl9q7WS4HXZhQSyRw/G9j+BCXfXMR1
hRueED5wMTQxHWLzdqBsrgOUkenN0jyNZIZWTQOmrL3qJriClFaGk5kRmoFHNNqn
zib9K76j4uYTmgKcmghusXbemwZ+Y3ixeQo5DilnoWVB1WO7cmo0DOezLkkSzea7
wcpAu8fPTLQNQb/7GoWeJ6AI6o/LGAUkRJHYKadBcduQ4T3uEL1zRy9AYAW8ocoX
v+iicQ1SNKv68GveH5EU
=PGKe
-----END PGP SIGNATURE-----

--KIng2nT6r7IquauMWVweR5qQVnqgpwGSc--
