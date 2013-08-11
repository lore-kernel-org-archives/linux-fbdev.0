From: Dave Airlie <airlied@gmail.com>
Date: Sun, 11 Aug 2013 10:06:13 +0000
Subject: Re: EDID modes unavailable when no connector/crtc available at boot
Message-Id: <CAPM=9tzdcZetTZn7h5E5iLRPy6aGbRfSMxW7ttu4yR2URRvOQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5207160A.6070803@prisktech.co.nz>
	<CAPM=9tzShWxZ-f=641r+-uc21JkY3kTeM2K=tsiB+OotNCnrQA@mail.gmail.com>
	<52075C9E.6040901@prisktech.co.nz>
In-Reply-To: <52075C9E.6040901@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Prisk <linux@prisktech.co.nz>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org

On Sun, Aug 11, 2013 at 7:42 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On 11/08/13 20:42, Dave Airlie wrote:
>>
>> On Sun, Aug 11, 2013 at 2:41 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>>
>>> I am working on the HDMI driver for the i.MX6 as part of the larger DRM
>>> driver written by Sascha Hauer and need a little advice. I seem to be
>>> missing one important part of the subsystem that I haven't been able to
>>> resolve.
>>>
>> fbcon is limited by boot sizes as at least with dynamic memory
>> management and how fbdev works resizing the allocation is nearly
>> impossible to do race free, since fbdev will hand out mmaps to
>> userspace and that stops you from ever moving anything once the device
>> is open.
>>
>> But this is only for the fbdev emulation, a real kms application
>> should be able to use a larger size no problems.
>>
>> Dave.
>
> It seems to be worse than just a fbcon issue as far as I can tell.
>
> I am making an assumption, but I believe
> '/sys/class/drm/card0-HDMI-A-1/modes' should list all the supported modes of
> the connector (regardless of fbcon).
> Using 'cat /sys/class/drm/card0-HDMI-A-1/modes', it appears the supported
> modes are being limited by fbcon
>
> 1) HDMI Cable connected at bootup (fb @ 1920x1080)
> cat /sys/class/drm/card0-HDMI-A-1/modes
> 1920x1080
> 1280x720
> 1280x720
> 720x576
> 720x480
> 640x480
>
> 2) HDMI Cable NOT connected at bootup (fb @ 1024x768), cable is then
> connected after userspace has started (still in console)
> cat /sys/class/drm/card0-HDMI-A-1/modes
> 720x576
> 720x480
> 640x480
>
>
> Following back through the source:
>
> static struct drm_connector_funcs imx_hdmi_connector_funcs = {
>     .fill_modes = drm_helper_probe_single_connector_modes,
>     ...
> };
>
> static struct drm_connector_helper_funcs imx_hdmi_connector_helper_funcs = {
>     .get_modes = imx_hdmi_connector_get_modes,
>     .mode_valid = imx_hdmi_connector_mode_valid,
>     ...
> };
>
>
> It appears that only drm_helper_probe_single_connector_modes() calls
> .get_modes() and .mode_valid()
> .fill_modes() is called from drm_fb_helper_probe_connector_modes(), which is
> called from drm_fb_helper_hotplug_event()
> drm_fb_helper_hotplug_event() sets max_width to fb_helper->fb->width, and
> max_height to fb_helper->fb->height.
> fb->width is 1024 if booted without the cable connected, hence the clipping
> of the values.

fill_modes is also called from the drm_crtc.c userspace interface, all
the functions in drm_fb_helper are for fbdev/con use, the fact sysfs
is wrong is only a side effect.

Userspace should get a full list of modes, try using the modetest
application which I think should work.

Dave.
