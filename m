From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Fri, 16 Mar 2012 14:18:27 +0000
Subject: Re: [PATCH 2/2] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Message-Id: <CAF0AtAtYv_J0qBUeKQtb0zueJuLj7BCDMw0oiDVFC9MAtgq8CA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331812132-9814-1-git-send-email-cmahapatra@ti.com>
	<20120315230446.GO17132@sci.fi>
In-Reply-To: <20120315230446.GO17132@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 16, 2012 at 4:34 AM, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
> On Thu, Mar 15, 2012 at 05:18:52PM +0530, Chandrabhanu Mahapatra wrote:
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
>> =A0drivers/video/omap2/dss/dispc.c | =A0 67 ++++++++++++++++++++++++++++=
+++++++++--
>> =A01 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/d=
ispc.c
>> index 5a1963e..ebfa613 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1622,6 +1622,58 @@ static void calc_dma_rotation_offset(u8 rotation,=
 bool mirror,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int check_horiz_timing(enum omap_channel channel, u16 pos_x,
>> + =A0 =A0 =A0 =A0 =A0 =A0 u16 width, u16 height, u16 out_width, u16 out_=
height)
>> +{
>> + =A0 =A0 int DS =3D DIV_ROUND_UP(height, out_height);
>> + =A0 =A0 struct omap_dss_device *dssdev =3D dispc_mgr_get_device(channe=
l);
>> + =A0 =A0 struct omap_video_timings t =3D dssdev->panel.timings;
>> + =A0 =A0 int pcd =3D REG_GET(DISPC_DIVISORo(channel), 7, 0);
>
> pcd doesn't exist for TV out, which is the reason why you see
> 'lclk/pclk' ratio used instead in the harmattan kernel.
>
Yes, you are right. It's a very important point which I had missed.

> Another thing which still seems to be wrong in the upstream code is the
> use of fclk in the scaling checks. It should be checking lclk instead.

Thanks for sighting this out. I will implement it in the future.

>> + =A0 =A0 unsigned long nonactive, val, blank;
>> + =A0 =A0 static const u8 limits[3] =3D { 8, 10, 20 };
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 nonactive =3D t.x_res + t.hfp + t.hsw + t.hbp - out_width;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Atleast DS-2 lines must have already been fetched
>> + =A0 =A0 =A0* before the display active video period starts.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 val =3D (nonactive - pos_x) * pcd;
>> + =A0 =A0 DSSDBG("(nonactive - pos_x) * pcd =3D %lu,"
>> + =A0 =A0 =A0 =A0 =A0 =A0 " max(0, DS - 2) * width =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 val, max(0, DS - 2) * width);
>> + =A0 =A0 if (val < max(0, DS - 2) * width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Only one line can be fetched during the overlay active
>> + =A0 =A0 =A0* period, the rest have to be fetched during the inactive
>> + =A0 =A0 =A0* period.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 val =3D nonactive * pcd;
>> + =A0 =A0 DSSDBG("nonactive * pcd =A0=3D %lu, max(0, DS - 1) * width =3D=
 %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 val, max(0, DS - 1) * width);
>> + =A0 =A0 if (val < max(0, DS - 1) * width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Atleast Ceil(DS) lines should have been loaded during
>> + =A0 =A0 =A0* PPL (screen width) + blanking period.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 i =3D 0;
>> + =A0 =A0 if (out_height < height)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 if (out_width < width)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 blank =3D (t.hbp + t.hsw + t.hfp) * pcd;
>> + =A0 =A0 DSSDBG("blanking period + ppl =3D %lu (limit =3D %u)\n", blank=
, limits[i]);
>> + =A0 =A0 if (blank <=3D limits[i])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> The comment and code here are totally out of sync. IIRC the hblank
> length check came directly from the TRM. I have no idea if it's correct
> for more recent OMAPs, or if it was just copy pasted from the
> old TRM when the TRM got adjusted for more recent chips. That is why I
> stuck it into a separate function in harmattan.
>

This patch is only for OMAP3 and this errata is present upto OMAP4 ES1
which we are currently not supporting.

> --
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/



--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
