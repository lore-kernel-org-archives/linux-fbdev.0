From: Nicolas Kaiser <nikai@nikai.net>
Date: Tue, 26 Oct 2010 12:36:50 +0000
Subject: Re: [PATCH 12/14] drivers/video/omap/blizzard.c: delete double
Message-Id: <20101026143650.14c836eb@absol.kitzblitz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1288088743-3725-1-git-send-email-julia@diku.dk>
	<1288088743-3725-13-git-send-email-julia@diku.dk>
In-Reply-To: <1288088743-3725-13-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Julia Lawall <julia@diku.dk>:
> Delete successive assignments to the same location.  Initialize the out_y
> field as well as the out_x field, rather than initializing the out_x field
> twice.

Hi there!

An identical patch is already in the -mm tree:

> The patch titled
>      drivers/video/omap/blizzard.c: suspected typo in assignment
> has been added to the -mm tree.  Its filename is
>      video-omap-suspected-typo-in-assignment.patch

> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: drivers/video/omap/blizzard.c: suspected typo in assignment
> From: Nicolas Kaiser <nikai@nikai.net>
> 
> Untested, but looks like an obvious typo to me.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Best regards,
Nicolas Kaiser
