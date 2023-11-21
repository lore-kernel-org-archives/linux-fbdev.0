Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddZv4SPR"
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30056BC;
	Mon, 20 Nov 2023 17:17:47 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7c143044625so1665359241.1;
        Mon, 20 Nov 2023 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700529466; x=1701134266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGmXn5CKggOy3q7NTIoSqYnfOjlh20rWLQ9IBsAKDA0=;
        b=ddZv4SPRwUdCMvK2XSlEZ2ec65W180Qh64LnlGVyCj7qYkE+ZNPD+dH0Soy12tKptw
         h38seOvxIJ+uzRZSNAFM8sI2AyocvZ4qmnBAQZTjL16umfUUfW9f+fZ512za0BDgd/SO
         dNj3M03GJu2T4VFqh213urVPkJ8Irz2mrVBN60/5J3c9lNTEHIN77A48N3pxHTwkBArR
         EMPFEOcCIxonRDPKy0SHIJdzFQ7ezE0xcWwas0dgJ9lVorUHylKUvfQgBLHC/cWhMK1w
         9878BAXXf296idguMV8E/zvI6+Y6MdrFdWtQhh/cBtdzrRhI51nItIuWyhlmWJapIWHi
         dsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700529466; x=1701134266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGmXn5CKggOy3q7NTIoSqYnfOjlh20rWLQ9IBsAKDA0=;
        b=X8BZZq8DTw6aPwnYxX4DNFLIaDT6amuQohDaq8Qa2cL3Vw45E0AlhhB4nyIlZ/xTTP
         99I7JdDoHd9SoHKnXy4GE5rcOz8DA2GHThJ+6D3cZAfOHg6800kXxz9tdKvJxOtWzcqz
         hSKsO/HiInmHJ/R4QQ4uyouENkvrttuUa8oe/Tq5BWuCv95QnNFoh8snoW1WyvSVhkUk
         Bl1jXJSW1kS1mkvFgPQOcpCQkd6oUM8dG+61Y9TeKMRG7eLUlC3A590srZ9Z0y5zEWxv
         sAVA8GR4K036rkG/ZBpAItZxnqH0OCOUSHTQUiKYWVCtu8ZBubk2wqRfKCOn64BBZVgu
         QRQQ==
X-Gm-Message-State: AOJu0YxrY5FuvGKKjb5ON2Xjp11ci3lh+zdpnZ4GaAEINd4pmqQdjtsk
	jsMPSgTK2J7yKwO39+4ha59Wbhdp4Ux0tw==
X-Google-Smtp-Source: AGHT+IH4yvMfT5ZViqlXyz8d4XoznDEEdpFcjJCiKurqj9qJF+62XmoN9YfZy7w1HBAEF5/tmx8ioA==
X-Received: by 2002:a67:fd50:0:b0:462:99ec:8f50 with SMTP id g16-20020a67fd50000000b0046299ec8f50mr4006091vsr.32.1700529466170;
        Mon, 20 Nov 2023 17:17:46 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::80ec])
        by smtp.gmail.com with ESMTPSA id pe6-20020a056214494600b0064f4e0b2089sm3464205qvb.33.2023.11.20.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:17:45 -0800 (PST)
Date: Mon, 20 Nov 2023 20:17:41 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>,
	Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fbdev/simplefb: Add support for generic
 power-domains
Message-ID: <ZVwFNfkqjrvhFHM0@radian>
References: <20231101172017.3872242-1-thierry.reding@gmail.com>
 <20231101172017.3872242-3-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101172017.3872242-3-thierry.reding@gmail.com>

Hello,

On Wed, Nov 01, 2023 at 06:20:17PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The simple-framebuffer device tree bindings document the power-domains
> property, so make sure that simplefb supports it. This ensures that the
> power domains remain enabled as long as simplefb is active.
>
> v2: - remove unnecessary call to simplefb_detach_genpds() since that's
>       already done automatically by devres
>     - fix crash if power-domains property is missing in DT
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/video/fbdev/simplefb.c | 93 ++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 18025f34fde7..fe682af63827 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/of_platform.h>
>  #include <linux/parser.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  
>  static const struct fb_fix_screeninfo simplefb_fix = {
> @@ -78,6 +79,11 @@ struct simplefb_par {
>  	unsigned int clk_count;
>  	struct clk **clks;
>  #endif
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +	unsigned int num_genpds;

This is the cause of the crash that occurred on the older patch series.
The field is unsigned, a deviation from v6.6:drivers/remoteproc/imx_rproc.c.

Instead of making it signed, this version emits an error whenever the
count is negative.

> +	struct device **genpds;
> +	struct device_link **genpd_links;
> +#endif
>  #if defined CONFIG_OF && defined CONFIG_REGULATOR
>  	bool regulators_enabled;
>  	u32 regulator_count;
> @@ -432,6 +438,89 @@ static void simplefb_regulators_enable(struct simplefb_par *par,
>  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
>  #endif
>  
> +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> +static void simplefb_detach_genpds(void *res)
> +{
> +	struct simplefb_par *par = res;
> +	unsigned int i = par->num_genpds;
> +
> +	if (par->num_genpds <= 1)
> +		return;
> +
> +	while (i--) {
> +		if (par->genpd_links[i])
> +			device_link_del(par->genpd_links[i]);
> +
> +		if (!IS_ERR_OR_NULL(par->genpds[i]))
> +			dev_pm_domain_detach(par->genpds[i], true);
> +	}
> +}
> +
> +static int simplefb_attach_genpds(struct simplefb_par *par,
> +				  struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	unsigned int i;
> +	int err;
> +
> +	err = of_count_phandle_with_args(dev->of_node, "power-domains",
> +					 "#power-domain-cells");
> +	if (err < 0) {
> +		dev_info(dev, "failed to parse power-domains: %d\n", err);
> +		return err;

This error path is taken when there is no power-domains property in the
device tree with err = -ENOENT.

Strangely, this does not suppress the error like the next if statement,
even though it is possible that nothing is wrong.

> +	}
> +
> +	par->num_genpds = err;
> +
> +	/*
> +	 * Single power-domain devices are handled by the driver core, so
> +	 * nothing to do here.
> +	 */
> +	if (par->num_genpds <= 1)
> +		return 0;
> +
> +	par->genpds = devm_kcalloc(dev, par->num_genpds, sizeof(*par->genpds),
> +				   GFP_KERNEL);
<snip>
> @@ -518,6 +607,10 @@ static int simplefb_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto error_clocks;
>  
> +	ret = simplefb_attach_genpds(par, pdev);
> +	if (ret < 0)
> +		goto error_regulators;

With the error case specified above, not specifying power-domains (which
is valid according to dtschema) causes the entire driver to fail
whenever there are no power domains in the device tree.

On google-sargo, this causes a bug where the framebuffer fails to probe:

    [    0.409290] simple-framebuffer 9c000000.framebuffer: failed to parse power-domains: -2
    [    0.409340] simple-framebuffer: probe of 9c000000.framebuffer failed with error -2
