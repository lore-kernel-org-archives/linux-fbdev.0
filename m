From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve
	diagnostics
Date: Wed, 19 Sep 2007 17:24:12 -0700
Message-ID: <20070919172412.725508d0.akpm@linux-foundation.org>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IY9qN-0000xW-H5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 17:24:35 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IY9qN-0003Dj-7p
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 17:24:35 -0700
In-Reply-To: <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org

On Tue, 18 Sep 2007 13:18:34 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  Add error messages to the probe call.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  While they may rarely trigger, they may be useful when something weird is 
> going on.  Also this is good style.
> 
>  This is an updated version that addresses an issue raised by Mariusz 
> Kozlowski for the sibling patch.  Checked with checkpatch.pl.
> 
>  Please apply.
> 
>   Maciej
> 
> patch-mips-2.6.23-rc5-20070904-pmag-ba-err-2
> diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c
> --- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c	2007-02-21 05:56:47.000000000 +0000
> +++ linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c	2007-09-18 10:56:51.000000000 +0000
> @@ -147,16 +147,23 @@ static int __init pmagbafb_probe(struct 
>  	resource_size_t start, len;
>  	struct fb_info *info;
>  	struct pmagbafb_par *par;
> +	int err = 0;

This initialisation to zero is not good.

Because if some error-path code forgot to do `err = -EFOO' then probe()
will return zero and the driver will leave things in half-initialised state
and will then proceed as if things had succeeded.  It will crash.

So it's better to leave this local uninitialised, because we really want to
get that compiler warning if someone forgot to set the return value.

I made that change, but am too stupid to be able to work out how to create
a config which will let me compile this thing.

akpm:/usr/src/25> grep PMAG arch/arm/configs/*
akpm:/usr/src/25> 

bah.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
