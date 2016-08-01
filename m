From: Steve Longerbeam <steve_longerbeam@mentor.com>
Date: Mon, 01 Aug 2016 21:02:49 +0000
Subject: Re: [PATCH v3 09/12] gpu: ipu-v3: Add Video Deinterlacer unit
Message-Id: <5f57ebae-48f4-84f0-a1f7-6a8eb8d32369@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
 <1469994147-17549-10-git-send-email-steve_longerbeam@mentor.com>
 <1470042798.3025.16.camel@pengutronix.de>
In-Reply-To: <1470042798.3025.16.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 08/01/2016 02:13 AM, Philipp Zabel wrote:
>
> Please remove the unused headers. I think you can remove all but
> export.h, types.h, errno.h, and io.h.
> Other than that, the patch now looks fine to me.
>

I was able to prune all but io.h, the rest is provided by ipu-prv.h.

Steve

