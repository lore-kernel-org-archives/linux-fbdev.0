From: Bryan Wu <bryan.wu@canonical.com>
Date: Tue, 17 Aug 2010 09:48:11 +0000
Subject: Re: [PATCH V2] OMAP: DSS2: don't power off a panel twice
Message-Id: <4C6A5ADB.4000505@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281496753-17471-1-git-send-email-stanley.miao@windriver.com> <4C624850.3060709@canonical.com> <4C6A4FED.5020006@canonical.com> <4C6A55EA.1090407@windriver.com>
In-Reply-To: <4C6A55EA.1090407@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org, lwalkera@ieee.org, lwalkera@gmail.com, tomi.valkeinen@nokia.com, linux-fbdev@vger.kernel.org

I can also reproduce it when I try to use kexec to reboot the system. And this
patch fix that.

-Bryan

On 08/17/2010 05:27 PM, stanley.miao wrote:
> It should be Tomi to maintain DSS2. I didn't get any response from Tomi.
> 
> Stanley.
> 
> Bryan Wu wrote:
>> Is there any feedback about this patch,
>>
>> Tested-by: Bryan Wu <bryan.wu@canonical.com>
>>
>> -Bryan
>>
>> On 08/11/2010 02:50 PM, Bryan Wu wrote:
>>  
>>> Tested on my Beagle board. It fixed the issue.
>>>
>>> Thanks,
>>> -Bryan
>>>
>>> On 08/11/2010 11:19 AM, Stanley.Miao wrote:
>>>    
>>>> If we blank the panel by
>>>> echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
>>>>
>>>> Then, we reboot the sytem, the kernel will crash at
>>>> drivers/video/omap2/dss/core.c:323
>>>>
>>>> This is because the panel is closed twice. Now check the state of a
>>>> dssdev
>>>> to forbid a panel is power on or power off twice.
>>>>
>>>> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
>>>> ---
>>>>  drivers/video/omap2/displays/panel-acx565akm.c     |    6 ++++++
>>>>  drivers/video/omap2/displays/panel-generic.c       |    6 ++++++
>>>>  .../video/omap2/displays/panel-sharp-lq043t1dg01.c |    6 ++++++
>>>>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    6 ++++++
>>>>  drivers/video/omap2/displays/panel-taal.c          |    6 ++++++
>>>>  .../video/omap2/displays/panel-toppoly-tdo35s.c    |    6 ++++++
>>>>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    6 ++++++
>>>>  7 files changed, 42 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/video/omap2/displays/panel-acx565akm.c
>>>> b/drivers/video/omap2/displays/panel-acx565akm.c
>>>> index 1f8eb70..374cbeb 100644
>>>> --- a/drivers/video/omap2/displays/panel-acx565akm.c
>>>> +++ b/drivers/video/omap2/displays/panel-acx565akm.c
>>>> @@ -587,6 +587,9 @@ static int acx_panel_power_on(struct
>>>> omap_dss_device *dssdev)
>>>>  
>>>>      dev_dbg(&dssdev->dev, "%s\n", __func__);
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      mutex_lock(&md->mutex);
>>>>  
>>>>      r = omapdss_sdi_display_enable(dssdev);
>>>> @@ -642,6 +645,9 @@ static void acx_panel_power_off(struct
>>>> omap_dss_device *dssdev)
>>>>  
>>>>      dev_dbg(&dssdev->dev, "%s\n", __func__);
>>>>  
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      mutex_lock(&md->mutex);
>>>>  
>>>>      if (!md->enabled) {
>>>> diff --git a/drivers/video/omap2/displays/panel-generic.c
>>>> b/drivers/video/omap2/displays/panel-generic.c
>>>> index 300eff5..395a68d 100644
>>>> --- a/drivers/video/omap2/displays/panel-generic.c
>>>> +++ b/drivers/video/omap2/displays/panel-generic.c
>>>> @@ -39,6 +39,9 @@ static int generic_panel_power_on(struct
>>>> omap_dss_device *dssdev)
>>>>  {
>>>>      int r;
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      r = omapdss_dpi_display_enable(dssdev);
>>>>      if (r)
>>>>          goto err0;
>>>> @@ -58,6 +61,9 @@ err0:
>>>>  
>>>>  static void generic_panel_power_off(struct omap_dss_device *dssdev)
>>>>  {
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      if (dssdev->platform_disable)
>>>>          dssdev->platform_disable(dssdev);
>>>>  
>>>> diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
>>>> b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
>>>> index 1026746..0c6896c 100644
>>>> --- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
>>>> +++ b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
>>>> @@ -43,6 +43,9 @@ static int sharp_lq_panel_power_on(struct
>>>> omap_dss_device *dssdev)
>>>>  {
>>>>      int r;
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      r = omapdss_dpi_display_enable(dssdev);
>>>>      if (r)
>>>>          goto err0;
>>>> @@ -65,6 +68,9 @@ err0:
>>>>  
>>>>  static void sharp_lq_panel_power_off(struct omap_dss_device *dssdev)
>>>>  {
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      if (dssdev->platform_disable)
>>>>          dssdev->platform_disable(dssdev);
>>>>  
>>>> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
>>>> b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
>>>> index 7d9eb2b..9a138f6 100644
>>>> --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
>>>> +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
>>>> @@ -135,6 +135,9 @@ static int sharp_ls_power_on(struct
>>>> omap_dss_device *dssdev)
>>>>  {
>>>>      int r = 0;
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      r = omapdss_dpi_display_enable(dssdev);
>>>>      if (r)
>>>>          goto err0;
>>>> @@ -157,6 +160,9 @@ err0:
>>>>  
>>>>  static void sharp_ls_power_off(struct omap_dss_device *dssdev)
>>>>  {
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      if (dssdev->platform_disable)
>>>>          dssdev->platform_disable(dssdev);
>>>>  
>>>> diff --git a/drivers/video/omap2/displays/panel-taal.c
>>>> b/drivers/video/omap2/displays/panel-taal.c
>>>> index aaf5d30..c649f06 100644
>>>> --- a/drivers/video/omap2/displays/panel-taal.c
>>>> +++ b/drivers/video/omap2/displays/panel-taal.c
>>>> @@ -635,6 +635,9 @@ static int taal_power_on(struct omap_dss_device
>>>> *dssdev)
>>>>      u8 id1, id2, id3;
>>>>      int r;
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      if (dssdev->platform_enable) {
>>>>          r = dssdev->platform_enable(dssdev);
>>>>          if (r)
>>>> @@ -715,6 +718,9 @@ static void taal_power_off(struct
>>>> omap_dss_device *dssdev)
>>>>  {
>>>>      struct taal_data *td = dev_get_drvdata(&dssdev->dev);
>>>>  
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      dsi_bus_lock();
>>>>  
>>>>      cancel_delayed_work(&td->esd_work);
>>>> diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
>>>> b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
>>>> index fa434ca..49e1dec 100644
>>>> --- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
>>>> +++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
>>>> @@ -46,6 +46,9 @@ static int toppoly_tdo_panel_power_on(struct
>>>> omap_dss_device *dssdev)
>>>>  {
>>>>      int r;
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      r = omapdss_dpi_display_enable(dssdev);
>>>>      if (r)
>>>>          goto err0;
>>>> @@ -65,6 +68,9 @@ err0:
>>>>  
>>>>  static void toppoly_tdo_panel_power_off(struct omap_dss_device
>>>> *dssdev)
>>>>  {
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      if (dssdev->platform_disable)
>>>>          dssdev->platform_disable(dssdev);
>>>>  
>>>> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
>>>> b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
>>>> index e866e76..dbe9d43 100644
>>>> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
>>>> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
>>>> @@ -269,6 +269,9 @@ static int tpo_td043_power_on(struct
>>>> omap_dss_device *dssdev)
>>>>      int nreset_gpio = dssdev->reset_gpio;
>>>>      int r;
>>>>  
>>>> +    if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return 0;
>>>> +
>>>>      r = omapdss_dpi_display_enable(dssdev);
>>>>      if (r)
>>>>          goto err0;
>>>> @@ -308,6 +311,9 @@ static void tpo_td043_power_off(struct
>>>> omap_dss_device *dssdev)
>>>>      struct tpo_td043_device *tpo_td043 >>>> dev_get_drvdata(&dssdev->dev);
>>>>      int nreset_gpio = dssdev->reset_gpio;
>>>>  
>>>> +    if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
>>>> +        return;
>>>> +
>>>>      tpo_td043_write(tpo_td043->spi, 3,
>>>>              TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
>>>>  
>>>>       
>>>     
>>
>>   
> 

