From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: ACPI: ibm-acpi: fix initial status of backlight device
Date: Thu, 22 Feb 2007 10:03:07 +0000
Message-ID: <1172138587.5837.37.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	 <20070219000412.acad13de.akpm@linux-foundation.org>
	 <1171876788.6046.3.camel@localhost.localdomain>
	 <877iub9mu2.fsf@sycorax.lbl.gov>
	 <1172097718.5790.29.camel@localhost.localdomain>
	 <20070221231706.GA3336@khazad-dum.debian.net>
	 <1172103159.5790.45.camel@localhost.localdomain>
	 <20070222005122.GA7928@khazad-dum.debian.net>
	 <20070222011017.GA8845@khazad-dum.debian.net>
	 <20070222011643.GB8845@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070222011643.GB8845@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Wed, 2007-02-21 at 23:16 -0200, Henrique de Moraes Holschuh wrote:
> NOTE: This patch needs an ACK from Richard Purdie before it can be merged,
> as he might want to change the backlight class code instead.

As mentioned elsewhere, we can't do this in the class itself.

> --- a/drivers/acpi/ibm_acpi.c
> +++ b/drivers/acpi/ibm_acpi.c
> @@ -1713,6 +1713,13 @@ static struct backlight_properties ibm_backlight_data = {
>  
>  static int brightness_init(void)
>  {
> +	int b;
> +
> +	b = brightness_get(NULL);
> +	if (b < 0)
> +		return b;
> +	ibm_backlight_data.brightness = b;
> +
>  	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
>  							 &ibm_backlight_data);

This isn't against 2.6.21-rc1 which changed the backlight class a bit.
Basically, you need to set the brightness variable after
backlight_device_register(). It should be simple enough to do and fix
the problem the same way though.

Richard


