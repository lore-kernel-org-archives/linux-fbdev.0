From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 05 Jul 2010 04:20:45 +0000
Subject: Re: [PATCH 3/6] ARM: mach-shmobile: extend clock definitions on
Message-Id: <AANLkTikVdMYZX-lV3M9_Bva3k2Xdwr1mrWzjQumzY0Wz@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, Jul 2, 2010 at 9:33 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 2 Jul 2010, Magnus Damm wrote:
>> On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Add definitions for DV_CLKI and HDMI clocks, extend support for PLLC2 =
and some
>> > other clocks.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > --- a/arch/arm/mach-shmobile/clock-sh7372.c
>> > +++ b/arch/arm/mach-shmobile/clock-sh7372.c
>> > @@ -50,6 +50,12 @@
>> > =A0#define SMSTPCR3 =A0 =A0 =A0 0xe615013c
>> > =A0#define SMSTPCR4 =A0 =A0 =A0 0xe6150140
>> >
>> > +/* Fixed 27 MHz video clock from DV_CLKI pin */
>> > +static struct clk dv_clki_clk =3D {
>> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dv_clki",
>> > + =A0 =A0 =A0 .rate =A0 =A0 =A0 =A0 =A0 =3D 27000000,
>> > +};
>>
>> Hm, 27MHz is a board property, not a cpu property.
>
> Well, yes, but I think somewhere something suggested, that 27MHz is what
> you're actually supposed to provide there. Otherwise your board can always
> just call clk_set_rate(), right? Or what's the preferred way to let
> platforms set up clocks?

You're not supposed to set that clock to any special frequency at all.
It's totally up to the board designer. On the AP4EVB board it happens
to be set to 27 MHz. I suggest that you make the clock non-static and
use clk_set_rate() in the board code.

>> Also, you don't want to use "name" in struct clk. clkdev is used for
>> lookup these days.
>
> Right, it is not needed, thanks.
>
>> > =A0/* PLLC2 */
>> > +
>> > +/* Indices are important - they are the actual src selecting values */
>> > +static struct clk *pllc2_parent[] =3D {
>> > + =A0 =A0 =A0 [0] =3D &extal1_div2_clk,
>> > + =A0 =A0 =A0 [1] =3D &extal2_div2_clk,
>> > + =A0 =A0 =A0 [2] =3D &dv_clki_div2_clk,
>> > + =A0 =A0 =A0 [3] =3D NULL, =A0 =A0 /* extal2_div4 not implemented yet=
*/
>> > +};
>>
>> Why not implemented yet?
>
> Because it's not used yet. Should I implement it anyway?

Is it needed by your other patches at this point?

So far the clock routing has been static, so no clocks have got their
parents updated over time. This patch adds a much needed parent
selection support, but only implementing some of the parents does not
make so much sense to me.

>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* TODO: If the PLL is off, mult should be =3D 1, but =
the clock must be
>> > + =A0 =A0 =A0 =A0* stopped during re-parenting, a better solution to t=
his conflict
>> > + =A0 =A0 =A0 =A0* should be found.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 mult =3D (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) * 2;
>>
>> Yes, this needs to be fixed.
>
> You mean now or in the future? If now - I don't see a reasonable fix so
> far... Do you?

I'm not sure which way is the best, but I think this patch breaks the
case when the PLL is turned off.

/ magnus
