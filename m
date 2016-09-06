From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 06 Sep 2016 09:26:25 +0000
Subject: Re: [PATCH v4 4/4] gpu: ipu-ic: allow multiple handles to ic
Message-Id: <1473153985.2805.90.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
 <1471481419-5917-5-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1471481419-5917-5-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com

Am Mittwoch, den 17.08.2016, 17:50 -0700 schrieb Steve Longerbeam:
> The image converter kernel API supports conversion contexts and
> job queues, so we should allow more than one handle to the IC, so
> that multiple users can add jobs to the queue.

The image converter queue can be shared, but hardware access to the IC
task still has to be exclusive (ipu_ic_task_enable/disable/init/etc.)

> Note however that users that control the IC manually (that do not
> use the image converter APIs but setup the IC task by hand via calls
> to ipu_ic_task_enable(), ipu_ic_enable(), etc.) must still be careful not
> to share the IC handle with other threads. At this point, the only user
> that still controls the IC manually is the i.mx capture driver. In that
> case the capture driver only allows one open context to get a handle
> to the IC at a time, so we should be ok there.

The ipu_ic task handles should be kept exclusive. The image conversion
queue API could get its own handle (ipu_ic_queue? basically what is now
struct image_converter) with its own refcounting get/put functions on
top and each queue should take one exclusive reference on its
corresponding IC task while requested.:_:

If the capture code uses FSU channel linking to feed the IC preprocessor
tasks directly from the CSI, the viewfinder and encoder IC tasks should
not be available for the conversion queues to use.

regards
Philipp

