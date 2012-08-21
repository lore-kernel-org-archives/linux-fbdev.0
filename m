From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Date: Tue, 21 Aug 2012 11:25:05 +0000
Subject: Re: [PATCH V5 5/6] ARM: OMAP: Disable venc for OMAP4
Message-Id: <CAF0AtAv6hGf0LriC=WafsrF2ihw_3P6-wv75aq+UT_xvaPgh5A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1343912532.git.cmahapatra@ti.com>
	<cover.1345468541.git.cmahapatra@ti.com>
	<a07a3a216827e830cfa249f4f39ad26e75dc0afd.1345468541.git.cmahapatra@ti.com>
	<1345545159.4085.45.camel@deskari>
In-Reply-To: <1345545159.4085.45.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Aug 21, 2012 at 4:02 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Mon, 2012-08-20 at 18:54 +0530, Chandrabhanu Mahapatra wrote:
>> This is a alternative to "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4 to
>> prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> to prevent
>> VENC from crashing OMAP4 kernel. This prevents OMAPDSS from initial registration
>> of a device for VENC on OMAP4.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  arch/arm/mach-omap2/display.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
>> index af1ed7d..ee40739 100644
>> --- a/arch/arm/mach-omap2/display.c
>> +++ b/arch/arm/mach-omap2/display.c
>> @@ -95,7 +95,6 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
>>       { "dss_core", "omapdss_dss", -1 },
>>       { "dss_dispc", "omapdss_dispc", -1 },
>>       { "dss_rfbi", "omapdss_rfbi", -1 },
>> -     { "dss_venc", "omapdss_venc", -1 },
>>       { "dss_dsi1", "omapdss_dsi", 0 },
>>       { "dss_dsi2", "omapdss_dsi", 1 },
>>       { "dss_hdmi", "omapdss_hdmi", -1 },
>
> You need to reorder this and the previous patch. If you first remove the
> workaround from the previous patch, the kernel will crash if after that
> patch. So this one should be before the previous patch.
>
>  Tomi
>

Ok.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
