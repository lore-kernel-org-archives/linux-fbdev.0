From: Archit Taneja <archit@ti.com>
Date: Mon, 11 Mar 2013 06:33:59 +0000
Subject: Re: [PATCH 20/20] OMAPDSS: Taal: remove rotate & mirror support
Message-Id: <513D7807.2010509@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-21-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-21-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> Taal panel driver has support to set rotation and mirroring. However,
> these features cannot be used without causing tearing, and are never
> used. The code is just extra bloat, so let's remove it.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

<snip>
>   static ssize_t taal_num_errors_show(struct device *dev,
> @@ -1025,10 +973,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
>   	if (r)
>   		goto err;
>
> -	r = taal_set_addr_mode(td, td->rotate, td->mirror);
> -	if (r)
> -		goto err;
> -

I'm curious if we need to set the address mode(to the default value) at 
least once. It may not be a requirement for Taal, but if that's the 
case, why did we have a set_addr_mode() call in taal_power_on() in the 
first place? Is it because we can prepare rotation and mirroring before 
we enable the panel?

Archit

