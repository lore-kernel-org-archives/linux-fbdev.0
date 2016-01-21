From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Date: Thu, 21 Jan 2016 18:30:37 +0000
Subject: Whats missing in my new FB DRM driver in ARC... waiting for console_lock to return
Message-Id: <56A123CD.1060706@synopsys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5684268E.2000607@synopsys.com>
 <CAGd==071hzpQKjLU715tc004NN0d8Z01XdLAhg-DBx1FxtWb2w@mail.gmail.com>
 <569CF78F.7050303@synopsys.com> <569CFA9B.4060108@synopsys.com>
 <CAGd==07ffJAfAtzirALR3OF7f4UDVu_fJbbZ0ZiEa3F5-hLfyw@mail.gmail.com>
 <569E5E51.8000303@synopsys.com> <569E69EB.3010003@synopsys.com>
 <CAGd==04VMKUvb6hZkeNw3kAQt04y0d_Ry7oCtC8=2SWcfWG25A@mail.gmail.com>
 <56A11EF1.3070004@synopsys.com>
In-Reply-To: <56A11EF1.3070004@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xinliang Liu <xinliang.liu@linaro.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, dri-devel <dri-devel@lists.freedesktop.org>

hi...

i just found that its blocking waiting for console_lock...
@vineet, alexey: i think that console_lock is architecture dependent right? Do you know any issue with console_lock for ARC?

