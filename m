From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 25 Oct 2017 17:32:53 +0000
Subject: Re: [RFC 08/14] bootsplash: Add file reading and picture rendering
Message-Id: <0b8c3644-1915-9a0a-696e-115742498cc2@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
 <20171025124602.28292-9-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-9-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

On 10/25/17 05:45, Max Staudt wrote:

> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index a6617c07229a..c3496c5ac2bb 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -175,6 +175,14 @@ config BOOTSPLASH
>            If unsure, say N.
>            This is typically used by distributors and system integrators.
>  
> +config BOOTSPLASH_FILE
> +        string "Default full path to bootsplash file"
> +        depends on BOOTSPLASH
> +        default "/bootsplash"
> +        help
> +          This file will be looked for in the initramfs and, if found, loaded
> +          and used as a bootsplash.


Some people try to avoid using initramfs.

Can one have a bootsplash without initramfs?


or maybe this is just for distros, who expect the initramfs to be there.

-- 
~Randy
