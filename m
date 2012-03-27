From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 27 Mar 2012 11:26:04 +0000
Subject: Re: [PATCH V2 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Message-Id: <CAF0AtAuxR6pa0y_kTgh454=joFoy_kG4XCnHAS94qkPk0+kLFw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332323530-9088-1-git-send-email-cmahapatra@ti.com>
	<1332846215.1867.130.camel@deskari>
In-Reply-To: <1332846215.1867.130.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Mar 27, 2012 at 4:33 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Wed, 2012-03-21 at 15:22 +0530, Chandrabhanu Mahapatra wrote:
>> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
>> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
>> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
>> divisor LCD.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/dispc.c | =A0 13 +++++++------
>> =A01 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/d=
ispc.c
>> index d8a1672..1fdac73 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -1761,6 +1761,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane =
plane,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_feat_get=
_param_max(FEAT_PARAM_LINEWIDTH);
>> =A0 =A0 =A0 const int max_decim_limit =3D 16;
>> =A0 =A0 =A0 unsigned long fclk =3D 0;
>> + =A0 =A0 unsigned long dispc_core_clk =3D dispc_mgr_lclk_rate(channel);
>
> Hmm, I don't think this is correct. dispc_mgr_lclk_rate() returns the
> logic clock for the LCD output path. It's not DISPC core clock.
>
> =A0Tomi
>

As per the OMAP4 TRM DISPC_CORE_CLK is DISPC_FCLK / LCD factor and
dispc_mgr_lclk_rate() exactly does the same. Should we rename the
function or have a separate fucntion for dispc_core_clk to avoid
confusion?

--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
