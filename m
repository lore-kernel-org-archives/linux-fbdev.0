From: Grazvydas Ignotas <notasas@gmail.com>
Date: Mon, 12 Mar 2012 11:26:17 +0000
Subject: Re: [PATCH] OMAPDSS: provide default timings functions for panels
Message-Id: <CANOLnOO9XgaO0fYtAw5c88En6vJJAQKQfV-1z-sAg7pxzUKuXQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331480061-5767-1-git-send-email-notasas@gmail.com>
	<4F5D9002.1030505@ti.com>
In-Reply-To: <4F5D9002.1030505@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On Mon, Mar 12, 2012 at 7:56 AM, Archit Taneja <a0393947@ti.com> wrote:

>> diff --git a/drivers/video/omap2/dss/core.c
>> b/drivers/video/omap2/dss/core.c
>> index 86ec12e..9dc0c10 100644
>> --- a/drivers/video/omap2/dss/core.c
>> +++ b/drivers/video/omap2/dss/core.c
>> @@ -434,6 +434,12 @@ int omap_dss_register_driver(struct omap_dss_driver
>> *dssdriver)
>>        if (dssdriver->get_recommended_bpp = NULL)
>>                dssdriver->get_recommended_bpp >>                        omapdss_default_get_recommended_bpp;
>> +       if (dssdriver->set_timings = NULL)
>> +               dssdriver->set_timings = omapdss_default_set_timings;
>> +       if (dssdriver->get_timings = NULL)
>> +               dssdriver->get_timings = omapdss_default_get_timings;
>> +       if (dssdriver->check_timings = NULL)
>> +               dssdriver->check_timings = omapdss_default_check_timings;
>
>
> This elimination makes sense with get_timings(), but having the default
> check_timings() and set_timings() linked with the DPI interface doesn't seem
> right.
>
> For example, if a panel driver using DSI interface doesn't have it's own
> set_timings() op populated, and if some user of DSS call's set_timings(), it
> would mess up the DSS2 driver.
>
> Probably having a check like this in check_timings()/set_timings() might
> make it safer:
>
> if (dssdev->type = OMAP_DISPAY_TYPE_DPI)
>        dpi_set_timings(dssdev, timings);

Makes sense, sending v2 shortly.

-- 
Gražvydas
