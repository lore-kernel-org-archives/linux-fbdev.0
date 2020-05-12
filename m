From: Fabian Mastenbroek <mail.fabian.m@gmail.com>
Date: Tue, 12 May 2020 20:39:18 +0000
Subject: Re: bug: kernel bug when unbinding EFI framebuffer
Message-Id: <77F726E1-2C8C-4096-BDD9-D3D2A5960611@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
In-Reply-To: <45B8BCE9-2156-4248-8102-58736D02752D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Ah that explains it. I did not realize that nouveau already unregisters the=
 framebuffer.=20

To answer your question on why: I wanted to isolate a GPU so that I pass it=
 forward to a VM. However, as I understand now, I shouldn=E2=80=99t need to=
 touch the EFI framebuffer when using nouveau.

Best regards,

Fabian Mastenbroek

> On 12 May 2020, at 22:03, Dave Airlie <airlied@gmail.com> wrote:
>=20
> On Sat, 2 May 2020 at 22:36, Fabian Mastenbroek <mail.fabian.m@gmail.com>=
 wrote:
>>=20
>> Hi,
>>=20
>> When I try to unbind the EFI framebuffer via:
>>=20
>>        echo -n efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebu=
ffer/unbind
>=20
> Can I ask why?
>=20
> nouveau kicks the efifb off the hw, and unregisters it, but when you
> unbind it it tries to unregister again.
>=20
> It might be possible to block this, but not sure of the point, efifb
> is a built-in, you can't unload the module to save memory.
>=20
> Dave.
