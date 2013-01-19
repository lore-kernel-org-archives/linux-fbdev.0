From: Timur Tabi <timur@tabi.org>
Date: Sat, 19 Jan 2013 13:51:35 +0000
Subject: Re: [PATCH v2 2/2] drivers/video: fsl-diu-fb: fix bugs in interrupt handling
Message-Id: <50FAA4E7.6070808@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358589550-3246-1-git-send-email-agust@denx.de>
In-Reply-To: <1358589550-3246-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Anatolij Gustschin wrote:
> Disabling the interrupts in fsl_diu_release() must happen only if all
> other AOIs are closed. Otherwise closing an overlay plane will disable
> the interrupts even if the primary frame buffer plane is opened. Add
> an appropriate check in the release function.

I thought the release function is only called when the driver is unloaded. 
  Wouldn't the framebuffers all already be closed by then?

> +static inline void fsl_diu_enable_interrupts(struct fsl_diu_data *data)
> +{
> +	u32 int_mask = INT_UNDRUN; /* enable underrun detection */
> +
> +	if (IS_ENABLED(CONFIG_NOT_COHERENT_CACHE))
> +		int_mask |= INT_VSYNC; /* enable vertical sync */

Why did you turn this into a run-time check?

-- 
Timur Tabi
