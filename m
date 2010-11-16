From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 16 Nov 2010 13:36:41 +0000
Subject: Re: [PATCH v2] OMAP: DSS2: OMAPFB: Add null pointer check
Message-Id: <1289914601.2668.97.camel@tubuntu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289908147-12468-1-git-send-email-samreen@ti.com>
In-Reply-To: <1289908147-12468-1-git-send-email-samreen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Samreen <samreen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-11-16 at 12:49 +0100, ext Samreen wrote:
> A null pointer check added. And using kstrdup()
> instead of kmalloc() & strcpy()
> 
> Signed-off-by: Samreen <samreen@ti.com>
> ---
> Version2:
>    - Using kstrdup() instead of kmalloc() & strcpy()
>    - Using ENOMEM as error code instead of EINVAL
>    - Subject changed appropriately
> 
> The link to v1 of patch is:
> https://patchwork.kernel.org/patch/319642/

Thanks, applied.

 Tomi


