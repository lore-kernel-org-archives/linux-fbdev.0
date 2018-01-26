From: Aishwarya Pant <aishpant@gmail.com>
Date: Fri, 26 Jan 2018 14:48:20 +0000
Subject: [PATCH 0/5] backlight: document sysfs interfaces
Message-Id: <cover.1516978005.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Patchset contains documentation of the sysfs interfaces for the
following five backlight drivers-
1) lp8788
2) lp855x
3) lm3639
4) adp5520
5) adp8860

It was compiled from data sheets, reading code and git history logs.

Aishwarya Pant (5):
  backlight: lp8788: document sysfs attributes
  backlight: lp855: document sysfs attributes
  backlight: lm3639: document sysfs attributes
  backlight: adp5520: document sysfs attributes
  backlight: adp8860: document sysfs attributes

 .../ABI/testing/sysfs-class-backlight-adp5520      | 31 +++++++++++++
 .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++++++
 .../ABI/testing/sysfs-class-backlight-lm3639       | 13 ++++++
 .../ABI/testing/sysfs-class-backlight-lp855x       | 19 ++++++++
 .../ABI/testing/sysfs-class-backlight-lp8788       | 10 ++++
 5 files changed, 127 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp855x
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788

-- 
2.16.1

