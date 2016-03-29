From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Tue, 29 Mar 2016 12:43:18 +0000
Subject: Re: [Intel-gfx] [PATCH 1/5] drm: Add new DCS commands in the enum list
Message-Id: <87poud315l.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459157327-2443-1-git-send-email-m.deepak@intel.com>
In-Reply-To: <1459157327-2443-1-git-send-email-m.deepak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Deepak M <m.deepak@intel.com>, Daniel Vetter <daniel.vetter@intel.com>, Andrzej Hajda <a.hajda@samsung.com>

On Mon, 28 Mar 2016, Deepak M <m.deepak@intel.com> wrote:
> Adding new DCS commands which are specified in the
> DCS 1.3 spec related to CABC.
>
> v2: Sorted the Macro`s by value (Andrzej)

Yeah, well, the *new* ones are now sorted, but I'm pretty sure Andrzej
did mean to keep the whole enum sorted.

While at it, the comment could be /* MIPI DCS 1.3 */ to be specific and
useful.

>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Suggested-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Deepak M <m.deepak@intel.com>
> ---
>  include/video/mipi_display.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
> index ddcc8ca..6831c84 100644
> --- a/include/video/mipi_display.h
> +++ b/include/video/mipi_display.h
> @@ -117,6 +117,14 @@ enum {
>  	MIPI_DCS_GET_SCANLINE		= 0x45,
>  	MIPI_DCS_READ_DDB_START		= 0xA1,
>  	MIPI_DCS_READ_DDB_CONTINUE	= 0xA8,
> +	MIPI_DCS_SET_DISPLAY_BRIGHTNESS = 0x51, /*Spec 1.3*/
> +	MIPI_DCS_GET_DISPLAY_BRIGHTNESS = 0x52, /*Spec 1.3*/
> +	MIPI_DCS_WRITE_CONTROL_DISPLAY  = 0x53, /*Spec 1.3*/
> +	MIPI_DCS_GET_CONTROL_DISPLAY	= 0x54, /*Spec 1.3*/
> +	MIPI_DCS_WRITE_POWER_SAVE	= 0x55, /*Spec 1.3*/
> +	MIPI_DCS_GET_POWER_SAVE		= 0x56, /*Spec 1.3*/
> +	MIPI_DCS_SET_CABC_MIN_BRIGHTNESS = 0x5E, /*Spec 1.3*/
> +	MIPI_DCS_GET_CABC_MIN_BRIGHTNESS = 0x5F, /*Spec 1.3*/
>  };
>  
>  /* MIPI DCS pixel formats */

-- 
Jani Nikula, Intel Open Source Technology Center
