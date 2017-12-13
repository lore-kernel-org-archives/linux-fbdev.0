From: David Lechner <david@lechnology.com>
Date: Wed, 13 Dec 2017 03:00:29 +0000
Subject: Re: [v7,2/7] drm: Add panel orientation quirks, v6.
Message-Id: <c5a466d8-afb9-d3f1-b661-2c35641a96fd@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125193553.23986-3-hdegoede@redhat.com>
In-Reply-To: <20171125193553.23986-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On 11/25/2017 01:35 PM, Hans de Goede wrote:
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> new file mode 100644
> index 000000000000..b8765e2ed1d6
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c

This file taints the kernel when it is compiled as a module. It needs a 
MODULE_LICENSE().
