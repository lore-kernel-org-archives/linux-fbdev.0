From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Jan 2016 13:39:06 +0000
Subject: Re: [RESEND PATCH 1/2] devicetree: mxsfb: add reset-active property
Message-Id: <569501FA.2060304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Xef7RdBgTfRQcRS1LiGXW07UaemInVVR6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1452594141-26073-1-git-send-email-mans@mansr.com>
 <5694F51C.7040107@ti.com> <yw1x7fjfuenu.fsf@unicorn.mansr.com>
In-Reply-To: <yw1x7fjfuenu.fsf-OEaqT8BN2ezZK2NkWkPsZwC/G2K4zDHf@public.gmane.org>
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Xef7RdBgTfRQcRS1LiGXW07UaemInVVR6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/01/16 15:10, M=C3=A5ns Rullg=C3=A5rd wrote:

>> I don't see any sleeps related to reset in the code. If reset is
>> asserted when the display is blanked, is it guaranteed that the reset
>> stays asserted long enough until the display is enabled again?
>=20
> In the datasheet for the panel I'm dealing with, there's some vague
> mention of 10 us (I missed it last time I looked), and my patch indeed
> fails to ensure this is met.  Other panels will obviously have differen=
t
> requirements.  To handle all cases properly, I suppose a configurable
> delay after changing the reset pin should be added.

Right. And then you need to ensure the powers are enabled in the right
order, the pixel clock is started at the right time (some need pix clock
before reset), and so on and so on =3D).

> I could also take the lazy way out, pinmux this signal high and leave i=
t
> at that.

I've seen panels that require a reset after powers have been off, or
similar, but I hope those are minority.

So yes, probably just making sure the reset is not asserted is the most
generic and easy way forward.

 Tomi


--Xef7RdBgTfRQcRS1LiGXW07UaemInVVR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWlQH6AAoJEPo9qoy8lh71sogP/3frrmFZkgzKymU1ki3l0KM4
fG7NlbfLUz+2666JEEyJUb9AEyg4UMqWfVF5O09A1UkKx50lKrNBmee1YpA40SpB
uQ+O080o4OpafZ34sOej/eaG00+wwCDh8U8mDMtu5h+ckiEaHD4eZNih5mgaxBA9
ScsQRB7QBSBopePnNv15sB+AjheEeGF9dT9YCy7WrjwQleMnZAEXxRBaeBhXAaHZ
WXiK7a5xOZ1nUQCiBMJP9fN+fHIpvCPdPgfZweBc2xyC5RGBKCCL0972Ddhoz3VB
ODZEN+TRckBTIJW2RTeYbkwy5LYbcqlxjkqU69XIbpnTWD+iSTGuF1hHiolPR7LX
urN2F5Cj4TqOcN9nb6611XzWOaOb6aimU7Wvh84dfqaHRQLsrboB+T2b4KN157t6
319MbXvx/vwRHmNPUx/3Ubk7wosVA5W+WGp+OeClSyP7N+LPHRwRy8mxKBryCIV/
fNk77ny4UFxYfauUFAUcDll8h0QFhbzZ9I6LTtJlC8ad0b/i5Hm5gMdZ04MA9AjH
Pgk0VkxvwifNgp7KHpXB+ehqzxo3o897Z0usZJQA+92GGPuE5hTKbOFWjmUfLoK/
kwL5Wf5WSM52i3EUlmfxwZtBg46MDQRBt2Q7XUv7fZdcDrkH+qYEibyDN0Wqevb+
0jkMi7TvX/ZRD3FXNbZV
=vxC0
-----END PGP SIGNATURE-----

--Xef7RdBgTfRQcRS1LiGXW07UaemInVVR6--
