From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 27 Mar 2012 11:19:47 +0000
Subject: Re: [PATCH V2 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Message-Id: <CAF0AtAtOSw73YuKyTxc6=RwN75oQaFxRCBW3_=PTmUoxgAFyew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
	<1332845843.1867.126.camel@deskari>
In-Reply-To: <1332845843.1867.126.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Mar 27, 2012 at 4:27 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
>> In OMAP3 DISPC video overlays suffer from some undocumented horizontal p=
osition
>> and timing related limitations leading to SYNCLOST errors. Whenever the =
image
>> window is moved towards the right of the screen SYNCLOST errors become
>> frequent. Checks have been implemented to see that DISPC driver rejects
>> configuration exceeding above limitations.
>>
>> This code was successfully tested on OMAP3. This code is written based o=
n code
>> written by Ville Syrj=E4l=E4 <ville.syrjala@nokia.com> in Linux OMAP ker=
nel. Ville
>> Syrj=E4l=E4 <ville.syrjala@nokia.com> had added checks for video overlay=
 horizontal
>> timing and DISPC horizontal blanking length limitations.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 97 ++++++++++++++++++++++++++++=
+----------
>> =A01 files changed, 72 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/d=
ispc.c
>> index 5a1963e..d8a1672 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1622,6 +1622,57 @@ static void calc_dma_rotation_offset(u8 rotation,=
 bool mirror,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 width, u16 height, u16 out_width, u16 out_=
height)
>
> I think the function could be named check_horiz_timing_omap3 or
> something. It's kinda hard to realize that this is an omap3 work-around.
> Perhaps a short comment above the function would be in order.
>

Yes, you are right! Do you mean to include some comments within the
code definition itself? The patch description includes all that this
function does.

>> +{
>> + =A0 =A0 int DS =3D DIV_ROUND_UP(height, out_height);
>> + =A0 =A0 struct omap_dss_device *dssdev =3D dispc_mgr_get_device(channe=
l);
>> + =A0 =A0 struct omap_video_timings t =3D dssdev->panel.timings;
>> + =A0 =A0 unsigned long nonactive, lclk, pclk;
>> + =A0 =A0 static const u8 limits[3] =3D { 8, 10, 20 };
>> + =A0 =A0 u64 val, blank;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 nonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;
>> + =A0 =A0 pclk =3D dispc_mgr_pclk_rate(channel);
>> + =A0 =A0 lclk =3D dispc_mgr_lclk_rate(channel);
>> +
>> + =A0 =A0 i =3D 0;
>> + =A0 =A0 if (out_height < height)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 if (out_width < width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 blank =3D div_u64((u64)(t.hbp + t.hsw + t.hfp) * lclk, pclk);
>> + =A0 =A0 DSSDBG("blanking period + ppl =3D %llu (limit =3D %u)\n", blan=
k, limits[i]);
>> + =A0 =A0 if (blank <=3D limits[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Pixel data should be prepared before visible display poin=
t starts.
>> + =A0 =A0 =A0* So, atleast DS-2 lines must have already been fetched by =
DISPC
>> + =A0 =A0 =A0* during nonactive - pos_x period.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 val =3D div_u64((u64)(nonactive - pos_x) * lclk, pclk);
>> + =A0 =A0 DSSDBG("(nonactive - pos_x) * pcd =3D %llu,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 " max(0, DS - 2) * width =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 val, max(0, DS - 2) * width);
>> + =A0 =A0 if (val < max(0, DS - 2) * width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* All lines need to be refilled during the nonactive period=
 of which
>> + =A0 =A0 =A0* only one line can be loaded during the active period. So,=
 atleast
>> + =A0 =A0 =A0* DS - 1 lines should be loaded during nonactive period.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 val =3D =A0div_u64((u64)nonactive * lclk, pclk);
>> + =A0 =A0 DSSDBG("nonactive * pcd =A0=3D %llu, max(0, DS - 1) * width =
=3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 val, max(0, DS - 1) * width);
>> + =A0 =A0 if (val < max(0, DS - 1) * width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static unsigned long calc_fclk_five_taps(enum omap_channel channel, u=
16 width,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 height, u16 out_width, u16 out_height,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum omap_color_mode color_mode)
>> @@ -1702,7 +1753,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum omap_channel channel, u16 width, u16 he=
ight,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 out_width, u16 out_height,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum omap_color_mode color_mode, bool *five_=
taps,
>> - =A0 =A0 =A0 =A0 =A0 =A0 int *x_predecim, int *y_predecim)
>> + =A0 =A0 =A0 =A0 =A0 =A0 int *x_predecim, int *y_predecim, u16 pos_x)
>> =A0{
>> =A0 =A0 =A0 struct omap_overlay *ovl =3D omap_dss_get_overlay(plane);
>> =A0 =A0 =A0 const int maxdownscale =3D dss_feat_get_param_max(FEAT_PARAM=
_DOWNSCALE);
>> @@ -1778,6 +1829,9 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D calc_fclk_five_taps=
(channel, in_width, in_height,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_width, o=
ut_height, color_mode);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D check_horiz_timing(c=
hannel, pos_x, in_width,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_height, out=
_width, out_height);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_width > maxsingleline=
width)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_heigh=
t > out_height &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 in_height < out_height * 2)
>> @@ -1785,7 +1839,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!*five_taps)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk =3D cal=
c_fclk(channel, in_width, in_height,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 out_width, out_height);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D (in_width > maxsingl=
elinewidth * 2 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D (error || in_width >=
 maxsinglelinewidth * 2 ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (in_width > =
maxsinglelinewidth && *five_taps) ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !fclk || fcl=
k > dispc_fclk_rate());
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
>> @@ -1801,6 +1855,12 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (decim_x <=3D *x_predecim && decim_y=
 <=3D *y_predecim
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && error);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (check_horiz_timing(channel, pos_x, width, =
height,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_width, out_height)){
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("horizo=
ntal timing too tight\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_width > (maxsinglelinewidth * 2)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("Cannot setup scaling=
");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("width exceeds maximu=
m width possible");
>> @@ -1901,7 +1961,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct =
omap_overlay_info *oi,
>>
>> =A0 =A0 =A0 r =3D dispc_ovl_calc_scaling(plane, channel, in_width, in_he=
ight,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_width, out_height, oi->c=
olor_mode, &five_taps,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &x_predecim, &y_predecim);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &x_predecim, &y_predecim, oi->=
pos_x);
>> =A0 =A0 =A0 if (r)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>>
>> @@ -2472,32 +2532,19 @@ unsigned long dispc_fclk_rate(void)
>>
>> =A0unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
>> =A0{
>> - =A0 =A0 struct platform_device *dsidev;
>> - =A0 =A0 int lcd;
>> - =A0 =A0 unsigned long r;
>> - =A0 =A0 u32 l;
>> + =A0 =A0 unsigned long r =3D dispc_fclk_rate();
>>
>> - =A0 =A0 l =3D dispc_read_reg(DISPC_DIVISORo(channel));
>> + =A0 =A0 if (dispc_mgr_is_lcd(channel)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 l;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int lcd;
>>
>> - =A0 =A0 lcd =3D FLD_GET(l, 23, 16);
>> + =A0 =A0 =A0 =A0 =A0 =A0 l =3D dispc_read_reg(DISPC_DIVISORo(channel));
>> + =A0 =A0 =A0 =A0 =A0 =A0 lcd =3D FLD_GET(l, 23, 16);
>>
>> - =A0 =A0 switch (dss_get_lcd_clk_source(channel)) {
>> - =A0 =A0 case OMAP_DSS_CLK_SRC_FCK:
>> - =A0 =A0 =A0 =A0 =A0 =A0 r =3D clk_get_rate(dispc.dss_clk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
>> - =A0 =A0 =A0 =A0 =A0 =A0 dsidev =3D dsi_get_dsidev_from_id(0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 r =3D dsi_get_pll_hsdiv_dispc_rate(dsidev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
>> - =A0 =A0 =A0 =A0 =A0 =A0 dsidev =3D dsi_get_dsidev_from_id(1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 r =3D dsi_get_pll_hsdiv_dispc_rate(dsidev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r / lcd;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> =A0 =A0 =A0 }
>> -
>> - =A0 =A0 return r / lcd;
>> =A0}
>
> I don't the change to dispc_mgr_lclk_rate has anything to do with this
> patch (fixing omap3 sync lost error). Shouldn't it be a separate fix?
>
> =A0Tomi
>
I am thinking to to move this fix to the third patch in the series
"OMAPDSS: DISPC: Correct DISPC functional clock usage" and make it
separate patch from the series and if possible move it ahead of the
predecimation patch series. What do you say?


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
