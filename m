From: Joe Perches <joe@perches.com>
Date: Sun, 06 Jul 2014 17:46:28 +0000
Subject: Re: [PATCH] video: fbdev: sis: sis_main.c:  Cleaning up wrong type in format string
Message-Id: <1404668788.27043.44.camel@joe-AO725>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404668190-15199-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404668190-15199-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2014-07-06 at 19:36 +0200, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'unsigned int'
> but the argument type is 'int'

Perhaps it'd be better to change the type of mydepth
to __u16 as that's the type of lfb_depth

> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
[]
> @@ -237,7 +237,7 @@ static void sisfb_get_vga_mode_from_kernel(void)
>  
>  		if(mydepth = 24) mydepth = 32;
>  
> -		sprintf(mymode, "%ux%ux%u", screen_info.lfb_width,
> +		sprintf(mymode, "%ux%ux%d", screen_info.lfb_width,
>  					screen_info.lfb_height,
>  					mydepth);
>  


