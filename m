From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v2] fbdev: bfin-lq035q1-fb: new Blackfin Landscape LCD 
	EZ-Extender driver
Date: Fri, 25 Sep 2009 16:48:27 -0400
Message-ID: <8bd0f97a0909251348k9e5240av6ebd49d2e99c04a1@mail.gmail.com>
References: <1252950549-9838-1-git-send-email-vapier@gentoo.org> 
	<1253223426-5938-1-git-send-email-vapier@gentoo.org> <20090924163240.d03127e3.akpm@linux-foundation.org> 
	<8bd0f97a0909251324h115c5c47wb2d50cc982ba17dd@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752607AbZIYUso@vger.kernel.org>
In-Reply-To: <8bd0f97a0909251324h115c5c47wb2d50cc982ba17dd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, michael.hennerich@analog.com, cooloney@kernel.org

On Fri, Sep 25, 2009 at 16:24, Mike Frysinger wrote:
> On Thu, Sep 24, 2009 at 19:32, Andrew Morton wrote:
>> On Thu, 17 Sep 2009 17:37:06 -0400 Mike Frysinger wrote:
>>> +static int lq035q1_control(unsigned char reg, unsigned short value=
)
>>> +{
>>> + =C2=A0 =C2=A0 int ret;
>>> + =C2=A0 =C2=A0 u8 regs[3] =3D {LQ035_INDEX, 0, 0};
>>> + =C2=A0 =C2=A0 u8 dat[3] =3D {LQ035_DATA, 0, 0};
>>> +
>>> + =C2=A0 =C2=A0 if (spi_control.spidev) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs[2] =3D reg;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dat[1] =3D value >> 8;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dat[2] =3D value & 0xFF=
;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D spi_write(spi_c=
ontrol.spidev, regs, ARRAY_SIZE(regs));
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D spi_write(spi_=
control.spidev, dat, ARRAY_SIZE(dat));
>>> + =C2=A0 =C2=A0 } else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>>> +
>>> + =C2=A0 =C2=A0 return ret;
>>> +}
>>
>> I am suspecting that this function (and the similar ones below) rely
>> upon state within the hardware and will hence misbehave if two
>> instances are run concurrently.
>>
>> Is that correct> =C2=A0If so, is there locking to prevent this from =
occurring?
>
> if by "instances" you mean "users" as in "multiple programs
> reading/writing the framebuffer concurrently", then probably. =C2=A0r=
ather
> than handle the locking ourselves, it can be pushed to the SPI bus by
> having the regs/dat be transfers in a single message.

hmm there shouldnt be any locking problems here actually.  the spi
access is only to initialize/shutdown, and there is a dedicated CS for
each device.  so i dont think anything here really needs changing
(other than to allocate the spi_control global variable dynamically in
the probe).
-mike