On 21-01-2016 18:09, Carlos Palminha wrote:
> i made some progress in identifying the issue...
> When my driver calls drm_fb_helper_initial_config it seems DRM blocks waiting for register_framebuffer to return.
> The sequence is drm_fb_helper_initial_config->drm_fb_helper_single_fb_probe->register_framebuffer.
> 
> Its strange because register_framebuffer function is just a mutex around do_register_framebuffer.
> 
> Any clue?!
> 
> On 20-01-2016 01:24, Xinliang Liu wrote:
>> On 20 January 2016 at 00:52, Carlos Palminha
>> <CARLOS.PALMINHA@synopsys.com> wrote:
>>> when i boot the kernel and connect the HDMI cable after booting i can retrieve 4 modes... :)
>>>
>>> if i boot linux with the HDMI cable inserted the kernel hangs.
>>
>> What's the hang kernel log. Is it a oops?
>>
>>> Possible relation with HPD?
>>
>> Yes,  I think there might be something wrong with the HPD interrupt or
>> the EDID ready interrupt.
>> I do meet the similar issue before when I using the upstream adv7511
>> driver to enable adv7533.
>> I found that the HPD and EDID interrupt is not reliable.
>> In order to get modes stably, I have to add some delay like bellow:
>> --
>> --- a/drivers/gpu/drm/i2c/adv7511.c
>> +++ b/drivers/gpu/drm/i2c/adv7511.c
>> @@ -657,6 +657,8 @@ static int adv7511_get_modes(struct adv7511 *adv7511,
>>                 regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
>>                                    ADV7511_POWER_POWER_DOWN, 0);
>>                 adv7511->current_edid_segment = -1;
>> +               /* wait some time for edid is ready */
>> +               msleep(200);
>>         }
>>
>>         edid = drm_do_get_edid(connector, adv7511_get_edid_block, adv7511);
>> --
>>
>> Best,
>> -xinliang
>>
>>>
>>> Regards,
>>> C.Palminha
>>>
>>> # modetest -M drm-arcpgu -c
>>> Connectors:
>>> id      encoder status          type    size (mm)       modes   encoders
>>> 21      0       connected       HDMI-A  0x0             4       20
>>>   modes:
>>>         name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot)
>>>   800x600 60 800 840 968 1056 600 601 605 628 flags: phsync, pvsync; type: driver
>>>   800x600 56 800 824 896 1024 600 601 603 625 flags: phsync, pvsync; type: driver
>>>   848x480 60 848 864 976 1088 480 486 494 517 flags: phsync, pvsync; type: driver
>>>   640x480 60 640 656 752 800 480 490 492 525 flags: nhsync, nvsync; type: driver
>>>   props:
>>>         1 EDID:
>>>                 flags: immutable blob
>>>                 blobs:
>>>
>>>                 value:
>>>         2 DPMS:
>>>                 flags: enum
>>>                 enums: On=0 Standby=1 Suspend=2 Off=3
>>>                 value: 0
>>>
>>> #
>>>
>>> On 19-01-2016 16:03, Carlos Palminha wrote:
>>>> Hi Xiang,
>>>>
>>>> Its returning 0 modes... :(
>>>>
>>>> Regards,
>>>> C.Palminha
>>>>
>>>> # modetest -M drm-arcpgu -c
>>>> Connectors:
>>>> id      encoder status          type    size (mm)       modes   encoders
>>>> 21      0       disconnected    HDMI-A  0x0             0       20
>>>>   props:
>>>>         1 EDID:
>>>>                 flags: immutable blob
>>>>                 blobs:
>>>>
>>>>                 value:
>>>>         2 DPMS:
>>>>                 flags: enum
>>>>                 enums: On=0 Standby=1 Suspend=2 Off=3
>>>>                 value: 0
>>>>
>>>> #
>>>>
>>>> On 19-01-2016 03:38, Xinliang Liu wrote:
>>>>> On 18 January 2016 at 22:45, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
>>>>> wrote:
>>>>>
>>>>>> I'm also getting a message from DRM saying can't find any crtc or
>>>>>> sizes...i'm really missing something here.
>>>>>> :(
>>>>>>
>>>>>> -- log --
>>>>>> [drm] Initialized drm 1.1.0 20060810
>>>>>> drm-arcpgu e0017000.pgu: No connectors reported connected with modes
>>>>>> [drm] Cannot find any crtc or sizes - going 1024x768
>>>>>> Console: switching to colour frame buffer device 128x48
>>>>>> drm-arcpgu e0017000.pgu: fb0: frame buffer device
>>>>>> [drm] Initialized drm-arcpgu 1.0.0 20151127 on minor 0
>>>>>> -- log ---
>>>>>>
>>>>>> Any help?
>>>>>>
>>>>>> Regards,
>>>>>> C.Palminha
>>>>>>
>>>>>>
>>>>>> On 18-01-2016 14:32, Carlos Palminha wrote:
>>>>>>> Hi Xinliang,
>>>>>>>
>>>>>>> My get_modes seems to be implemented as the rcar driver...
>>>>>>> Probably still missing some init step?
>>>>>>>
>>>>>>> Regards,
>>>>>>> C.Palminha
>>>>>>>
>>>>>>>
>>>>>>> static int arcpgu_drm_connector_get_modes(struct drm_connector
>>>>>> *connector)
>>>>>>> {
>>>>>>> struct drm_encoder_slave *slave;
>>>>>>> const struct drm_encoder_slave_funcs *sfuncs;
>>>>>>> struct arcpgu_drm_connector * con >>>>>>> container_of(connector, struct arcpgu_drm_connector, connector);
>>>>>>>
>>>>>>> slave = con->encoder_slave;
>>>>>>> if(slave = NULL) {
>>>>>>> dev_err(connector->dev->dev,
>>>>>>> "connector_get_modes: cannot find slave encoder for connector\n");
>>>>>>> return 0;
>>>>>>> }
>>>>>>>
>>>>>>> sfuncs = slave->slave_funcs;
>>>>>>> if(sfuncs->get_modes = NULL){
>>>>>>> return 0;
>>>>>>> }
>>>>>>>
>>>>>>> return sfuncs->
>>>>>>
>>>>>> get_modes(&slave->base,connector);
>>>>>>> }
>>>>>>>
>>>>>>
>>>>>
>>>>> so, this will call adv7511 driver's
>>>>>
>>>>> get_modes call back.
>>>>> I wonder if the system boot up, it can get modes or not.
>>>>> You can test it with the modetest. i.e. $ modetest -M DRM_DRIVER_NAME -c
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>> On 31-12-2015 02:19, Xinliang Liu wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 31 December 2015 at 02:46, Carlos Palminha
>>>>>>>> <CARLOS.PALMINHA@synopsys.com <mailto:CARLOS.PALMINHA@synopsys.com>>
>>>>>> wrote:
>>>>>>>>
>>>>>>>>     Hi guys,
>>>>>>>>
>>>>>>>>     I'm writing a DRM driver for a framebuffer embedded hardware that
>>>>>>>>     uses an i2c encoder (adv7511), following the basic steps suggested
>>>>>>>>     by Laurent in "anatomy of an embedded KMS driver":
>>>>>>>>     https://www.youtube.com/watch?v=Ja8fM7rTae4
>>>>>>>>
>>>>>>>>     After initiliazing all kms, crtc, encoder, i2c, connector functions
>>>>>>>>     and structures i'm calling drm_fbdev_cma_init to create a fbdev.
>>>>>>>>
>>>>>>>>     When booting i'm getting an error message saying "No connectors
>>>>>>>>     reported connected with modes", but the driver init is ok and i can
>>>>>>>>     find the /dev/dri/* and /dev/fb0 devices.
>>>>>>>>
>>>>>>>>     Any clue what i might be missing during the driver load?
>>>>>>>>
>>>>>>>>
>>>>>>>> I think you should check on the 'get_modes' call back of adv7511
>>>>>>>> driver. (Or, if possible show us the code.)
>>>>>>>>
>>>>>>>> Best,
>>>>>>>> -xinliang
>>>>>>>>
>>>>>>>>
>>>>>>>>     Thanks...
>>>>>>>>
>>>>>>>>     Regards,
>>>>>>>>     C.Palminha
>>>>>>>>
>>>>>>>>     --- boot log snippet ---
>>>>>>>>     [drm] Initialized drm 1.1.0 20060810
>>>>>>>>     drm-arcpgu e0017000.pgu: No connectors reported connected with modes
>>>>>>>>     [drm] Cannot find any crtc or sizes - going 1024x768
>>>>>>>>     Console: switching to colour frame buffer device 128x48
>>>>>>>>     drm-arcpgu e0017000.pgu: fb0:  frame buffer device
>>>>>>>>     [drm] Initialized drm-arcpgu 1.0.0 20151127 on minor 0
>>>>>>>>     --- boot log snippet ---
>>>>>>>>     --
>>>>>>>>     To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>     linux-fbdev" in
>>>>>>>>     the body of a message to majordomo@vger.kernel.org
>>>>>>>>     <mailto:majordomo@vger.kernel.org>
>>>>>>>>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
