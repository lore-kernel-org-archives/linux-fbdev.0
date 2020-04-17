From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:07:51 +0000
Subject: Re: [PATCH v2 1/6] video: fbdev: controlfb: fix sparse warning about using incorrect type
Message-Id: <5b6b4169-b861-9c8e-77af-9bb44acde573@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
 <CGME20200324134518eucas1p16e1a39c14dfd101f5a6d86218a9e19af@eucas1p1.samsung.com>
 <20200324134508.25120-2-b.zolnierkie@samsung.com>
 <20200324204521.GL2363188@phenom.ffwll.local>
In-Reply-To: <20200324204521.GL2363188@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>, linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 3/24/20 9:45 PM, Daniel Vetter wrote:
> On Tue, Mar 24, 2020 at 02:45:03PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> Use in_le32() instead of le32_to_cpup() to fix sparse warning about
>> improper type of the argument.
>>
>> Also add missing inline keyword to control_par_to_var() definition
>> (to match function prototype).
>>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/video/fbdev/controlfb.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/contr=
olfb.c
>> index 38b61cdb5ca4..9625792f4413 100644
>> --- a/drivers/video/fbdev/controlfb.c
>> +++ b/drivers/video/fbdev/controlfb.c
>> @@ -313,7 +313,7 @@ static int controlfb_blank(int blank_mode, struct fb=
_info *info)
>>  		container_of(info, struct fb_info_control, info);
>>  	unsigned ctrl;
>> =20
>> -	ctrl =3D le32_to_cpup(CNTRL_REG(p,ctrl));
>> +	ctrl =3D in_le32(CNTRL_REG(p, ctrl));
>>  	if (blank_mode > 0)
>>  		switch (blank_mode) {
>>  		case FB_BLANK_VSYNC_SUSPEND:
>> @@ -952,7 +952,8 @@ static int control_var_to_par(struct fb_var_screenin=
fo *var,
>>   * Convert hardware data in par to an fb_var_screeninfo
>>   */
>> =20
>> -static void control_par_to_var(struct fb_par_control *par, struct fb_va=
r_screeninfo *var)
>> +static inline void control_par_to_var(struct fb_par_control *par,
>=20
> Just quick drive-by bikeshed, feel free to ignore: static inline within a
> .c file imo doesn't make sense anymore, compilers are smart enough
> nowadays. I'd just drop this.
> -Daniel

I fixed this while applying patch series, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> +	struct fb_var_screeninfo *var)
>>  {
>>  	struct control_regints *rv;
>>  =09
>> --=20
>> 2.24.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://protect2.fireeye.com/url?k=E81baef1-b5d19b46-e81a25be-0cc47a3003=
e8-c88ec3abd71f4ad4&u=3Dhttps://lists.freedesktop.org/mailman/listinfo/dri-=
devel
