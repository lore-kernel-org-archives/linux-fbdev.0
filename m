From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v2] fbdev: bfin-lq035q1-fb: new Blackfin Landscape LCD 
	EZ-Extender driver
Date: Fri, 25 Sep 2009 16:24:10 -0400
Message-ID: <8bd0f97a0909251324h115c5c47wb2d50cc982ba17dd@mail.gmail.com>
References: <1252950549-9838-1-git-send-email-vapier@gentoo.org> 
	<1253223426-5938-1-git-send-email-vapier@gentoo.org> <20090924163240.d03127e3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752234AbZIYUY1@vger.kernel.org>
In-Reply-To: <20090924163240.d03127e3.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, michael.hennerich@analog.com, cooloney@kernel.org

On Thu, Sep 24, 2009 at 19:32, Andrew Morton wrote:
> On Thu, 17 Sep 2009 17:37:06 -0400 Mike Frysinger wrote:
>> +config FB_BFIN_LQ035Q1
>> + =C2=A0 =C2=A0 tristate "SHARP LQ035Q1DH02 TFT LCD"
>> + =C2=A0 =C2=A0 depends on FB && BLACKFIN
>> + =C2=A0 =C2=A0 select FB_CFB_FILLRECT
>> + =C2=A0 =C2=A0 select FB_CFB_COPYAREA
>> + =C2=A0 =C2=A0 select FB_CFB_IMAGEBLIT
>> + =C2=A0 =C2=A0 select BFIN_GPTIMERS
>> + =C2=A0 =C2=A0 select SPI
>
> Are we sure about the `select SPI'? =C2=A0There's only one other plac=
e in
> the kernel which does this, and `select' often makes things explode. =
=C2=A0I
> fear that you're either selecting the wrong thing or you're selecting
> something which won't work well.

is it there on purpose and is it not just a mistaken typo ?  yes.  do
we really need it and will we cry if it changes to a "depends" ?  no.

it's just confusing to have a device driver disappear if SPI is
disabled, but considering SPI is enabled by default now, it's not a
big deal.

>> +#define DRIVER_NAME "bfin-lq035q1"
>> +static char driver_name[] =3D DRIVER_NAME;
>
> Will the compielr magically put this string into read-only storage fo=
r
> us, or should we do that manually with `const'?

is this question a rhetorical one ?  oh no, infinite loop ...

i'll fix it up in v3

>> +static int lq035q1_control(unsigned char reg, unsigned short value)
>> +{
>> + =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 u8 regs[3] =3D {LQ035_INDEX, 0, 0};
>> + =C2=A0 =C2=A0 u8 dat[3] =3D {LQ035_DATA, 0, 0};
>> +
>> + =C2=A0 =C2=A0 if (spi_control.spidev) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs[2] =3D reg;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dat[1] =3D value >> 8;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dat[2] =3D value & 0xFF;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D spi_write(spi_co=
ntrol.spidev, regs, ARRAY_SIZE(regs));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D spi_write(spi_c=
ontrol.spidev, dat, ARRAY_SIZE(dat));
>> + =C2=A0 =C2=A0 } else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>
> I am suspecting that this function (and the similar ones below) rely
> upon state within the hardware and will hence misbehave if two
> instances are run concurrently.
>
> Is that correct> =C2=A0If so, is there locking to prevent this from o=
ccurring?

if by "instances" you mean "users" as in "multiple programs
reading/writing the framebuffer concurrently", then probably.  rather
than handle the locking ourselves, it can be pushed to the SPI bus by
having the regs/dat be transfers in a single message.
-mike
