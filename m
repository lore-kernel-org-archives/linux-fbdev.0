From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 05 Jun 2012 19:15:29 +0000
Subject: Re: [PATCH] mbxfb: unbreak compilation with CONFIG_FB_MBX_DEBUG
Message-Id: <4FCE5AD1.6040705@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337013111-7732-1-git-send-email-tartler@cs.fau.de>
In-Reply-To: <1337013111-7732-1-git-send-email-tartler@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tartler@cs.fau.de
Cc: Eric Miao <eric.y.miao@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de, Reinhard Tartler <siretart@tauware.de>

Hi,

On 05/14/2012 04:31 PM, tartler@cs.fau.de wrote:
> From: Reinhard Tartler <siretart@tauware.de>
> 
> This patch adds missing function prototypes.
> 
> Signed-off-by: Reinhard Tartler <tartler@cs.fau.de>
> ---
>  drivers/video/mbx/mbxfb.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> This patch was found with tools developed in the VAMOS project:
> http://www4.cs.fau.de/Research/VAMOS/
> 
> TBH, I'm not sure if this is the correct solution. However, I'd
> appreciate if someone could confirm that this is a real bug.
> 
> 
> diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
> index 6ce3416..c2200ec 100644
> --- a/drivers/video/mbx/mbxfb.c
> +++ b/drivers/video/mbx/mbxfb.c
> @@ -878,6 +878,9 @@ static int mbxfb_resume(struct platform_device *dev)
>  #ifndef CONFIG_FB_MBX_DEBUG
>  #define mbxfb_debugfs_init(x)	do {} while(0)
>  #define mbxfb_debugfs_remove(x)	do {} while(0)
> +#else
> +void mbxfb_debugfs_init(struct fb_info *fbi);
> +void mbxfb_debugfs_remove(struct fb_info *fbi);

I don't agree. checkpatch complains
WARNING: externs should be avoided in .c files
#71: FILE: drivers/video/mbx/mbxfb.c:882:
+void mbxfb_debugfs_init(struct fb_info *fbi);

And in drivers/video/mbx/mbxdebugfs.c
static void __devinit mbxfb_debugfs_init(struct fb_info *fbi)
static void __devexit mbxfb_debugfs_remove(struct fb_info *fbi)

So even if you want to ignore the checkpatch warning (which I could
understand for just 2 includes even if headers are certainly better)
you'd have to remove the static at the implementation and for
consistency include the __devinit/exit in your prototypes.

>  #endif
>  
>  #define res_size(_r) (((_r)->end - (_r)->start) + 1)


Best regards,

Florian Tobias Schandinat
