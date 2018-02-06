From: Aishwarya Pant <aishpant@gmail.com>
Date: Tue, 06 Feb 2018 07:50:41 +0000
Subject: [PATCH v2 0/3] backlight: document sysfs interfaces
Message-Id: <cover.1517902411.git.aishpant@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>

Patchset contains documentation of the sysfs interfaces for the
following five backlight drivers-
1) lm3639
2) adp5520
3) adp8860

It was compiled from data sheets, reading code and git history logs. In v2 of
the patches, documentation for lp8788 and lp855x devices was dropped as the
attributes contained debug information.

Aishwarya Pant (3):
  backlight: lm3639: document sysfs attributes
  backlight: adp5520: document sysfs attributes
  backlight: adp8860: document sysfs attributes

 .../ABI/testing/sysfs-class-backlight-adp5520      | 31 +++++++++++++
 .../ABI/testing/sysfs-class-backlight-adp8860      | 54 ++++++++++++++++++++++
 .../ABI/testing/sysfs-class-backlight-lm3639       | 11 +++++
 3 files changed, 96 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lm3639

-- 
2.16.1

