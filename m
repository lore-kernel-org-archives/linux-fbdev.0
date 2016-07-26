From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 26 Jul 2016 10:06:24 +0000
Subject: Re: [PATCH v2 00/13] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v2
Message-Id: <1469527584.3041.80.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com

Hi Steve,

Am Dienstag, den 19.07.2016, 18:10 -0700 schrieb Steve Longerbeam:
> These updates to IPUv3 are needed for media staging drivers
> for i.MX5/6 video capture and mem2mem.
> 
> Steve Longerbeam (13):
>   gpu: ipu-cpmem: Add ipu_cpmem_set_uv_offset()
>   gpu: ipu-cpmem: Add ipu_cpmem_get_burstsize()
>   gpu: ipu-v3: Add ipu_get_num()
>   gpu: ipu-v3: Add VDI input IDMAC channels
>   gpu: ipu-v3: set correct full sensor frame for PAL/NTSC
>   gpu: ipu-v3: Fix CSI data format for 16-bit media bus formats
>   gpu: ipu-v3: Fix IRT usage
>   gpu: ipu-v3: rename CSI client device

I have applied these.

>  gpu: ipu-v3: Add Video Deinterlacer unit
>  gpu: ipu-v3: Add IDMA channel linking support
>  gpu: ipu-v3: Add ipu_set_vdi_src_mux()
>  gpu: ipu-ic: Add complete image conversion support with tiling
>  gpu: ipu-ic: allow multiple handles to ic

But I have questions or comments for these.

The VDI depends on ipu_set_vdi_src_mux, which I still don't think is in
the correct place. Channel linking looks mostly ok to me, but the image
converter tiling doesn't work with fixed size tiles. See the other mails
for details.

best regards
Philipp

