From: Archit Taneja <a0393947@ti.com>
Date: Thu, 16 Aug 2012 12:23:22 +0000
Subject: Re: [PATCH 1/6] OMAPDSS: DSI: Maintain copy of operation mode in driver data
Message-Id: <502CE36A.5020700@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <343817088-29645-1-git-send-email-archit@ti.com>  <1345102594-6222-1-git-send-email-archit@ti.com>  <1345102594-6222-2-git-send-email-archit@ti.com> <1345115964.15132.2.camel@lappyti>
In-Reply-To: <1345115964.15132.2.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 16 August 2012 04:49 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-16 at 13:06 +0530, Archit Taneja wrote:
>> The DSI driver currently relies on the omap_dss_device struct to know the mode
>> of operation of the DSI protocol(command or video mode). This makes the DSI
>> interface driver dependent on the omap_dss_device struct.
>>
>> Make the DSI driver data maintain it's own operation mode field. The panel
>> driver is expected to call omapdss_dsi_set_operation_mode() before the interface
>> is enabled.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/displays/panel-taal.c |    1 +
>>   drivers/video/omap2/dss/dsi.c             |   42 +++++++++++++++++++++--------
>>   include/video/omapdss.h                   |    2 ++
>>   3 files changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
>> index d220f19..649247f 100644
>> --- a/drivers/video/omap2/displays/panel-taal.c
>> +++ b/drivers/video/omap2/displays/panel-taal.c
>> @@ -1063,6 +1063,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
>>   	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
>>   		dssdev->panel.timings.y_res);
>>   	omapdss_dsi_set_pixel_format(dssdev, dssdev->panel.dsi_pix_fmt);
>> +	omapdss_dsi_set_operation_mode(dssdev, dssdev->panel.dsi_mode);
>
> Taal is always in cmd mode. Shouldn't we just use a hardcoded value
> here?
>
> Actually I think the same goes for the pix_fmt above. It's always the
> same for Taal.

Yes, I'll do this. I guess we could gradually remove some of these 
fields from omap_dss_device? Can't we? I mean, if there are no panels 
which can ever support command and video mode together, then we can just 
leave it to the driver to hold this information.

Archit

