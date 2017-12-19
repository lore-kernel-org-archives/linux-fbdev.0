From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2017 18:41:57 +0000
Subject: Re: [-next PATCH 2/4] treewide: Use DEVICE_ATTR_RW
Message-Id: <CAHp75VfyvA3kAtGiwJ63BOx43RuVSz-XgdK79WApytoaehOOgQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1513706701.git.joe@perches.com>
 <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
In-Reply-To: <cd38f14f06e1f447b3159ffe8c69c0df8241bb6e.1513706701.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-s390@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi <linux-scsi@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, James Smart <james.smart@broadcom.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dick Kennedy <dick.kennedy@broadcom.com>, Mathias Nyman <mathias.nyman@intel.com>, Bartlomiej

On Tue, Dec 19, 2017 at 8:15 PM, Joe Perches <joe@perches.com> wrote:
> Convert DEVICE_ATTR uses to DEVICE_ATTR_RW where possible.
>
> Done with perl script:
>
> $ git grep -w --name-only DEVICE_ATTR | \
>   xargs perl -i -e 'local $/; while (<>) { s/\bDEVICE_ATTR\s*\(\s*(\w+)\s*,\s*\(?(\s*S_IRUGO\s*\|\s*S_IWUSR|\s*S_IWUSR\s*\|\s*S_IRUGO\s*|\s*0644\s*)\)?\s*,\s*\1_show\s*,\s*\1_store\s*\)/DEVICE_ATTR_RW(\1)/g; print;}'

>  drivers/platform/x86/compal-laptop.c | 18 +++++----------

> --- a/drivers/platform/x86/compal-laptop.c
> +++ b/drivers/platform/x86/compal-laptop.c
> @@ -679,18 +679,12 @@ static int bat_writeable_property(struct power_supply *psy,
>  /* ======= */
>  /* Driver Globals */
>  /* ======= */
> -static DEVICE_ATTR(wake_up_pme,
> -               0644, wake_up_pme_show,         wake_up_pme_store);
> -static DEVICE_ATTR(wake_up_modem,
> -               0644, wake_up_modem_show,       wake_up_modem_store);
> -static DEVICE_ATTR(wake_up_lan,
> -               0644, wake_up_lan_show, wake_up_lan_store);
> -static DEVICE_ATTR(wake_up_wlan,
> -               0644, wake_up_wlan_show,        wake_up_wlan_store);
> -static DEVICE_ATTR(wake_up_key,
> -               0644, wake_up_key_show, wake_up_key_store);
> -static DEVICE_ATTR(wake_up_mouse,
> -               0644, wake_up_mouse_show,       wake_up_mouse_store);
> +static DEVICE_ATTR_RW(wake_up_pme);
> +static DEVICE_ATTR_RW(wake_up_modem);
> +static DEVICE_ATTR_RW(wake_up_lan);
> +static DEVICE_ATTR_RW(wake_up_wlan);
> +static DEVICE_ATTR_RW(wake_up_key);
> +static DEVICE_ATTR_RW(wake_up_mouse);

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for PDx86 bits.

Have to say that while it doesn't change the attributes here, it might
require still to be revisited by security people, if they wish.

-- 
With Best Regards,
Andy Shevchenko
