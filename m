From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Dec 2015 08:26:06 +0000
Subject: Re: [PATCH 4/4] fbdev: Debug knob to register without holding console_lock
Message-Id: <5666941E.6070807@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MTxuxQofmKHNehxuL3CqW1hDSdWixioNj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440510314-8633-1-git-send-email-daniel.vetter@ffwll.ch>
 <1440510314-8633-4-git-send-email-daniel.vetter@ffwll.ch>
 <5665C2BA.3010304@ti.com> <20151208081916.GA20822@phenom.ffwll.local>
In-Reply-To: <20151208081916.GA20822@phenom.ffwll.local>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--MTxuxQofmKHNehxuL3CqW1hDSdWixioNj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/12/15 10:19, Daniel Vetter wrote:
> On Mon, Dec 07, 2015 at 07:32:42PM +0200, Tomi Valkeinen wrote:
>>
>> On 25/08/15 16:45, Daniel Vetter wrote:
>>> When the usual fbcon legacy options are enabled we have
>>> ->register_framebuffer
>>>   ->fb notifier chain calls into fbcon
>>>     ->fbcon sets up console on new fbi
>>>       ->fbi->set_par
>>>         ->drm_fb_helper_set_par exercises full kms api
>>>
>>> And because of locking inversion hilarity all of register_framebuffer=

>>> is done with the console lock held. Which means that the first time o=
n
>>> driver load we exercise _all_ the kms code (all probe paths and
>>> modeset paths for everything connected) is under the console lock.
>>> That means if anything goes belly-up in that big pile of code nothing=

>>> ever reaches logfiles (and the machine is dead).
>>>
>>> Usual tactic to debug that is to temporarily remove those console_loc=
k
>>> calls to be able to capture backtraces. I'm fed up writing this patch=

>>> and recompiling kernels. Hence this patch here to add an unsafe,
>>> kernel-taining option to do this at runtime.
>>
>> I think this was never merged. This was part 4 of 4, were there
>> dependencies or...? Should I apply this for 4.5?
>=20
> Patches 1-3 have all already landed in drm, and patch 4 is free standin=
g.
> Would be great if you can pull it in.

Ok, I'll apply for 4.5.

>> But then... I think my issues with console lock have been later at
>> runtime, not at register. Maybe we need a module option to disable the=

>> console lock altogether. I wonder how much havoc that might create, th=
ough.
>=20
> Hm, where in fbdev do you hold the console_lock outside of
> registering/unregistering an fbdev (because of fbcon)? There's of cours=
e
> general trouble with console_lock deadlocks and fun like that, but ime
> that all got a lot more manageable since I added lockdep annotations to=

> console_lock.

I don't know... I just have a vague recollection that I was having
trouble with the lock with... crashes during blanking, perhaps. I really
can't remember, so possibly things are better now, or I just remember wro=
ng.

 Tomi


--MTxuxQofmKHNehxuL3CqW1hDSdWixioNj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZpQeAAoJEPo9qoy8lh710FwQAKBbFSiKr1e7kb+vHBf8D478
eMTelLTe1WAV16BiZRCpiOqPFXll2ST6oi8fnqAqTx3QxzYilKGo1Le5qUYrvUz5
4oJK5B4RbuC6/ZMacfX6exU+sgjZgUygs5Q5kFTlOM8hvnBnI2+58Wu6vzMIbOtH
vvmUmLqQB6QFoLLdA8I0JuugDyzHiT+4ZMXpERVMhkSymEQnMtKcr8tqMTGNnm8v
GpzY9gOo9+kfP677nj4Ocjwu1oDre/t0JYaY/DbkYMN/EqlpC3TA0xnam8wtaj3F
eLKbOKSINqAtW/wtEC0xvxMo7owP8oZWc4e5ntfTRj7xb3K6ouyPZnRD7WPbTXSi
DaFk8Q3i5mJGwo5r0DSnNazDaWO9RzF1nkod7iX/NZeCqEzqcwkg+oYRRnjNpdky
jJ14tLbeW0On6tWtG62QuSI64L1AOzkuaVlcUmBIo0zj9K2iq4xOC778OYXZVbhU
8R0Kkyb8XcqkLh/AF8FhFwasO1TLejDWToTIP1npIm5UjxSe9gjmeZPMR0JKXuKV
NAF8yuQR7mhvSOByA5fP/HuCsZcUMIm0Rs1yNQNSelgTHptGuO4gpjfW+BH/tKvz
9tbB/KCps/mW+nSpVCyAdkL+MLzyJgmQd8I5khbJDtNnW6bAcJuP2sPDlf3S2tM+
5yNfq3dUSo391D9dRT3B
=DwBV
-----END PGP SIGNATURE-----

--MTxuxQofmKHNehxuL3CqW1hDSdWixioNj--
