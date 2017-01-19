From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 19 Jan 2017 13:23:52 +0000
Subject: Re: [PATCH v10 3/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170119132352.GB29998@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
 <20170113200758.9880-4-manuel.schoelling@gmx.de>
In-Reply-To: <20170113200758.9880-4-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jan 13, 2017 at 09:07:57PM +0100, Manuel Sch=F6lling wrote:
> Add a scrollback buffers for each VGA console. The benefit is that
> the scrollback history is not flushed when switching between consoles
> but is persistent.
> The buffers are allocated on demand when a new console is opened.
>=20
> This breaks tools like clear_console that rely on flushing the
> scrollback history by switching back and forth between consoles
> which is why this feature is disabled by default.
> Use the escape sequence \e[3J instead for flushing the buffer.
>=20
> Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
> Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
> Tested-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  drivers/video/console/Kconfig  |  25 +++++++-
>  drivers/video/console/vgacon.c | 142 ++++++++++++++++++++++++++---------=
------
>  2 files changed, 111 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index c3f1fb9ee820..f500e58f7636 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -43,9 +43,28 @@ config VGACON_SOFT_SCROLLBACK_SIZE
>         range 1 1024
>         default "64"
>         help
> -         Enter the amount of System RAM to allocate for the scrollback
> -	 buffer.  Each 64KB will give you approximately 16 80x25
> -	 screenfuls of scrollback buffer
> +	  Enter the amount of System RAM to allocate for scrollback
> +	  buffers of VGA consoles. Each 64KB will give you approximately
> +	  16 80x25 screenfuls of scrollback buffer.
> +
> +config VGACON_SOFT_SCROLLBACK_PERSISTENT
> +	bool "Persistent Scrollback History for each console"
> +	depends on VGACON_SOFT_SCROLLBACK
> +	default n
> +	help
> +	  Say Y here if the scrollback history should persist when switching
> +	  between consoles. Otherwise, the scrollback history will be flushed
> +	  each time the console is switched.
> +
> +	  This feature might break your tool of choice to flush the scrollback
> +	  buffer, e.g. clear(1) will work fine but Debian's clear_console(1)
> +	  will be broken, which might cause security issues.
> +	  You can use the escape sequence \e[3J instead if this feature is
> +	  activated.

This issue is the one that makes me the most worried.  Why doesn't
clear_console() work anymore?  Why doesn't it use \e[3J ?

thanks,

greg k-h
