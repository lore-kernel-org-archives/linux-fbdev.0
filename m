From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Fri, 13 Mar 2015 09:46:37 +0000
Subject: Re: [RFC 1/6] drm: Add top level Kconfig option for DRM fbdev emulation
Message-Id: <87d24dqlfm.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425980493-27533-1-git-send-email-architt@codeaurora.org> <1425980493-27533-2-git-send-email-architt@codeaurora.org> <20150310094756.GE3800@phenom.ffwll.local> <54FEBEF1.5000103@codeaurora.org> <20150310100547.GG3800@phenom.ffwll.local> <54FEC5F1.90208@codeaurora.org> <20150310121702.GO3800@phenom.ffwll.local> <54FFFAEE.3020301@codeaurora.org> <20150311151731.GJ3800@phenom.ffwll.local> <550282C3.10903@codeaurora.org> <20150313090651.GZ3800@phenom.ffwll.local>
In-Reply-To: <20150313090651.GZ3800@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <architt@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, daniel@ffwll.ch, robdclark@gmail.com, airlied@linux.ie, treding@nvidia.com, p.zabel@pengutronix.de, benjamin.gaignard@linaro.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com

On Fri, 13 Mar 2015, Daniel Vetter <daniel@ffwll.ch> wrote:
> #if defined(CONFIG_FB)
> #include <linux/fb.h>
> #else

Side note, #if IS_ENABLED(CONFIG_FB)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
