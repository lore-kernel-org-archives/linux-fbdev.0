From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:19:19 +0000
Subject: Re: [PATCH] carminefb: Fix module parameters permissions
Message-Id: <20110713081919.GG13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201107081104.38854.jdelvare@suse.de>
In-Reply-To: <201107081104.38854.jdelvare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Jul 08, 2011 at 11:04:38AM +0200, Jean Delvare wrote:
> The third parameter of module_param is supposed to be an octal value.
> The missing leading "0" causes the following:
> 
> $ ls -l /sys/module/carminefb/parameters/
> total 0
> -rw-rwxr-- 1 root root 4096 Jul  8 08:55 fb_displays
> -rw-rwxr-- 1 root root 4096 Jul  8 08:55 fb_mode
> -rw-rwxr-- 1 root root 4096 Jul  8 08:55 fb_mode_str
> 
> After fixing the perm parameter, we get the expected:
> 
> $ ls -l /sys/module/carminefb/parameters/
> total 0
> -r--r--r-- 1 root root 4096 Jul  8 08:56 fb_displays
> -r--r--r-- 1 root root 4096 Jul  8 08:56 fb_mode
> -r--r--r-- 1 root root 4096 Jul  8 08:56 fb_mode_str
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Cc: stable@kernel.org
> ---
>  drivers/video/carminefb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.
