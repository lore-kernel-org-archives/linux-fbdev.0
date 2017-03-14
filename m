From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 14 Mar 2017 11:27:55 +0000
Subject: Re: [PATCH v7 2/2] backlight arcxcnn add support for ArcticSand devices
Message-Id: <20170314112755.faqkdz5th3sjkfzc@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1489429323-6103-1-git-send-email-olimpiu@arcticsand.com>
 <d628cdbc-dbc4-1065-23e8-63c0d6a2dd86@linaro.org>
In-Reply-To: <d628cdbc-dbc4-1065-23e8-63c0d6a2dd86-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, medasaro-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org

On Tue, 14 Mar 2017, Daniel Thompson wrote:

> On 13/03/17 18:22, Olimpiu Dejeu wrote:
> > backlight: Add support for Arctic Sand LED backlight driver chips
> > This driver provides support for the Arctic Sand arc2c0608 chip,
> >     and provides a framework to support future devices.
> > Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>=20
> Please could you also submit a patch to add arc to
> ./Documentation/devicetree/bindings/vendor-prefixes.txt.
>=20
> checkpatch.pl should have been asking you to do since v1 but only if you
> test the patch series against a clean kernel (tools such as aiaiai can he=
lp
> with this).
>=20
> However, once that is attended to:
>=20
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Please re-send the whole set 'threaded' once complete.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
