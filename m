From: Archit Taneja <archit@ti.com>
Date: Wed, 27 Mar 2013 11:29:15 +0000
Subject: Re: [PATCH 16/26] OMAPDSS: TFP410: convert to platform device
Message-Id: <5152D53B.9000509@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com> <1364304836-18134-17-git-send-email-tomi.valkeinen@ti.com> <5152D3E8.9040603@ti.com> <5152D49A.2090309@ti.com>
In-Reply-To: <5152D49A.2090309@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 27 March 2013 04:44 PM, Tomi Valkeinen wrote:
> On 2013-03-27 13:11, Archit Taneja wrote:
>> On Tuesday 26 March 2013 07:03 PM, Tomi Valkeinen wrote:
>>> Convert TFP410 driver from omap_dss_driver to a platform driver. The
>>> driver uses the new panel support from omapdss.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/displays/panel-tfp410.c |  205
>>> +++++++++++++++++----------
>>>    1 file changed, 128 insertions(+), 77 deletions(-)
>>>
>
>>> -        ddata->i2c_adapter = adapter;
>>> +    dssdev = &ddata->dssdev;
>>> +    dssdev->driver = &tfp410_driver;
>>> +    dssdev->panel.timings = tfp410_default_timings;
>>> +    dssdev->name = ddata->name;
>>> +    dssdev->phy.dpi.data_lines = ddata->data_lines;
>>> +    dssdev->panel_dev = &pdev->dev;
>>
>> Some of the omap_dss_device fields populated here(like data_lines) are
>> not going to be used anywhere. Are you populating all of them just for
>> the sake of clarity, so that they can be removed in another series later
>> on? Or is there some other reason?
>
> Unfortunately the datalines are used in
> omapdss_default_get_recommended_bpp(). So there are some fields
> populated just to keep things working, and I expect that they are
> removed later.

Ah okay, missed that. I guess it will be easier to remove these later on 
anyway.

Archit

