From: Jonghun Han <jonghun79.han@gmail.com>
Date: Wed, 01 Dec 2010 14:43:50 +0000
Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
Message-Id: <AANLkTi=R9KO5V1i8wru6TLMq-k5skr1hfZa43MgS=9HS@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19F8576C6E063C45BE387C64729E739404BC762E9A@dbde02.ent.ti.com>
	<1290589057.13243.22.camel@tubuntu>
	<19F8576C6E063C45BE387C64729E739404BCCA3A55@dbde02.ent.ti.com>
	<20101124163100.GB5681@nokia.com>
	<19F8576C6E063C45BE387C64729E739404BCCA3CAE@dbde02.ent.ti.com>
	<yw1xeia81nts.fsf@unicorn.mansr.com>
	<19F8576C6E063C45BE387C64729E739404BCCA401F@dbde02.ent.ti.com>
	<20101126125539.GG8094@nokia.com>
	<20101130063440.GF17114@linux-sh.org>
	<20101130063934.GG17114@linux-sh.org>
	<19F8576C6E063C45BE387C64729E739404BCCA455A@dbde02.ent.ti.com>
	<1291123945.24627.223.camel@tubuntu>
In-Reply-To: <1291123945.24627.223.camel@tubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Mundt <lethal@linux-sh.org>, Ville Syrj?l? <ville.syrjala@nokia.com>, M?ns Rullg?rd <mans@mansr.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Tomi Valkeinen wrote:

2010/11/30 Tomi Valkeinen <tomi.valkeinen@nokia.com>:
> On Tue, 2010-11-30 at 12:29 +0530, ext Hiremath, Vaibhav wrote:
>> > -----Original Message-----
>> > From: Paul Mundt [mailto:lethal@linux-sh.org]
>> > Sent: Tuesday, November 30, 2010 12:10 PM
>> > To: Ville Syrj?l?
>> > Cc: Hiremath, Vaibhav; M?ns Rullg?rd; linux-omap@vger.kernel.org; linu=
x-
>> > fbdev@vger.kernel.org
>> > Subject: Re: OMAP:DSS: possible bug in WAITFOR_VSYNC ioctl
>> >
>> > On Tue, Nov 30, 2010 at 03:34:40PM +0900, Paul Mundt wrote:

<snip>

> OMAP has user writeable shadow registers and hidden real registers for
> display controller. The shadow registers are latched to real registers
> on VFP, but only if GO bit has been set. The GO bit is cleared by the HW
> when latching has been done.
>
> If the GO bit is set, we cannot touch the shadow registers because we
> don't know when the VFP =A0will happen. That's why there's additionally a
> SW cache for the config, so that we don't need to block when the GO bit
> is up and the user wants to change the config. The driver "flushes" the
> SW config to real registers in VSYNC interrupt handler.

Does the driver flush the config to real register directly not a shadow reg=
ister
in VSYNC ISR? Does it mean display controller use the config flushed
to the real register from the VSYNC ?

I don't know OMAP in detail. But as I know other SoCs also work like it.

Can Go bit is cleared by SW ? And does each overlay(FB) have its own Go bit=
 ?
If Go bit can be cleared by SW, how do you think about the following scheme=
 ?

When user wants to change the config, clear the Go bit
although Go bit has been already set.
And set the config shadow register and then re-set the go bit.
It can make one Vsync delay for the first user who has wanted to
change the config.
But it can reduce the delay for the second user. And WAITFORGO can be remov=
ed.

BTW as I know, Android also uses WAITFORVSYNC for multiple buffering.

<snip>

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

BRs,
