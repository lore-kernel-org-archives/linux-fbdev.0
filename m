From: Maciej Rutecki <maciej.rutecki@gmail.com>
Date: Sun, 17 Apr 2011 16:06:43 +0000
Subject: Re: [REGRESSION] [2.6.39-rc3] Wrong resolution in framebuffer and X Window
Message-Id: <201104171806.44355.maciej.rutecki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201104171804.04664.maciej.rutecki@gmail.com>
In-Reply-To: <201104171804.04664.maciej.rutecki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, dri-devel@lists.freedesktop.org, mbroemme@plusserver.de

On niedziela, 17 kwietnia 2011 o 18:04:04 Maciej Rutecki wrote:
> Hi
> 
> Last known good: 2.6.38
> Failing kernel: 2.6.39-rc3
> Subsystem: Intel graphics driver.
> 
> Description:
> PC should work with 1440x900 resolution. But console (and after) X Window
> start work with 1024x768.
> 
> I attach dmesg and Xorg.0.log with drm.debug log_buf_lenM options:
> http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/kms/
> 
> seems that driver cannot detect resolution higher than 1024x768.
> 
> Also I boot kernel replace "i915.modeset=1" with "nomodeset" option:
> http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/nomodeset/
> 
> But then X Window fails to start and got message: "(EE) No devices
> detected."
> 
> Config for 2.6.39-rc3:
> http://unixy.pl/maciek/download/kernel/2.6.39-rc1/zlom/config-2.6.39-rc3
> 
> Best regards

Forgot:
00:02.0 VGA compatible controller: Intel Corporation 82G33/G31 Express 
Integrated Graphics Controller (rev 02)

Regards

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
