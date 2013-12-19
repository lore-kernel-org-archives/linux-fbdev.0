From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 19 Dec 2013 16:36:06 +0000
Subject: Re: [PATCH v3] x86: sysfb: remove sysfb when probing real hw
Message-Id: <20131219163606.GA29243@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387374611-12493-1-git-send-email-dh.herrmann@gmail.com>
 <1387448038-8260-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1387448038-8260-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@wwwdotorg.org>, the arch/x86 maintainers <x86@kernel.org>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, stable@vger.kernel.org


* David Herrmann <dh.herrmann@gmail.com> wrote:

> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -35,6 +35,9 @@
>  
>  #include <asm/fb.h>
>  
> +#if IS_ENABLED(CONFIG_X86)
> +#include <asm/sysfb.h>
> +#endif

I think this can be written as:

#ifdef CONFIG_X86
# include <asm/sysfb.h>
#endif

also ... the dependency on a large, unrelated option like CONFIG_X86 
looks pretty ugly here - is there no other, more specific CONFIG_ 
option that can be used here - such as CONFIG_FB_SIMPLE or 
CONFIG_X86_SYSFB?

> +#if IS_ENABLED(CONFIG_X86)
> +	sysfb_unregister(apert, primary);
> +#endif

Ditto.

Thanks,

	Ingo 
