From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 18:38:06 +0000
Subject: Re: [PATCH v3 1/3] printk: Export is_console_locked
Message-Id: <562ee932-f163-d085-818d-2f8545da546f@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
 <20180626183612.321-2-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Hi,

As the cover letter's subject correctly indicates this is v4 of the
patch-set, I forgot to bump the subject-prefix when sending, so the
v3 in the subject here really should be v4.

Regards,

Hans


On 26-06-18 20:36, Hans de Goede wrote:
> This is a preparation patch for adding a number of WARN_CONSOLE_UNLOCKED()
> calls to the fbcon code, which may be built as a module (event though
> usually it is not).
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patchset
> ---
>   kernel/printk/printk.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..3f041e7cbfc9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2243,6 +2243,7 @@ int is_console_locked(void)
>   {
>   	return console_locked;
>   }
> +EXPORT_SYMBOL(is_console_locked);
>   
>   /*
>    * Check if we have any console that is capable of printing while cpu is
> 
