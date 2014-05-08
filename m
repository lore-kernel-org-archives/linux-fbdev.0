From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 May 2014 10:14:40 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <536B5910.1060403@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dalacuw7lXRHjoTQIA4AJp1Sm6cmDeaEr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--dalacuw7lXRHjoTQIA4AJp1Sm6cmDeaEr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/05/14 11:27, Alexander Shiyan wrote:

>>> At this time the driver has three user.
>>> Only one of them should theoretically work.
>>> clps711x-autcpu12 should not work in the absence of memblock_reserve(=
).
>>> clps711x-p720t should not work due to physical address limitation as =
i
>>> noticed before. Board means to use SRAM instead of SDRAM.
>>> Only clps711x-edb7211 should work fine (in theory).
>>> Is this a good reason to replace the driver? I think yes.
>>
>> Ok, if the situation is that bad, maybe we can just switch to the new
>> driver. Have you verified that those boards do not work from anyone? O=
r
>> asked someone to test the new driver with those boards?
>=20
> I'm not familiar with other users of this platform .
> I am do not have these boards, all that I have written before that it's=
 just a theory.
> Firm in which I work, uses its own board with CLPS711X CPU , this board=
 is the
> only way to check for changes on real hardware .

Ok. That makes me a bit nervous... You're removing a driver, which may
(or may not) have been working for other users. And adding a new one,
which may not (or may) work for the other users.

>> I'm still not really happy about it, and I'd much rather see the curre=
nt
>> driver fixed. But if no one having those boards is up to the task
>> (probably not if they have not been working at all), maybe just ditchi=
ng
>> the old driver and adding a new is the only way forward.
>>
>> One change that I think would be good is to change the series to first=

>> remove the old driver, and then add the new one, with the same file na=
me
>> as the old one. That way git log will show the history for both the ne=
w
>> and the old driver.
>=20
> In this case git-bisect will be broken. Is this OK?

I think this is such a big change for the users of the driver that it's
not an issue. Of course, kernel should still build at all steps, but I
think it's fine if the fb driver in question will be out for a commit or
two.

 Tomi



--dalacuw7lXRHjoTQIA4AJp1Sm6cmDeaEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTa1kQAAoJEPo9qoy8lh717YkP/0vig/79F+c9fL0La15yxXO7
yFXKu1fjucdXji3pB8h2hH9jew8VpMlRzcnh+GjugiUeXk2mFQvG+GKT20Ro0sUY
5WCkBNdS30GM0iCL2+mCDlXxWtz1Nyxz+/yeNMkoixB6BsF1k94XerfHnzYsLmC6
zdwVwTyYweTKPnIYXyetDTfQCM9YYMJlwpXDbmKd2t1vTTxVB8jLYFDAJdZCYvc5
rJDF+oWl7jkdkRZ6hUhG5nnb58QU0qR8qFSBg3hRFF4c7bsYAWzGd/QYj6ScmSDu
SQYHNFHNSnMrhHy2Ph6czppjS+wXsDaBKXFhCkOm/W3e/luujivoLM4TByocCB4q
A3xPVB1/TIsYqgN8qHq7576pUqJ2WGYuROAswxJciUibG2y1U/01YJMDBo3MTxig
Smo/q8al1Cl8yENAHvEGOgUgkB+YWMYAZokMTeGiK1Hj9KUWLAtJX3w3QwfMiiCn
lCi2BGQMSpaM3rPYGz7qI4mrA8EBhKpwns++Nir43mWHt8Rp+lodGaakIe0Gsatt
WJSp/hxk3EAytkJzNNTqqWvOXn5gxpiyVKiqTK7w+/vLrAojJkVqlj+SvwJ7GwKk
3AmiasyfYlrWJNRq/LYwYHKmP2bAXJh/t1NpJT2eDKi8zdcNRf8tK4b7kFqlbjnd
YjXOHMIIU5aFt1PO17a/
=mPG+
-----END PGP SIGNATURE-----

--dalacuw7lXRHjoTQIA4AJp1Sm6cmDeaEr--
