From: Liu Ying <Ying.Liu@freescale.com>
Date: Fri, 24 Jan 2014 06:04:34 +0000
Subject: [PATCH v4 0/2] backlight: update bl status and some bd properties when necessary
Message-Id: <1390543476-13499-1-git-send-email-Ying.Liu@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jg1.han@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, plagnioj@jcrosoft.com

We don't have to turn backlight on/off every time a blanking
or unblanking event comes because the backlight status may
have already been what we want. Another thought is that one
backlight device may be shared by multiple framebuffers. We
don't hope blanking one of the framebuffers may turn the
backlight off for all the other framebuffers, since they are
likely being active to display something. This patch set adds
some logics to record each framebuffer's backlight usage to
determine the backlight device use count and whether the
backlight status should be updated or not.

Liu Ying (2):
  backlight: update bd state & fb_blank properties when necessary
  backlight: update backlight status when necessary

v3->v4:
* Split v3 into 2 patches to separate the change for updating the
  backlight device properties and backlight status, according to
  the comments from Jani Nikula and Jingoo Han.

v2->v3:
* Set fb_blank(*(int *)evdata->data) to bd->props.fb_blank
  when we turn off a blacklight.
* Correct some trivial typos in the commit message.

v1->v2:
* Make the commit message be more specific about the condition
  in which backlight device use count can be increased/decreased.
* Correct the setting for bd->props.fb_blank.

 drivers/video/backlight/backlight.c |   28 +++++++++++++++++++++-------
 include/linux/backlight.h           |    6 ++++++
 2 files changed, 27 insertions(+), 7 deletions(-)

-- 
1.7.9.5


