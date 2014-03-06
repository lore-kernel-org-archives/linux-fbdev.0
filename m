From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Mar 2014 09:23:24 +0000
Subject: Re: [PATCH 0/4] Cleanups and fix for video/pxa3xx-gcu
Message-Id: <53183E8C.7040507@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="prcTPgW8bmPl6SeDXRTSAQQATx9xdirpJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394035969-32420-1-git-send-email-zonque@gmail.com>
In-Reply-To: <1394035969-32420-1-git-send-email-zonque@gmail.com>
To: linux-fbdev@vger.kernel.org

--prcTPgW8bmPl6SeDXRTSAQQATx9xdirpJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/03/14 11:09, Daniel Mack wrote:
> On 03/06/2014 03:09 AM, Haojian Zhuang wrote:
>> On Thu, Mar 6, 2014 at 12:12 AM, Daniel Mack <zonque@gmail.com> wrote:=

>>> Here are some cleanups for the pxa3xx-gcu driver. Patch 3/4 is actual=
ly
>>> a real bugfix that is needed since the misc code doesn't set
>>> file->private_data for us implicitly anymore.
>>>
>>> The rest are just straight-forward cleanups.
>>>
>>> Thanks,
>>> Daniel
>>>
>>>
>>> Daniel Mack (4):
>>>   video: pxa3xx-gcu: rename some symbols
>>>   video: pxa3xx-gcu: pass around struct device *
>>>   video: pxa3xx-gcu: provide an empty .open call
>>>   video: pxa3xx-gcu: switch to devres functions
>>>
>>>  drivers/video/pxa3xx-gcu.c | 191 +++++++++++++++++++----------------=
----------
>>>  1 file changed, 81 insertions(+), 110 deletions(-)
>>>
>=20
>> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>=20
> Thanks Haojian!
>=20
> Given that this driver doesn't actually have any connection points to
> the framebuffer or video subsystem (despite its location) maybe you can=

> just take these patches through your pxa tree? It's a PXA3xx specific
> device, after all. Jean-Christophe, Tomi - any objections?
>=20
> The driver is also broken since awhile, and the fact that nobody notice=
d
> tells me that our platform is most probably the only real user.

If these do not have any dependencies to non-fbdev patches, and nothing
else has dependencies to these patches, I'd rather take them via fbdev
tree, based on the file location. There shouldn't be any conflicts, but
just in case...

As a side note, I've got a drivers/video/ reorg patch series, possibly
headed for v3.15, which moves the pxa3xx-gcu file to
drivers/video/fbdev/. That's clearly not the right place for it, but I
think it's easier to move it along the other files, and later move it
back to drivers/video/.

 Tomi



--prcTPgW8bmPl6SeDXRTSAQQATx9xdirpJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGD6MAAoJEPo9qoy8lh71XdkQAI8NQ5fwAcVaes5dD0SjaNvG
2ITRcc02jDhsU8Z+gPhBqoXhvACVKzN3wd0+zAUH7VBTxLSWdlQzAdOhOHky6+u8
7mo6sYIi19AE7F8/43xDb8EnBG8S11p2nXOkdb6BZHhsBj4OEK+7w4Se7E5E6os6
nSt6swl8Bk10nO1BPBIVBs6afEPlRKR+O23JSHA2qjv5djzXaq2sYOD9b6swx1vV
cAK3x2oYSfSCrEL7a1IdejJlIyGG0ILy8zQ7GkePM+Yk5oz0kEB6ol3H1FOIMvLE
V6zzkGKX5q+7C3Wb5qmpte7MjF2SllecyXJqW6gNaQUOtzT8ydgtRBueOE2iO+ce
pVZDDRX6uyNLiEbZJcV1UVOeidj+2zvc7E0oJKny+sKfF7Dq4uSL/S2uXcr6IqtH
0YwRecWlr/qpwoHbSRb9XP/gPDDssb8kGs9ZPHAogQnnkA0jmPXPcqUiNRDyp/O1
Y59+lWZMmE+lQBoYnej9tNhxVyDCMHqw5CIc8HF70GH5pRjx2sLryZXgELjulObN
BOD9GBihTlmT6XrcSzrf/yB9vLtqVW+zG5q+KOEG8x8lnyXz9JU+UlC9oYEk4Ngh
KjAvm/LeCgzAHLMIGLZEcAeQiRb0nuLMB0mnpyz9TskpwBhj17n56t3eM5u70tbh
td8STP68C3suyG9bHqio
=HyYn
-----END PGP SIGNATURE-----

--prcTPgW8bmPl6SeDXRTSAQQATx9xdirpJ--
