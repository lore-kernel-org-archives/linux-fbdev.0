From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 04/15] ps3vram: Replace mutex by spinlock + list
Date: Fri, 8 May 2009 16:05:44 -0700
Message-ID: <20090508160544.28189203.akpm@linux-foundation.org>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755626AbZEHXKt@vger.kernel.org>
In-Reply-To: <1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Geert.Uytterhoeven@sonycom.com, jim@jtan.com

On Fri,  8 May 2009 16:01:13 +0200
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> +static int ps3vram_make_request(struct request_queue *q, struct bio *bio)
> +{
> +	struct ps3_system_bus_device *dev = q->queuedata;
> +	struct ps3vram_priv *priv = dev->core.driver_data;
> +
> +	dev_dbg(&dev->core, "%s\n", __func__);
> +
> +	spin_lock_irq(&priv->lock);
> +	if (priv->tail) {
> +		priv->tail->bi_next = bio;
> +		priv->tail = bio;
> +		spin_unlock_irq(&priv->lock);
> +		return 0;
> +	}
> +
> +	priv->tail = bio;
> +	spin_unlock_irq(&priv->lock);
> +
> +	do {
> +		bio = ps3vram_do_bio(dev, bio);
> +	} while (bio);

Is there something which prevents two threads of control from walking
the same list at the same time?

> +
>  	return 0;
>  }
