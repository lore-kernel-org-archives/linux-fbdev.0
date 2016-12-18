From: jpap00@gmail.com
Date: Sun, 18 Dec 2016 13:16:05 +0000
Subject: PROBLEM: FB_BACKLIGHT prevents building module backlight.ko
Message-Id: <CAOjmUo6g61M9rW+wu6VX6umHxc5_9L0XHsENrHFcZsdKTZqDAg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Apologies if this is the wrong place to report a potential Kconfig
issue with fbdev.  Please let me know where I should move the
discussion in that case.

I'm trying to compile the backlight.ko module, by setting

| CONFIG_BACKLIGHT_CLASS_DEVICE=m

in my kernel `.config` file.

The `FB_BACKLIGHT=y` configuration (also present in my kernel config)
appears to override the `CONFIG_BACKLIGHT_CLASS_DEVICE` value above to
"y", and so the backlight.ko module does not get built.

It looks like this happens in the fbdev Kconfig, because if I change
`drivers/video/fbdev/Kconfig` as follows so that
`BACKLIGHT_CLASS_DEVICE` is a "depends on", rather than a "select", it
builds properly.  In that case `CONFIG_BACKLIGHT_CLASS_DEVICE=m` is
preserved.

| config FB_BACKLIGHT
|         bool
|         depends on FB
|         select BACKLIGHT_LCD_SUPPORT
|         depends on BACKLIGHT_CLASS_DEVICE
|         default n

Without the above change, my kernel config reverts to
`CONFIG_BACKLIGHT_CLASS_DEVICE=y` and the backlight.ko module is not
built.

I'm not entirely sure the "depends on" change is the right approach,
especially with menuconfig.  How best to fix this?

Thank you,
jpap
