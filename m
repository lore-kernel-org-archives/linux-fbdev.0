From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] gxfb: Replace FBSIZE config
 option with a kernel argument
Date: Wed, 27 Feb 2008 16:31:05 -0800
Message-ID: <20080227163105.e1b96023.akpm@linux-foundation.org>
References: <20080223011045.48e6cb8e@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUWgk-00004x-9g for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 16:31:54 -0800
Received: from smtp1.linux-foundation.org ([207.189.120.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JUWgj-0000LE-0d
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 16:31:54 -0800
In-Reply-To: <20080223011045.48e6cb8e@ephemeral>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andres Salomon <dilinger@queued.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, jordan.crouse@amd.com, dwmw2@infradead.org

On Sat, 23 Feb 2008 01:10:45 -0500
Andres Salomon <dilinger@queued.net> wrote:

> @@ -425,7 +424,10 @@ static int __init gxfb_setup(char *options)
>  		if (!*opt)
>  			continue;
>  
> -		mode_option = opt;
> +		if (!strncmp(opt, "fbsize:", 7))
> +			fbsize = simple_strtoul(opt+7, NULL, 0);
> +		else
> +			mode_option = opt;
>  	}

The above shouldn't be necessary.

And it should have been documented in Documentation/kernel-parameters.txt.

And "fbsize=N" would be a lot more conventional than "fbsize:N"

I suspect that the formulation you have here will not permit "fbsize:128k",
whereas "fbsize=128k" or "gxfb.fbsize=128k" should work.  Needs checking.

>  	return 0;
> @@ -456,5 +458,8 @@ module_exit(gxfb_cleanup);
>  module_param(mode_option, charp, 0);
>  MODULE_PARM_DESC(mode_option, "video mode (<x>x<y>[-<bpp>][@<refr>])");
>  
> +module_param(fbsize, int, 0);
> +MODULE_PARM_DESC(fbsize, "video memory size");
> +

Because the module_param() already makes fbsize available on the kernel
boot command line via gxfb.fbsize=42 (or something similar).



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
