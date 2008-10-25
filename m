From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] vgacon: remember scrollback buffer on console
 switch
Date: Sat, 25 Oct 2008 13:46:15 -0700
Message-ID: <20081025134615.36f7285f.akpm@linux-foundation.org>
References: <20081025195814.GD10932@joi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752029AbYJYUrQ@vger.kernel.org>
In-Reply-To: <20081025195814.GD10932@joi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev-devel@lists.sourceforge.net

On Sat, 25 Oct 2008 21:58:19 +0200 Marcin Slusarz <marcin.slusarz@gmail.com> wrote:

> Add support for persistent console history, surviving
> console switches. It allocates new scrollback buffer only when
> user switches console for the first time.
> 
> Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fbdev-devel@lists.sourceforge.net
> ---
>  drivers/video/console/Kconfig  |   11 ++++++
>  drivers/video/console/vgacon.c |   75 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 2f50a80..09e3d98 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -43,6 +43,17 @@ config VGACON_SOFT_SCROLLBACK_SIZE
>  	 buffer.  Each 64KB will give you approximately 16 80x25
>  	 screenfuls of scrollback buffer
>  
> +config VGACON_REMEMBER_SCROLLBACK
> +	bool "Remember scrollback buffer on console switch"
> +	depends on VGACON_SOFT_SCROLLBACK
> +	default y
> +	help
> +	 Say 'Y' here if you want the scrollback buffer to be remembered
> +	 on console switch and restored when you switch back.
> +
> +	 Note: every VGA console will use its own buffer, but it will be
> +	 allocated only when you switch to this console for the first time.

I'd question the value in adding the config option.  Why not make the
feature unconditionally present?

>  
> +#define SCROLLBACK_SIZE (CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024)
> +
> ...
>
> +#ifdef CONFIG_VGACON_REMEMBER_SCROLLBACK
> +static struct vgacon_scrollback_info {
> +	void *data;
> +	int cnt;
> +	int tail;
> +	int cur;
> +	int rows;
> +	int size;
> +} vgacon_scrollbacks[MAX_NR_CONSOLES];

Perhaps you were concerned about memory consumption?

If so, it would be much much better to make this feature switchable at
runtime (module parameter/boot option or a /proc or /sys knob).

> +static int vgacon_last_vc_num;

We have lots of global state here with no apparent locking protecting
it.  Possibly there's some higher-level lock which provides
seralisation?  If so, the addition of a comment explaining all
this would be good.
