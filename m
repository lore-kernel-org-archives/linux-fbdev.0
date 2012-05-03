From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 03 May 2012 21:48:00 +0000
Subject: Re: [PATCH v2] video/sis: Use SiS_DRAMType from init.h and annotate it __devinitconst
Message-Id: <4FA2FD10.6090306@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FA1BF76.8080109@gmx.de> <201205032340.34483.PeterHuewe@gmx.de>
In-Reply-To: <201205032340.34483.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Peter,

On 05/03/2012 09:40 PM, Peter H=FCwe wrote:
> Hi Florian,
>=20
>> As far as I can see it should be possible to keep the array in
>> sis_main.c and just delete it in the header files, shouldn't it? I'd
>> prefer to do it this way.
>=20
> Yes it is absolutely possible to leave it in sis_main.c and remove it fro=
m the=20
> header files. I already thought about this when creating the patch, but=20
> decided against it, as the 17*5 =3D 85 bytes are allocated on the stack, =
while=20
> they nicely can be put in the .devinit.rodata section ;)

You can still mark it as __devinitconst, I just wanted to have the array
inside a C file, not a header. If you agree with this, I'll change your
new patch that way.

>=20
> With the patch:
> 344072  sis_main.o
> 1200950 sisfb.o
> 1217491 sisfb.ko
>=20
> vs without the patch and removing it only from the header:
>  344176  sis_main.o
> 1201056  sisfb.o
> 1217597  sisfb.ko -> ~100bytes more in the final module.
>=20
> However I'm fine with this  and will remove it from the header and squash=
 this=20
> together with the=20
> "video/sis: Remove unused structs SiS_SDRDRAM_TYPE/SiS_DDRDRAM_TYPE"
> I also sent to you.

Thanks,

Florian Tobias Schandinat
