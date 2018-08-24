From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 24 Aug 2018 11:05:48 +0000
Subject: Re: [PATCH] drivers/video/fbdev: use ioremap_wc() instead of __ioremap(_PAGE_NO_CACHE)
Message-Id: <20180824110548.GV24439@gate.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
In-Reply-To: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Aug 24, 2018 at 10:16:22AM +0000, Christophe Leroy wrote:
> _PAGE_NO_CACHE is a target specific flag. Prefer generic functions.

>  #ifdef CONFIG_PPC
> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
> +	p->screen_base = ioremap_wc(addr, 0x200000);
>  #else

But that is not the same.  I think you want ioremap_nocache?


Segher
