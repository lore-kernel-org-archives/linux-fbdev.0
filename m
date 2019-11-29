From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Fri, 29 Nov 2019 14:12:34 +0000
Subject: Re: [PATCH v2 02/14] drm/fb-helper: don't preserve fb_ops across deferred IO use
Message-Id: <ba77f1eb-4363-9cbe-2df3-fe645f2bdcb9@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <1eae0b23d4724d5702b886b6a061ec8219eb9284.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <1eae0b23d4724d5702b886b6a061ec8219eb9284.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org



Den 29.11.2019 11.29, skrev Jani Nikula:
> Deferred IO now preserves the fb_ops.
> 
> v2: Remove the no-op vfree, drop a local var  (Noralf)
> 
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
