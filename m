From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9847] New: i810fb: module
 parameter 'mode_option' inconsistent with other framebuffer modules
Date: Thu, 31 Jan 2008 23:32:32 -0800
Message-ID: <20080131233232.a7bf51d5.akpm@linux-foundation.org>
References: <20080201070131.27F842BD8B5@f25.poczta.interia.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKqOC-0006SR-1I for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 23:32:44 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JKqOA-0005ns-Hz
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jan 2008 23:32:43 -0800
In-Reply-To: <20080201070131.27F842BD8B5@f25.poczta.interia.pl>
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
To: krzysztof.h1@poczta.fm
Cc: jsimmons@infradead.org, miki@dds.nl, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On 01 Feb 2008 08:01:30 +0100 krzysztof.h1@poczta.fm wrote:

> > On Tue, 29 Jan 2008 21:02:39 -0800 (PST) bugme-daemon@bugzilla.kernel.org
> > wrote:
> > > Problem Description: While all other framebuffer modules use the option
> > > "mode=..." to specify a modedb-style video mode, i810fb uses the
> > non-standard
> > > "mode_option=..." 
> 
> The attached patch should fix it.
> --
> 
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch changes the option "mode_option" into "mode".
> 

Thanks.

> -module_param(mode_option, charp, 0);
> -MODULE_PARM_DESC(mode_option, "Specify initial video mode");
> +module_param(mode, charp, 0);
> +MODULE_PARM_DESC(mode, "Specify initial video mode");

But can we retain the old option as well, to avoid breaking people's
existing setups?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
