From: Maciej Rutecki <maciej.rutecki@gmail.com>
Date: Thu, 19 May 2011 19:01:49 +0000
Subject: Re: [REGRESSION] [2.6.39-rc3] Wrong resolution in framebuffer and X Window
Message-Id: <201105192101.50000.maciej.rutecki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104171804.04664.maciej.rutecki@gmail.com> <201104211922.05779.maciej.rutecki@gmail.com>
In-Reply-To: <201104211922.05779.maciej.rutecki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, chris@chris-wilson.co.uk
Cc: linux-kernel@vger.kernel.org, mbroemme@plusserver.de, airlied@linux.ie, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On czwartek, 21 kwietnia 2011 o 19:22:05 Maciej Rutecki wrote:
> (add LKML)
> 
> On niedziela, 17 kwietnia 2011 o 18:04:04 Maciej Rutecki wrote:
> > Hi
> > 
> > Last known good: 2.6.38
> > Failing kernel: 2.6.39-rc3
> > Subsystem: Intel graphics driver.
> > 
> > Description:
> > PC should work with 1440x900 resolution. But console (and after) X Window
> > start work with 1024x768.
> > 
> > I attach dmesg and Xorg.0.log with drm.debug log_buf_lenM options:
> > http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/kms/
> > 
> > seems that driver cannot detect resolution higher than 1024x768.
> > 
> > Also I boot kernel replace "i915.modeset=1" with "nomodeset" option:
> > http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/nomodeset/
> > 
> > But then X Window fails to start and got message: "(EE) No devices
> > detected."
> > 
> > Config for 2.6.39-rc3:
> > http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/config-2.6.39-rc3
> > 
> > Best regards
> 
> Device:
> 00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express
> Integrated Graphics Controller (rev 02)

Reported on:
https://bugzilla.kernel.org/show_bug.cgi?id4002

2 weeks ago. Problem STILL exists on 2.6.39. That any of the graphic 
developers might be interested in the problem?


-- 
Maciej Rutecki
http://www.maciek.unixy.pl
