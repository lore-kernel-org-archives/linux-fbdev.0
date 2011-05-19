From: Mark Lord <kernel@teksavvy.com>
Date: Thu, 19 May 2011 20:23:13 +0000
Subject: Re: [REGRESSION] [2.6.39-rc3] Wrong resolution in framebuffer and
Message-Id: <4DD57C31.3080903@teksavvy.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104171804.04664.maciej.rutecki@gmail.com> <201104211922.05779.maciej.rutecki@gmail.com> <201105192101.50000.maciej.rutecki@gmail.com>
In-Reply-To: <201105192101.50000.maciej.rutecki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: maciej.rutecki@gmail.com
Cc: linux-fbdev@vger.kernel.org, chris@chris-wilson.co.uk, linux-kernel@vger.kernel.org, mbroemme@plusserver.de, airlied@linux.ie, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On 11-05-19 03:01 PM, Maciej Rutecki wrote:
> On czwartek, 21 kwietnia 2011 o 19:22:05 Maciej Rutecki wrote:
>> (add LKML)
>>
>> On niedziela, 17 kwietnia 2011 o 18:04:04 Maciej Rutecki wrote:
>>> Hi
>>>
>>> Last known good: 2.6.38
>>> Failing kernel: 2.6.39-rc3
>>> Subsystem: Intel graphics driver.
>>>
>>> Description:
>>> PC should work with 1440x900 resolution. But console (and after) X Window
>>> start work with 1024x768.
>>>
>>> I attach dmesg and Xorg.0.log with drm.debug log_buf_lenM options:
>>> http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/kms/
>>>
>>> seems that driver cannot detect resolution higher than 1024x768.
>>>
>>> Also I boot kernel replace "i915.modeset=1" with "nomodeset" option:
>>> http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/nomodeset/
>>>
>>> But then X Window fails to start and got message: "(EE) No devices
>>> detected."
>>>
>>> Config for 2.6.39-rc3:
>>> http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/config-2.6.39-rc3
>>>
>>> Best regards
>>
>> Device:
>> 00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express
>> Integrated Graphics Controller (rev 02)
>
> Reported on:
> https://bugzilla.kernel.org/show_bug.cgi?id4002
>
> 2 weeks ago. Problem STILL exists on 2.6.39. That any of the graphic
> developers might be interested in the problem?

I had a problem similar to this, beginning with 2.6.37 (2.6.36 was okay).
It turned out to be that newer kernels were detecting the LVDS (LCD panel)
interface from the chipset, event though nothing was attached to that interface.
So GNOME would come up at 1024x768 (max the LVDS supported, I guess).

I initially worked around it by going into the GNOME -> Preferences -> Monitors,
and disabling the LVDS device there, in favour of the 1920x1200 "VGA" device I use.

Later, I hacked my kernel to just ignore the LVDS completely:


--- linux/drivers/gpu/drm/i915/intel_lvds.c.orig	2011-05-09 22:33:54.000000000 -0400
+++ linux/drivers/gpu/drm/i915/intel_lvds.c	2011-05-17 23:00:40.829773525 -0400
@@ -841,6 +841,7 @@
  */
 bool intel_lvds_init(struct drm_device *dev)
 {
+    if (0) {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	struct intel_lvds *intel_lvds;
 	struct intel_encoder *intel_encoder;
@@ -1041,5 +1042,6 @@
 	drm_encoder_cleanup(encoder);
 	kfree(intel_lvds);
 	kfree(intel_connector);
+    }
 	return false;
 }
