From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] radeonfb: fix setting of
	PPLL_REF_DIV for RV370	5B60
Date: Tue, 04 Sep 2007 15:47:03 +0200
Message-ID: <1188913623.5972.152.camel@localhost.localdomain>
References: <20070904110000.GG7320@devil>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ITG7i-00089B-NZ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 05:06:14 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18W70lWjTbQLt9CkL53OX0OK30hLYUi4LE=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ITG7h-0001UJ-8L
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Sep 2007 05:06:14 -0700
In-Reply-To: <20070904110000.GG7320@devil>
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
To: aherrman@arcor.de
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 2007-09-04 at 13:00 +0200, aherrman@arcor.de wrote:
> As observed with various Radeon X300: console goes blank
> without fixing setting of PPLL_REF_DIV.
> 
> Signed-off-by: Andreas Herrmann <aherrman@arcor.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/video/aty/radeon_base.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> index f672c0c..71b0c17 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -1287,7 +1287,8 @@ static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct radeon_reg
>  	if (rinfo->family == CHIP_FAMILY_R300 ||
>  	    rinfo->family == CHIP_FAMILY_RS300 ||
>  	    rinfo->family == CHIP_FAMILY_R350 ||
> -	    rinfo->family == CHIP_FAMILY_RV350) {
> +	    rinfo->family == CHIP_FAMILY_RV350 ||
> +	    rinfo->family == CHIP_FAMILY_RV380 ) {
>  		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
>  			/* When restoring console mode, use saved PPLL_REF_DIV
>  			 * setting.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
