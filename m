From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] fbdev: Do not let
	CONFIG_FB_DEFERRED_IO default to y
Date: Thu, 24 Apr 2008 09:56:13 +0800
Message-ID: <45a44e480804231856o15b07749r3a31893f18d42d48@mail.gmail.com>
References: <Pine.LNX.4.64.0804232244150.15605@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Joqh5-0001wi-3m for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 18:56:15 -0700
Received: from wf-out-1314.google.com ([209.85.200.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Joqh3-00032K-Td
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 18:56:15 -0700
Received: by wf-out-1314.google.com with SMTP id 28so2256596wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 18:56:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0804232244150.15605@anakin>
Content-Disposition: inline
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>

On Thu, Apr 24, 2008 at 4:46 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> CONFIG_FB_DEFERRED_IO can not be turned off, while it's already selected
>  automatically by the drivers that need it.
>
>  Although it's nice to have more compile-coverage, not being able to disable a
>  rarely used feature is annoying.

Agreed.

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
