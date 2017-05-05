From: "Olimpiu Dejeu" <olimpiu@arcticsand.com>
Date: Fri, 05 May 2017 17:06:00 +0000
Subject: RE: [PATCH v10 3/3] backlight arcxcnn add support for ArcticSand devices
Message-Id: <000001d2c5c1$e00500f0$a00f02d0$@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1493823859-22402-1-git-send-email-olimpiu@arcticsand.com> <1493823859-22402-3-git-send-email-olimpiu@arcticsand.com> <20170505075712.xroroafofrkfxux4@dell>
In-Reply-To: <20170505075712.xroroafofrkfxux4@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Lee Jones' <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Brian Dodge <bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org

>> backlight: Add support for Arctic Sand LED backlight driver chips

>This should be the subject line of the patch.

>Out of interest, how are you submitting your patches?

>If you're not already, you should be using:

 > `git format-patch ...`
 > `git send-email ...`
  
>> This driver provides support for the Arctic Sand arc2c0608 chip, 
>>     and provides a framework to support future devices.

>'\n' here.

>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>

>Biggest point however is that this patch is already in Mainline.

The only reason for this set of patches is based on the request from Rob Herring for vendor name change from 'arc' to 'arctic'. Not sure how to proceed, please advise.
 
>> ---
>> v9 => v10:
>> - Per Rob Herring's request changed vendor-prefix to arctic
>> v8 => v9:
>> - Addressing kbuild test robot WARNING: PTR_ERR_OR_ZERO can be used
>> v7 => v8:
>> - Version updated to match other patch in set. No other changes.
>> v6 => v7:
>> - Addressing issues brought up by Daniel Thompson
>> v5 => v6:
>> - Addressing issues brought up by Daniel Thompson
>> v4 => v5:
>> - Code style changes per Joe Perches and Jingoo Han
>> v3 => v4:
>> - Code style changes per Joe Perches and Jingoo Han
>> v2 => v3:
>> - Renamed variables to comply with conventions on naming
>> - Corrected device name in arcxcnn.h
>> v1 => v2:
>> - Removed "magic numbers" to initialize registers
>> - Cleaned up device tree bindings
>> - Fixed code style to address comments and pass "checkpatch"
>> - Removed unneeded debug and testing code
>> 
>> 
>>  drivers/video/backlight/Kconfig      |   7 +
>>  drivers/video/backlight/Makefile     |   1 +
>>  drivers/video/backlight/arcxcnn_bl.c | 419 
>> +++++++++++++++++++++++++++++++++++
>>  3 files changed, 427 insertions(+)
>>  create mode 100644 drivers/video/backlight/arcxcnn_bl.c
>> 


