From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Nov 2014 12:51:52 +0000
Subject: Re: [PATCH] video: fbdev: Add CVT timing calculations.
Message-Id: <546DE3E8.1030204@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mGOw5rpqJSJim0Lv19AVflCG0sa7d7I3j"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--mGOw5rpqJSJim0Lv19AVflCG0sa7d7I3j
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/11/14 00:54, David Ung wrote:
> Currently fbmon is still relying on the old GTF timings when parsing
> the standard timings of the EDID.
> This causes problem with some monitor eg DELL U2410 which advertises
> high resolutions like 1920x1200@60 and GTF timing gives it 193mhz
> clock which is out of spec of the monitor which has dclkmax of 170mhz.
> This patch address the above problem by adding support for CVT with
> reduced timings.

These timings are quite complex, and I don't claim to fully understand
all the details, so I have a few questions:

So you say the monitor has a standard timing for 1920x1200@60. If I read
the EDID standard right, a standard timing entry either has to match a
timing from VESA DMT, or it shall be calculated using GTF.

Don't we have or shouldn't we have a table for the VESA DMT modes, from
which to search for standard timings? 1920x1200@60 should be found there.=


> Signed-off-by: David Ung <davidu@nvidia.com>
> ---
>  drivers/video/fbdev/core/fbmon.c | 92 ++++++++++++++++++++++++++++++++=
+-------
>  1 file changed, 77 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index 5b0e313..8d4ec9f 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -21,6 +21,11 @@
>   *      GTF Spreadsheet by Andy Morrish (1/5/97)
>   *      available at http://www.vesa.org
>   *
> + * Coordinated Video Timing is derived from:
> + *
> + *      CVT Spreadsheet by Graham Loveridge (9/Apr/2003)
> + *      available at http://www.vesa.org
> + *
>   * This file is subject to the terms and conditions of the GNU General=
 Public
>   * License.  See the file COPYING in the main directory of this archiv=
e
>   * for more details.
> @@ -383,17 +388,21 @@ static void get_chroma(unsigned char *block, stru=
ct fb_monspecs *specs)
>  }
> =20
>  static void calc_mode_timings(int xres, int yres, int refresh,
> -			      struct fb_videomode *mode)
> +			      struct fb_videomode *mode,
> +			      struct fb_monspecs *specs)
>  {
>  	struct fb_var_screeninfo *var;
> +	struct fb_info info;
> =20
>  	var =3D kzalloc(sizeof(struct fb_var_screeninfo), GFP_KERNEL);
> +	if (specs)
> +		memcpy(&info.monspecs, specs, sizeof(struct fb_monspecs));
> =20
>  	if (var) {
>  		var->xres =3D xres;
>  		var->yres =3D yres;
> -		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON,
> -			    refresh, var, NULL);
> +		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, refresh, var,
> +			    specs && !specs->gtf ? &info : NULL);

This juggling with fb_monspecs, creating a temporary fb_info (and even
leaving most of it uninitialized) doesn't look very nice.

Why allow NULL specs in any case? Don't we always have it?

If the specs is really only used for the GTF flag, could we just pass
that flag, not the whole specs?

