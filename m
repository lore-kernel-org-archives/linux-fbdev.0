From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 28 Aug 2015 12:57:40 +0000
Subject: Re: [PATCH v2] OMAPDSS: hdmi: Reconfigure and restart audio when display is enabled
Message-Id: <55E05AC4.1030206@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440764660-10417-1-git-send-email-jsarha@ti.com>
In-Reply-To: <1440764660-10417-1-git-send-email-jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, tomi.valkeinen@ti.com

On 08/28/15 15:24, Jyri Sarha wrote:
> @@ -565,9 +594,14 @@ out:
>   static int hdmi_audio_shutdown(struct device *dev)
>   {
>   	struct omap_hdmi *hd = dev_get_drvdata(dev);
> +	unsigned long flags;
>
>   	mutex_lock(&hd->lock);
>   	hd->audio_abort_cb = NULL;
> +	hd->audio_configured = false;
> +	spin_lock_irqsave(&hd->audio_playing_lock, flags);
> +	hd->audio_playing = false;
> +	spin_unlock_irqrestore(&hd->audio_playing_lock, flags);
>

BTW, This extra locking (and the corresponding change in hdmi5.c) should 
not be needed. But it does not harm either. I'll fix that, but I'll wait 
first if there is anything else fix.

Best regards,
Jyri
