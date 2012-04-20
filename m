From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Fri, 20 Apr 2012 06:42:53 +0000
Subject: Re: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Message-Id: <CAF0AtAtan9s-Dgp-afgvfBRXHjzLgqC6fE=+WnLeydV9n-Kw=Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1333379598-11544-1-git-send-email-cmahapatra@ti.com>
	<1333379598-11544-2-git-send-email-cmahapatra@ti.com>
	<1333379598-11544-3-git-send-email-cmahapatra@ti.com>
	<1333379598-11544-4-git-send-email-cmahapatra@ti.com>
	<1334841071.1911.85.camel@deskari>
In-Reply-To: <1334841071.1911.85.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Apr 19, 2012 at 6:41 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Mon, 2012-04-02 at 20:43 +0530, Chandrabhanu Mahapatra wrote:
>> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
>> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
>> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
>> divisor LCD.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 28 ++++++++++++++++++++++------
>> =A0drivers/video/omap2/dss/dss.h =A0 | =A0 =A01 +
>> =A02 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/d=
ispc.c
>> index 17ffa71..cfde674 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1813,6 +1813,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_feat_get=
_param_max(FEAT_PARAM_LINEWIDTH);
>> =A0 =A0 =A0 const int max_decim_limit =3D 16;
>> =A0 =A0 =A0 unsigned long fclk =3D 0;
>> + =A0 =A0 unsigned long dispc_core_clk =3D dispc_core_clk_rate(channel);
>> =A0 =A0 =A0 int decim_x, decim_y, error, min_factor;
>> =A0 =A0 =A0 u16 in_width, in_height, in_width_max =3D 0;
>>
>> @@ -1855,7 +1856,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D calc_fclk(channel, =
in_width, in_height,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 out_width, out_height);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D (in_width > maxsin=
glelinewidth || !fclk ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk > dispc_f=
clk_rate());
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk > dispc_c=
ore_clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (decim_x =
=3D decim_y) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 decim_x =3D min_factor;
>> @@ -1893,7 +1894,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 out_width, out_height);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D (error || in_width=
 > maxsinglelinewidth * 2 ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (in_width > =
maxsinglelinewidth && *five_taps) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !fclk || fclk =
> dispc_fclk_rate());
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !fclk || fclk =
> dispc_core_clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (decim_x =
=3D decim_y) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 decim_x =3D min_factor;
>> @@ -1926,7 +1927,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int decim_x_min =3D decim_x;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_height =3D DIV_ROUND_UP(height, decim_y);
>> - =A0 =A0 =A0 =A0 =A0 =A0 in_width_max =3D dispc_fclk_rate() /
>> + =A0 =A0 =A0 =A0 =A0 =A0 in_width_max =3D dispc_core_clk /
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DIV_ROUND_UP=
(dispc_mgr_pclk_rate(channel),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 out_width);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 decim_x =3D DIV_ROUND_UP(width, in_width_max=
);
>> @@ -1950,13 +1951,13 @@ static int dispc_ovl_calc_scaling(enum omap_plan=
e plane,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 DSSDBG("required fclk rate =3D %lu Hz\n", fclk);
>> - =A0 =A0 DSSDBG("current fclk rate =3D %lu Hz\n", dispc_fclk_rate());
>> + =A0 =A0 DSSDBG("current fclk rate =3D %lu Hz\n", dispc_core_clk);
>>
>> - =A0 =A0 if (!fclk || fclk > dispc_fclk_rate()) {
>> + =A0 =A0 if (!fclk || fclk > dispc_core_clk) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("failed to set up scaling, "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "required fclk rate =3D %lu =
Hz, "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "current fclk rate =3D %lu H=
z\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk, dispc_fclk_rate());
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk, dispc_core_clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 }
>>
>> @@ -2646,6 +2647,21 @@ unsigned long dispc_mgr_pclk_rate(enum omap_chann=
el channel)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +unsigned long dispc_core_clk_rate(enum omap_channel channel)
>> +{
>> + =A0 =A0 int lcd =3D 1;
>> + =A0 =A0 unsigned long r =3D dispc_fclk_rate();
>> +
>> + =A0 =A0 if (dss_has_feature(FEAT_CORE_CLK_DIV)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 lcd =3D REG_GET(DISPC_DIVISOR, 23, 16);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dispc_mgr_is_lcd(channel))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcd =3D REG_GET(DISPC_DIVISORo=
(channel), 23, 16);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return r / lcd ;
>> +}
>> +
>
> I wonder if this is correct. "channel" for dispc core clock doesn't make
> sense, there's no channel related to that. At least on OMAP4.
>
> If I'm not mistaken, in omap2/3 case (i.e.
> dss_has_feature(FEAT_CORE_CLK_DIV) =3D false) we can just use channel 0
> to get the lcd divisor. Although that would mean that LCD output's
> divisor affects the tv-out's scaling calculations, which feels a bit
> strange...
>

Yes, you are right. I had failed to look at channel 0 or
OMAP_DSS_CHANNEL_LCD can simply be used.

> So... I don't know... Do we really have two different dispc core clocks
> int omap2/3 (for lcd output and for tv output), but only one in omap4?
> If so, then the above code is ok. Have you found explanations from TRM
> which say what clock is required and where?
>

Though the term Dispc Core Clock is never used in OMAP2/3 TRM, it is
actually the logic clock that drives the various logics of DSS
subsystem. So we can say that we have one dispc core clock for OMAP2/3
and that being the logic clock. I took two different logics as LCD
factor returned zero for TV.  However, LCD factor of DISPC_DIVISOR of
channel 0 can be used always.

> In any case, please remove the initialization of lcd variable, and add:
>
> else
> =A0 =A0 =A0 =A0lcd =3D 1;
>
> I think that's much clearer. And "r" variable is commonly used as a
> return value. I would rename the variable to something else, say, "fck".
>
> =A0Tomi
>

Yes, sure it makes code more understandable and clean.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
