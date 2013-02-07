From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 07 Feb 2013 13:28:48 +0000
Subject: Re: [RFC PATCH v2 2/5] drm/edid: temporarily exposing generic edid-read interface from drm
Message-Id: <CAKMK7uFQg8Wsibz8T0VBB8yJf3P=yTbRhhH3pTTGGxiYZo8dfA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360238951-7022-1-git-send-email-rahul.sharma@samsung.com>
In-Reply-To: <1360238951-7022-1-git-send-email-rahul.sharma@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rahul Sharma <rahul.sharma@samsung.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, broonie@opensource.wolfsonmicro.com, joshi@samsung.com, kyungmin.park@samsung.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com

On Thu, Feb 7, 2013 at 1:09 PM, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> It exposes generic interface from drm_edid.c to get the edid data and length
> by any display entity. Once I get clear idea about edid handling in CDF, I need
> to revert these temporary changes.

Just a quick reply about edid reading: One of the key results (at
least imo) of the fosdem cdf discussion was that we need to split up
the different parts of it clearly (i.e. abstract panel interface, dsi
support, discovery/dev matching, ...) to have more flexibility. One
idea is also to not use the panel interface for e.g. hdmi transcoders,
but only use the bus support (like dsi), since transcoders which
connect to external devices like hdmi need to expose _much_ more
features to the master driver and so it's better to have tighter
integration. Some of the things which need close cooperation between
drivers are e.g. edid reading, hotplug handling,
bpp/colorspace/restricted range stuff, ... I didn't read through the
patch which requires the exported drm edid stuff, but maybe this helps
a bit.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
