From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 07:51:04 +0000
Subject: Re: [PATCH 2/4 v4] video, sm501: add edid and commandline support
Message-Id: <20110125075104.GJ11673@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1295863047-11131-1-git-send-email-hs@denx.de>
In-Reply-To: <1295863047-11131-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Mon, Jan 24, 2011 at 10:57:27AM +0100, Heiko Schocher wrote:
> @@ -1884,7 +1935,6 @@ static int __devinit sm501fb_probe(struct platform_device *pdev)
>  
>  	if (info->pdata = NULL) {
>  		dev_info(dev, "using default configuration data\n");
> -		info->pdata = &sm501fb_def_pdata;
>  	}
>  
>  	/* probe for the presence of each panel */

I assume this is accidental? I don't see how you're compensating for this
in any of the other patches at least, as it's orthogonal from the default
mode settings.
