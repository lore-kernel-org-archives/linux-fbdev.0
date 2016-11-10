From: Andrey Utkin <andrey_utkin@fastmail.com>
Date: Thu, 10 Nov 2016 21:47:48 +0000
Subject: Re: [PATCH v3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161110214748.GB26324@dell-m4800.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 19, 2016 at 12:06:57AM +0200, Manuel Sch=F6lling wrote:
> Add a scrollback buffers for each VGA console. The benefit is that
> the scrollback history is not flushed when switching between consoles
> but is persistent.
> The buffers are allocated on demand when a new console is opened.

Hi,

I have noticed your message on #kernelnewbies IRC channel.

Thanks for the patch. This is definitely very useful, especially when
you boot into rescue system and use raw console and not a fancy
X11-based terminal app.

>=20
> It always annoys me when I switch back to a console and I can just
> read half of an error backtrace. This should fix issues like these.

Personal feelings don't belong to commit messages. Previous paragraph is
enough to express the purpose.

>=20
> This breaks tools like clear_console that rely on flushing the
> scrollback history by switching back and forth between consoles
> which is why this feature is disabled by default.
> Use the escape sequence \e[3J instead for flushing the buffer.

Have never heard of such tool as clear_console. Why mention it at all,
where is it used, which are practical configurations which are broken in
this way?

Does this break clear(1)?

>=20
> Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> ---
> Changes in v3:
>   - Add config option for this feature
>   - Fallback to old scrollback buffer if kcalloc() fails
>   - Remove ioctl() call again and add documentation about existing
>     escape sequence to flush the scrollback buffer
> Changes in v2:
>   - Add ioctl() call to flush scrollback buffer
>   - (Patch v2 was not labeled as such, sorry)
> ---
>  drivers/video/console/Kconfig  |  23 +++++-
>  drivers/video/console/vgacon.c | 160 +++++++++++++++++++++++++++--------=
------
>  2 files changed, 128 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 38da6e2..67e52f0 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -43,9 +43,26 @@ config VGACON_SOFT_SCROLLBACK_SIZE
>         range 1 1024
>         default "64"
>         help
> -         Enter the amount of System RAM to allocate for the scrollback
> -	 buffer.  Each 64KB will give you approximately 16 80x25
> -	 screenfuls of scrollback buffer
> +	  Enter the amount of System RAM to allocate for scrollback
> +	  buffers of VGA consoles. Each 64KB will give you approximately
> +	  16 80x25 screenfuls of scrollback buffer.

Indentation amended, I don't know which way it should be, please
double-check or mimic old indentation to stay on safe side.

> +
> +config VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE

Feels like bad naming. What about VGACON_SOFT_SCROLLBACK_PERSISTENT?

> +	bool "Persistent Scrollback History for each console"
> +	depends on VGACON_SOFT_SCROLLBACK
> +	default n
> +	help
> +	  Say Y here if for each VGA console a scrollback buffer should
> +	  be allocated. The scrollback history will persist when switching

Unnatural order of sentence IMHO, however I'm not native English.

> +	  between consoles. If you say N here, scrollback is only supported
> +	  for the active VGA console and scrollback history will be flushed
> +	  when switching between consoles.

I think you may put less text here. You can skip details like "buffer
... allocated", just explain the difference in behaviour.

> +
> +	  This breaks legacy versions of tools like clear_console which
> +	  might cause security issues.
> +	  Use the escape sequence \e[3J instead if this feature is activated.

See above. I'd drop this paragraph if clear(1) is not broken.

> +
> +	  If you use a RAM-constrained system, say N here.

Which exactly cases to consider? I can't think of any practical one. You
may want to help user to figure out if he should consider this by
explaining that VGACON_SOFT_SCROLLBACK_SIZE is taken for each created
tty device (right?). Or drop this line :)

> =20
>  config MDA_CONSOLE
>  	depends on !M68K && !PARISC && ISA
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index 1157661..e70e8fe 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -1,5 +1,5 @@
>  /*
> - *  linux/drivers/video/vgacon.c -- Low level VGA based console driver
> + *  linux/drivers/video/console/vgacon.c -- Low level VGA based console =
driver

Cosmetic changes in separate patch please.

>   *
>   *	Created 28 Sep 1997 by Geert Uytterhoeven
>   *
> @@ -181,70 +181,125 @@ static inline void vga_set_mem_top(struct vc_data =
*c)
> =20
>  #ifdef CONFIG_VGACON_SOFT_SCROLLBACK
>  /* software scrollback */
> -static void *vgacon_scrollback;
> -static int vgacon_scrollback_tail;
> -static int vgacon_scrollback_size;
> -static int vgacon_scrollback_rows;
> -static int vgacon_scrollback_cnt;
> -static int vgacon_scrollback_cur;
> -static int vgacon_scrollback_save;
> -static int vgacon_scrollback_restore;
> -
> -static void vgacon_scrollback_init(int pitch)
> +struct vgacon_scrollback_info {
> +	void *data;
> +	int tail;
> +	int size;
> +	int rows;
> +	int cnt;
> +	int cur;
> +	int save;
> +	int restore;
> +};

Refactor in separate patch please.
It would be much nicer if you make first patch in series which would
gather all these variables into struct and uses it everywhere, leaving
external behaviour the same. Then, in following patches, change the
behaviour, one trait at a time.

> +static struct vgacon_scrollback_info *vgacon_scrollback_cur;

Could you use name vgacon_scrollback instead of new
vgacon_scrollback_cur? It doesn't change anything conceptually, but is a
bit shorter and seems to mean current scrollback context anyway, right?

I think I see nothing to comment on below.

Looking forward to see your reply. Would definitely like to test this
when I have some time.
