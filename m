From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pm2fb: change option mode to
	mode_option
Date: Thu, 14 Feb 2008 13:56:44 -0800
Message-ID: <20080214135644.7093136e.akpm@linux-foundation.org>
References: <20080214225213.19ab943b.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPm5G-0004Bq-9e for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:57:34 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JPm5F-00081N-1I
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Feb 2008 13:57:34 -0800
In-Reply-To: <20080214225213.19ab943b.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Thu, 14 Feb 2008 22:52:13 +0100
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch changes the option "mode_option" into "mode".
> 
> ...
>  
> -module_param(mode, charp, 0);
> -MODULE_PARM_DESC(mode, "Preferred video mode e.g. '648x480-8@60'");
> +module_param(mode_option, charp, 0);
> +MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
>  module_param(lowhsync, bool, 0);
>  MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless of mode");
>  module_param(lowvsync, bool, 0);

But it's not backward compatible.  We'll break people's setups.

Not _much_, and we can probably live with it.  But surely it'd be pretty
simple to retain the old option as well?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