>  		mode->xres =3D xres;
>  		mode->yres =3D yres;
>  		mode->pixclock =3D var->pixclock;
> @@ -417,12 +426,12 @@ static int get_est_timing(unsigned char *block, s=
truct fb_videomode *mode)
> =20
>  	c =3D block[0];
>  	if (c&0x80) {
> -		calc_mode_timings(720, 400, 70, &mode[num]);
> +		calc_mode_timings(720, 400, 70, &mode[num], NULL);
>  		mode[num++].flag =3D FB_MODE_IS_CALCULATED;
>  		DPRINTK("      720x400@70Hz\n");
>  	}
>  	if (c&0x40) {
> -		calc_mode_timings(720, 400, 88, &mode[num]);
> +		calc_mode_timings(720, 400, 88, &mode[num], NULL);
>  		mode[num++].flag =3D FB_MODE_IS_CALCULATED;
>  		DPRINTK("      720x400@88Hz\n");
>  	}
> @@ -431,7 +440,7 @@ static int get_est_timing(unsigned char *block, str=
uct fb_videomode *mode)
>  		DPRINTK("      640x480@60Hz\n");
>  	}
>  	if (c&0x10) {
> -		calc_mode_timings(640, 480, 67, &mode[num]);
> +		calc_mode_timings(640, 480, 67, &mode[num], NULL);
>  		mode[num++].flag =3D FB_MODE_IS_CALCULATED;
>  		DPRINTK("      640x480@67Hz\n");
>  	}
> @@ -462,7 +471,7 @@ static int get_est_timing(unsigned char *block, str=
uct fb_videomode *mode)
>  		DPRINTK("      800x600@75Hz\n");
>  	}
>  	if (c&0x20) {
> -		calc_mode_timings(832, 624, 75, &mode[num]);
> +		calc_mode_timings(832, 624, 75, &mode[num], NULL);
>  		mode[num++].flag =3D FB_MODE_IS_CALCULATED;
>  		DPRINTK("      832x624@75Hz\n");
>  	}
> @@ -496,7 +505,7 @@ static int get_est_timing(unsigned char *block, str=
uct fb_videomode *mode)
>  }
> =20
>  static int get_std_timing(unsigned char *block, struct fb_videomode *m=
ode,
> -		int ver, int rev)
> +			  int ver, int rev, struct fb_monspecs *specs)
>  {
>  	int xres, yres =3D 0, refresh, ratio, i;
> =20
> @@ -535,7 +544,7 @@ static int get_std_timing(unsigned char *block, str=
uct fb_videomode *mode,
>  			return 1;
>  		}
>  	}
> -	calc_mode_timings(xres, yres, refresh, mode);
> +	calc_mode_timings(xres, yres, refresh, mode, specs);
>  	return 1;
>  }
> =20
> @@ -545,7 +554,7 @@ static int get_dst_timing(unsigned char *block,
>  	int j, num =3D 0;
> =20
>  	for (j =3D 0; j < 6; j++, block +=3D STD_TIMING_DESCRIPTION_SIZE)
> -		num +=3D get_std_timing(block, &mode[num], ver, rev);
> +		num +=3D get_std_timing(block, &mode[num], ver, rev, NULL);

Hmm, why is this call using NULL?

> =20
>  	return num;
>  }
> @@ -601,7 +610,8 @@ static void get_detailed_timing(unsigned char *bloc=
k,
>   * This function builds a mode database using the contents of the EDID=

>   * data
>   */
> -static struct fb_videomode *fb_create_modedb(unsigned char *edid, int =
*dbsize)
> +static struct fb_videomode *fb_create_modedb(unsigned char *edid, int =
*dbsize,
> +					     struct fb_monspecs *specs)
>  {
>  	struct fb_videomode *mode, *m;
>  	unsigned char *block;
> @@ -643,7 +653,7 @@ static struct fb_videomode *fb_create_modedb(unsign=
ed char *edid, int *dbsize)
>  	DPRINTK("   Standard Timings\n");
>  	block =3D edid + STD_TIMING_DESCRIPTIONS_START;
>  	for (i =3D 0; i < STD_TIMING; i++, block +=3D STD_TIMING_DESCRIPTION_=
SIZE)
> -		num +=3D get_std_timing(block, &mode[num], ver, rev);
> +		num +=3D get_std_timing(block, &mode[num], ver, rev, specs);
> =20
>  	block =3D edid + DETAILED_TIMING_DESCRIPTIONS_START;
>  	for (i =3D 0; i < 4; i++, block+=3D DETAILED_TIMING_DESCRIPTION_SIZE)=
 {
> @@ -707,7 +717,7 @@ static int fb_get_monitor_limits(unsigned char *edi=
d, struct fb_monspecs *specs)
>  		int num_modes, hz, hscan, pixclock;
>  		int vtotal, htotal;
> =20
> -		modes =3D fb_create_modedb(edid, &num_modes);
> +		modes =3D fb_create_modedb(edid, &num_modes, NULL);

Same here.

>  		if (!modes) {
>  			DPRINTK("None Available\n");
>  			return 1;
> @@ -964,7 +974,7 @@ void fb_edid_to_monspecs(unsigned char *edid, struc=
t fb_monspecs *specs)
>  	DPRINTK("   Display Characteristics:\n");
>  	get_monspecs(edid, specs);
> =20
> -	specs->modedb =3D fb_create_modedb(edid, &specs->modedb_len);
> +	specs->modedb =3D fb_create_modedb(edid, &specs->modedb_len, specs);
> =20
>  	/*
>  	 * Workaround for buggy EDIDs that sets that the first
> @@ -1255,6 +1265,55 @@ static void fb_timings_dclk(struct __fb_timings =
*timings)
>  }
> =20
>  /*
> + * All calculations are based on the VESA CVT Spreadsheet
> + * available at VESA's public ftp (http://www.vesa.org).
> + *
> + * The names of variables are kept to match as closely to the names
> + * that appears in the spreadsheet.
> + */
> +#define RB_MIN_V_BLANK  460
> +#define RB_H_BLANK      160
> +#define CELL_GRAN       8
> +#define CLOCK_STEP      250
> +#define RB_V_FPORCH     3
> +#define V_SYNC_RND      6
> +#define MIN_V_BPORCH    6
> +
> +static void fb_timings_vfreq_cvt(struct __fb_timings *timings)
> +{
> +	u32 v_lines_rnd, h_period_est, vbi_line, rb_min_vbi, act_vbi_lines;
> +	u32 total_v_lines, h_pixels_rnd, total_active_pixels, total_pixels;
> +	u32 act_pixel_freq;
> +	u32 v_field_rate_rqd =3D timings->vfreq;
> +	u32 h_pixels =3D timings->hactive;
> +	u32 v_lines =3D timings->vactive;
> +
> +	v_lines_rnd =3D v_lines;
> +	h_period_est =3D 1000000 / v_field_rate_rqd - RB_MIN_V_BLANK;
> +	h_period_est =3D h_period_est / v_lines_rnd;
> +	vbi_line =3D RB_MIN_V_BLANK / h_period_est;
> +	rb_min_vbi =3D RB_V_FPORCH + V_SYNC_RND + MIN_V_BPORCH;
> +	if (vbi_line < rb_min_vbi)
> +		act_vbi_lines =3D rb_min_vbi;
> +	else
> +		act_vbi_lines =3D vbi_line;
> +	total_v_lines =3D act_vbi_lines + v_lines_rnd;
> +	h_pixels_rnd =3D (h_pixels / CELL_GRAN) * CELL_GRAN;
> +	total_active_pixels =3D h_pixels_rnd;
> +	total_pixels =3D RB_H_BLANK + total_active_pixels;
> +	act_pixel_freq =3D v_field_rate_rqd * total_v_lines * total_pixels;
> +	act_pixel_freq /=3D 1000;
> +	act_pixel_freq =3D act_pixel_freq / CLOCK_STEP * CLOCK_STEP * 1000;
> +
> +	timings->hfreq =3D act_pixel_freq / total_pixels;
> +	timings->vblank =3D act_vbi_lines;
> +	timings->vtotal =3D timings->vactive + timings->vblank;
> +	timings->hblank =3D RB_H_BLANK;
> +	timings->htotal =3D timings->hactive + timings->hblank;
> +	timings->dclk =3D timings->htotal * timings->hfreq;
> +}

What about fbcvt.c? You add fb_timings_vfreq_cvt function, but it sounds
something which we either have in fbcvt.c, or should be in fbcvt.c.

> +
> +/*
>   * fb_get_mode - calculates video mode using VESA GTF
>   * @flags: if: 0 - maximize vertical refresh rate
>   *             1 - vrefresh-driven calculation;
> @@ -1347,7 +1406,10 @@ int fb_get_mode(int flags, u32 val, struct fb_va=
r_screeninfo *var, struct fb_inf
>  		break;
>  	case FB_VSYNCTIMINGS: /* vrefresh driven */
>  		timings->vfreq =3D val;
> -		fb_timings_vfreq(timings);
> +		if (info && !info->monspecs.gtf)
> +			fb_timings_vfreq_cvt(timings);
> +		else
> +			fb_timings_vfreq(timings);
>  		break;
>  	case FB_HSYNCTIMINGS: /* hsync driven */
>  		timings->hfreq =3D val;
>=20

With your patch, fb_get_mode() does something else than the comments
say. It explicitly talks about calculating with GTF. Does any of the
callers expect it to use GTF, and won't work with CVT? In the minimum
the comments should be changed to reflect he new behavior.

 Tomi



--mGOw5rpqJSJim0Lv19AVflCG0sa7d7I3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbePoAAoJEPo9qoy8lh71dooP/A6I+NZyN50QQ3+afXbhS+D5
d4u4gLSquvCoYAGgh9ZX5qt7J0F5iGQOh+l1Sm3Oo4eCyErmsj4Ly9iSliH5uqh7
GzbHromY1OzCEdDZi5ATBbt3TrF3Vu/UJrlIppacui+I0XuFf/Fh0P/dFFKxYOVp
pYNojKNIHdQ5CeqEz2zpVq+AXMy4IoY3cxMLui2AuhfhY56yT9rxuYAc+kTkLxxG
R4EjyPt5E14EYAwUMTCCPY0sUSaZX1HgJ1AZrjU0cKY9sFuJsrUOBU0jMr+5ypTh
XdFHuKocrvkwX1kxle4DMw6FlgKfPe8h4PqYejlg0+2GHV8IGSD5SE53PGpwVapW
Qu3SrRyjoE2fsXWa04F8UbJYd4NG4Wr9Rh5GF+HuyHx9Xk41g2tLofhRojdQHlcn
kKcj1649RxoM9z1Qz0ATkb+GFOcQJke+SjKBtVTJnGrY8gdCgaB3keuOmKgQ+gph
yYQhgJ3Od/RhrPdikXIMjptCI5m1jP7fjj8Mrf9666YUWoYAv/yEhRT+PP0s5QsP
NsbZ+HvGr20KvVyF3Z6g6sZonp47sSTC2VjjF1+qlZuKF+dlT71I2CVDTGjzEDqw
8V+yC8OXcFmBNt5DnSYg+MK0Xxt1VDEZCqlr8PUue3+XB+Ct8C8SQZTc/1Etg5MI
Uq8iZq528Wq46FBI2Noq
=66lU
-----END PGP SIGNATURE-----

--mGOw5rpqJSJim0Lv19AVflCG0sa7d7I3j--
