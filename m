From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] s3c2410fb: byte ordering fixes
Date: Sun, 9 Sep 2007 11:28:28 +0200
Message-ID: <20070909112828.0bd6427a.krzysztof.h1@gmail.com>
References: <46c1d7beb3dd8@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IUIzK-00038f-87 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Sep 2007 02:21:54 -0700
Received: from fk-out-0910.google.com ([209.85.128.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IUIzH-0003Jg-EB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Sep 2007 02:21:54 -0700
Received: by fk-out-0910.google.com with SMTP id 19so1219785fkr
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 09 Sep 2007 02:21:50 -0700 (PDT)
In-Reply-To: <46c1d7beb3dd8@wp.pl>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 14 Aug 2007 18:26:38 +0200
"Krzysztof Helt" <krzysztof.h1@wp.pl> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch sets correct bits related to the byte ordering
> of the framebuffer. This was tested on little endian kernel
> only. The big endian kernel may require different settings.
> 
> The patch also adds 32 bpp mode which is called 24 bpp by
> Samsung. One pixel takes 32 bits but only 24 bits are used
> in this mode.
> 

Tony, 

This patch didn't make into the -mm tree with other s3c2410fb patches.
Please look into it.

Regards,
Krzysztof

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
