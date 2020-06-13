From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 13 Jun 2020 08:52:03 +0000
Subject: Re: [PATCH] efifb: BGRT: Fix typo in *deferred* in comment
Message-Id: <56370257-9259-22c4-572f-13ce086157d2@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200613081346.4532-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20200613081346.4532-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 6/13/20 10:13 AM, Paul Menzel wrote:
> Cc: linux-fbdev@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

LGTM:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/video/fbdev/efifb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 65491ae74808..42b4facc5e2b 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -91,7 +91,7 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
>   }
>   
>   /*
> - * If fbcon deffered console takeover is configured, the intent is for the
> + * If fbcon deferred console takeover is configured, the intent is for the
>    * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
>    * (error) message to display. But the boot graphics may have been destroyed by
>    * e.g. option ROM output, detect this and restore the boot graphics.
> 
