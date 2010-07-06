From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Jul 2010 09:46:50 +0000
Subject: Re: [PATCH 3/6] ARM: mach-shmobile: extend clock definitions on
Message-Id: <AANLkTimntNMLkSaiq5EErvTpF8I3yeKYRE8guPt9iozX@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

2010/7/6 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> On Mon, 5 Jul 2010, Magnus Damm wrote:
>> On Fri, Jul 2, 2010 at 9:33 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > On Fri, 2 Jul 2010, Magnus Damm wrote:
>> >> On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
>> >> <g.liakhovetski@gmx.de> wrote:
>> >> > Add definitions for DV_CLKI and HDMI clocks, extend support for PLL=
C2 and some
>> >> > other clocks.
>> >> >
>> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

>> >> > + =A0 =A0 =A0 /*
>> >> > + =A0 =A0 =A0 =A0* TODO: If the PLL is off, mult should be =3D 1, b=
ut the clock must be
>> >> > + =A0 =A0 =A0 =A0* stopped during re-parenting, a better solution t=
o this conflict
>> >> > + =A0 =A0 =A0 =A0* should be found.
>> >> > + =A0 =A0 =A0 =A0*/
>> >> > + =A0 =A0 =A0 mult =3D (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) =
* 2;
>> >>
>> >> Yes, this needs to be fixed.
>> >
>> > You mean now or in the future? If now - I don't see a reasonable fix so
>> > far... Do you?
>>
>> I'm not sure which way is the best, but I think this patch breaks the
>> case when the PLL is turned off.
>
> Ok, I can re-add the test and just add a line
>
> =9A =9A =9A =9A =9A =9A =9A =9Aclk->rate =3D pllc2_recalc(clk);
>
> in pllc2_enable()? This even makes sense in a way - if we know, that
> after enabling the ->rate can get out of sync with the actual frequency...
> I'll prepare an updated patch to make it easier to see.

After looking into the pllc2 part of the data sheet it looks more like
it should be exported like a clock that cannot be disabled. So
basically, extend the frequency table to include one more frequency
and handle the pll-off case as a 1:1 mapping.

Cheers,

/ magnus
