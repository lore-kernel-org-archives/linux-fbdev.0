From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 23:50:11 -0500
Message-ID: <9e47339105030720507cc34a68@mail.gmail.com>
References: <200503060816.55890.adaplas@hotpop.com>
	 <20050307022828.54d52983.akpm@osdl.org>
	 <9e47339105030711117f6ffdc9@mail.gmail.com>
	 <20050307154355.2fd5094c.akpm@osdl.org>
	 <9e473391050307163553dbd88e@mail.gmail.com>
	 <20050307174736.6a363b39.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Wfe-0002fu-CP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 20:50:14 -0800
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Wfe-0007QF-0J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 20:50:14 -0800
Received: by rproxy.gmail.com with SMTP id z35so2234830rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 20:50:13 -0800 (PST)
In-Reply-To: <20050307174736.6a363b39.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

On Mon, 7 Mar 2005 17:47:36 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> >
> > Not sure if ppc will build since I don't have a machine to check it on.
> 
> ppc seems OK.
> 
> Now x86 `allmodconfig' is unhappy.
> 
> *** Warning: "fb_find_logo" [drivers/video/fb.ko] undefined!
> 
> diff -puN drivers/video/logo/logo.c~fbdev-allow-core-fb-to-be-built-as-a-module-fix-fix drivers/video/logo/logo.c
> --- 25/drivers/video/logo/logo.c~fbdev-allow-core-fb-to-be-built-as-a-module-fix-fix    2005-03-07 17:42:38.000000000 -0800
> +++ 25-akpm/drivers/video/logo/logo.c   2005-03-07 17:42:38.000000000 -0800
> @@ -12,6 +12,7 @@
>  #include <linux/config.h>
>  #include <linux/linux_logo.h>
>  #include <linux/stddef.h>
> +#include <linux/module.h>
> 
>  #ifdef CONFIG_M68K
>  #include <asm/setup.h>
> @@ -99,4 +100,4 @@ const struct linux_logo *fb_find_logo(in
>         }
>         return logo;
>  }
> -
> +EXPORT_SYMBOL_GPL(fb_find_logo);
> _
> 
> 

Did you fix this or do I need to send another patch?

I didn't know about allmodconfig so I'll be sure and run it. It's
about time fb became a module, it's been built in for about ten years.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
