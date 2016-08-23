From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 23 Aug 2016 08:03:03 +0000
Subject: Re: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans Verkil's CEC code
Message-Id: <57BC0337.2080203@xs4all.nl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hansverk@cisco.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On 08/12/16 16:15, Russell King wrote:
> +	ret = devm_request_threaded_irq(&pdev->dev, cec->irq,
> +					dw_hdmi_cec_hardirq,
> +					dw_hdmi_cec_thread, IRQF_SHARED,
> +					DEV_NAME, cec->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cec_register_adapter(cec->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * CEC documentation says we must not call cec_delete_adapter
> +	 * after a successful call to cec_register_adapter().
> +	 */
> +	devm_remove_action(&pdev->dev, dw_hdmi_cec_del, cec);
> +
> +	hdmi_register_notifier(&cec->nb);

The notifier is registered here, but who provides CEC with the initial
physical address? As I understand it, it only tells you when things change,
not what the initial state is.

Regards,

	Hans
