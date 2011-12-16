From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Fri, 16 Dec 2011 04:58:04 +0000
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Update Fir Coefficients
Message-Id: <CAF0AtAtaCGpgeYxss0H_jbYWOwJJ_LW0W8-eqM20juKTAGassA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323838310-4439-1-git-send-email-cmahapatra@ti.com>
	<1323939331.2010.27.camel@deskari>
In-Reply-To: <1323939331.2010.27.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Thu, Dec 15, 2011 at 2:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Wed, 2011-12-14 at 10:21 +0530, Chandrabhanu Mahapatra wrote:
>
>> +const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_tap=
s)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 static const struct {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int Mmin;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int Mmax;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct dispc_coef *coef_3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct dispc_coef *coef_5;
>> + =A0 =A0 } coefs[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 26, 32, coef3_M32, coef5_M32 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 22, 26, coef3_M26, coef5_M26 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 19, 22, coef3_M22, coef5_M22 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 16, 19, coef3_M19, coef5_M19 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 14, 16, coef3_M16, coef5_M16 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 13, 14, coef3_M14, coef5_M14 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 12, 13, coef3_M13, coef5_M13 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 11, 12, coef3_M12, coef5_M12 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 10, 11, coef3_M11, coef5_M11 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A09, 10, coef3_M10, coef5_M10 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A08, =A09, =A0coef3_M9, =A0coef5_M9 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A03, =A08, =A0coef3_M8, =A0coef5_M8 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* When upscaling more than two times, block=
iness and outlines
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* around the image are observed when M8 tab=
les are used. M11,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* M16 and M19 tables are used to prevent th=
is.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A02, =A03, coef3_M11, coef5_M11 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A01, =A02, coef3_M16, coef5_M16 },
>> + =A0 =A0 };
>> +
>> + =A0 =A0 inc /=3D 128;
>> + =A0 =A0 for (i =3D 0; i < ARRAY_LEN(coefs); ++i)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (inc > coefs[i].Mmin && inc <=3D coefs[i].M=
max)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return five_taps ? coefs[i].co=
ef_5 : coefs[i].coef_3;
>> + =A0 =A0 if (inc =3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return five_taps ? coef3_M19 : coef5_M19;
>> + =A0 =A0 return NULL;
>> +}
>
> Why don't you handle the inc =3D 1 case the same as others? Just have an
> entry in the table for Mmin=3D0, Mmax =3D 1.
>
For inc=3D1 i.e. M=3D1 , scaling ratio is maximum as L/M=3D8. DISPC scaler
doesnot support upscaling more than 8 itmes. Having an (Mmin,Mmax] of
(0,1] will allow such cases.
> Also, I think it's a bit confusing that Mmin is exclusive and Mmax is
> inclusive in the comparison. It makes the table a bit hard to read, when
> looking at which entry is used for which inc. I'd recommend using
> inclusive comparison for both.
>
> =A0Tomi
>
Having both inclusive will allow us to delete the extra comparison for
inc=3D1 but in my opinion having Mmin exclusive and Mmax inclusive
actually gives an clear idea of comparison. The tables mostly go by
the Mmax value.
For example, for inc& coef3/5_M26 table is selected, for inc"
coef3/5_M22 is selected etc.
If we have both Mmin and Mmax as inclusive above case becomes slightly
incoherent. Say for M& instead of coef3/5_M26 which seems more
obvious choice coef3/5_M32 is selected.

For both inclusive cases to work and avoid confusion and delete extra
comparison for inc=3D1 , I have to reverse the order of table entries
in "coef" table. But for that I will have to put the "When upscaling
more than two times, blockiness and outlines" comment at the beginning
of the table and then start with  {  1,  2, coef3_M16, coef5_M16 }.
This will create even more confusion.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
