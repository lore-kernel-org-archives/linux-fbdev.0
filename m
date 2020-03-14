From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 14 Mar 2020 17:41:08 +0000
Subject: Re: pm3fb.c: question
Message-Id: <044a63f0-2589-5550-572e-df57c7135c31@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9f7b3b9b-f48e-6da1-d08c-cc60f60b1eac@infradead.org>
In-Reply-To: <9f7b3b9b-f48e-6da1-d08c-cc60f60b1eac@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On 3/14/20 12:35 AM, Randy Dunlap wrote:
> In drivers/video/fbdev/pm3fb.c, if I change the definition of DPRINTK()
> (in order to remove some gcc warnings if -Wextra is used), like this:
> 
> -#define DPRINTK(a, b...)
> +#define DPRINTK(a, b...)	no_printk(a, ##b)
> 
> I get a build error here:
> 		default:
> 			DPRINTK("Unsupported depth %d\n",
> 				info->current_par->depth);
> 			break;
> 
> ../drivers/video/fbdev/pm3fb.c: In function ‘pm3fb_init_engine’:
> ../drivers/video/fbdev/pm3fb.c:353:9: error: ‘struct fb_info’ has no member named ‘current_par’
>      info->current_par->depth);
>          ^
> 
> Is there a replacement (fix) for this field?
> or should the entire DPRINTK() be deleted?
> or somethine else?

Got it.
I'll just change it to what is used in the switch statement above.

-- 
~Randy
