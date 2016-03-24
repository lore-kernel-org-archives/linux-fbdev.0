From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Thu, 24 Mar 2016 10:34:29 +0000
Subject: Re: [Intel-gfx] [PATCH 1/3] drm: Add new DCS commands in the enum list
Message-Id: <87egb0dv0q.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1458813835-7626-1-git-send-email-m.deepak@intel.com>
In-Reply-To: <1458813835-7626-1-git-send-email-m.deepak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Deepak M <m.deepak@intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Thu, 24 Mar 2016, Deepak M <m.deepak@intel.com> wrote:
> Adding new DCS commands which are specified in the
> DCS 1.3 spec related to CABC.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Suggested-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Deepak M <m.deepak@intel.com>

Deepak, for future reference, please use scripts/get_maintainer.pl to
see whom you should include for patches touching code outside of i915.

The commands added match the MIPI DCS 1.3 spec,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Jean-Christophe, Tomi, may I have your acks for merging this via
drm/i915 tree?

BR,
Jani.

> ---
>  include/video/mipi_display.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
> index ddcc8ca..bb8195b 100644
> --- a/include/video/mipi_display.h
> +++ b/include/video/mipi_display.h
> @@ -117,6 +117,14 @@ enum {
>  	MIPI_DCS_GET_SCANLINE		= 0x45,
>  	MIPI_DCS_READ_DDB_START		= 0xA1,
>  	MIPI_DCS_READ_DDB_CONTINUE	= 0xA8,
> +	MIPI_DCS_GET_DISPLAY_BRIGHTNESS = 0x52,
> +	MIPI_DCS_GET_CABC_MIN_BRIGHTNESS = 0x5F,
> +	MIPI_DCS_GET_POWER_SAVE		= 0x56,
> +	MIPI_DCS_GET_CONTROL_DISPLAY	= 0x54,
> +	MIPI_DCS_SET_DISPLAY_BRIGHTNESS = 0x51,
> +	MIPI_DCS_SET_CABC_MIN_BRIGHTNESS = 0x5E,
> +	MIPI_DCS_WRITE_POWER_SAVE	= 0x55,
> +	MIPI_DCS_WRITE_CONTROL_DISPLAY  = 0x53,
>  };
>  
>  /* MIPI DCS pixel formats */

-- 
Jani Nikula, Intel Open Source Technology Center
