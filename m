From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Date: Tue, 19 Jan 2016 16:03:29 +0000
Subject: Re: Whats missing in my new FB DRM driver... "No connectors reported connected with modes"?
Message-Id: <569E5E51.8000303@synopsys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5684268E.2000607@synopsys.com>
 <CAGd==071hzpQKjLU715tc004NN0d8Z01XdLAhg-DBx1FxtWb2w@mail.gmail.com>
 <569CF78F.7050303@synopsys.com> <569CFA9B.4060108@synopsys.com>
 <CAGd==07ffJAfAtzirALR3OF7f4UDVu_fJbbZ0ZiEa3F5-hLfyw@mail.gmail.com>
In-Reply-To: <CAGd==07ffJAfAtzirALR3OF7f4UDVu_fJbbZ0ZiEa3F5-hLfyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Xinliang Liu <xinliang.liu@linaro.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, laurent.pinchart@ideasonboard.com, dri-devel <dri-devel@lists.freedesktop.org>

Hi Xiang,

Its returning 0 modes... :(

Regards,
C.Palminha

# modetest -M drm-arcpgu -c
Connectors:
id      encoder status          type    size (mm)       modes   encoders
21      0       disconnected    HDMI-A  0x0             0       20
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0

#

On 19-01-2016 03:38, Xinliang Liu wrote:
> On 18 January 2016 at 22:45, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
> wrote:
> 
>> I'm also getting a message from DRM saying can't find any crtc or
>> sizes...i'm really missing something here.
>> :(
>>
>> -- log --
>> [drm] Initialized drm 1.1.0 20060810
>> drm-arcpgu e0017000.pgu: No connectors reported connected with modes
>> [drm] Cannot find any crtc or sizes - going 1024x768
>> Console: switching to colour frame buffer device 128x48
>> drm-arcpgu e0017000.pgu: fb0: frame buffer device
>> [drm] Initialized drm-arcpgu 1.0.0 20151127 on minor 0
>> -- log ---
>>
>> Any help?
>>
>> Regards,
>> C.Palminha
>>
>>
>> On 18-01-2016 14:32, Carlos Palminha wrote:
>>> Hi Xinliang,
>>>
>>> My get_modes seems to be implemented as the rcar driver...
>>> Probably still missing some init step?
>>>
>>> Regards,
>>> C.Palminha
>>>
>>>
>>> static int arcpgu_drm_connector_get_modes(struct drm_connector
>> *connector)
>>> {
>>> struct drm_encoder_slave *slave;
>>> const struct drm_encoder_slave_funcs *sfuncs;
>>> struct arcpgu_drm_connector * con >>> container_of(connector, struct arcpgu_drm_connector, connector);
>>>
>>> slave = con->encoder_slave;
>>> if(slave = NULL) {
>>> dev_err(connector->dev->dev,
>>> "connector_get_modes: cannot find slave encoder for connector\n");
>>> return 0;
>>> }
>>>
>>> sfuncs = slave->slave_funcs;
>>> if(sfuncs->get_modes = NULL){
>>> return 0;
>>> }
>>>
>>> return sfuncs->
>> ​​
>> get_modes(&slave->base,connector);
>>> }
>>>
>>
> 
> ​so, this will call adv7511 driver's ​
> ​
> get_modes call back.
> I wonder if the system boot up, it can get modes or not.
> You can test it with the modetest. i.e. $ modetest -M DRM_DRIVER_NAME -c
> 
> 
> 
> 
>>> On 31-12-2015 02:19, Xinliang Liu wrote:
>>>>
>>>>
>>>> On 31 December 2015 at 02:46, Carlos Palminha
>>>> <CARLOS.PALMINHA@synopsys.com <mailto:CARLOS.PALMINHA@synopsys.com>>
>> wrote:
>>>>
>>>>     Hi guys,
>>>>
>>>>     I'm writing a DRM driver for a framebuffer embedded hardware that
>>>>     uses an i2c encoder (adv7511), following the basic steps suggested
>>>>     by Laurent in "anatomy of an embedded KMS driver":
>>>>     https://www.youtube.com/watch?v=Ja8fM7rTae4
>>>>
>>>>     After initiliazing all kms, crtc, encoder, i2c, connector functions
>>>>     and structures i'm calling drm_fbdev_cma_init to create a fbdev.
>>>>
>>>>     When booting i'm getting an error message saying "No connectors
>>>>     reported connected with modes", but the driver init is ok and i can
>>>>     find the /dev/dri/* and /dev/fb0 devices.
>>>>
>>>>     Any clue what i might be missing during the driver load?
>>>>
>>>>
>>>> ​I think you should check on the 'get_modes'​ call back of adv7511
>>>> driver. (Or, if possible show us the code.)
>>>>
>>>> Best,
>>>> -xinliang
>>>>
>>>>
>>>>     Thanks...
>>>>
>>>>     Regards,
>>>>     C.Palminha
>>>>
>>>>     --- boot log snippet ---
>>>>     [drm] Initialized drm 1.1.0 20060810
>>>>     drm-arcpgu e0017000.pgu: No connectors reported connected with modes
>>>>     [drm] Cannot find any crtc or sizes - going 1024x768
>>>>     Console: switching to colour frame buffer device 128x48
>>>>     drm-arcpgu e0017000.pgu: fb0:  frame buffer device
>>>>     [drm] Initialized drm-arcpgu 1.0.0 20151127 on minor 0
>>>>     --- boot log snippet ---
>>>>     --
>>>>     To unsubscribe from this list: send the line "unsubscribe
>>>>     linux-fbdev" in
>>>>     the body of a message to majordomo@vger.kernel.org
>>>>     <mailto:majordomo@vger.kernel.org>
>>>>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>
> 
