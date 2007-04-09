From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 5/7] rivafb: Fixed reversed DDC ports
Date: Mon, 9 Apr 2007 17:51:45 +0200
Message-ID: <20070409175145.4cb788cd@hyperion.delvare>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HawAN-0005Sl-LB for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:52:27 -0700
Received: from smtp-101-monday.nerim.net ([62.4.16.101] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HawAN-00081r-7t
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Apr 2007 08:52:27 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Antonino Daplas <adaplas@pol.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

(Sorry for the referenceless reply, but I am not subscribed to
linux-fbdev-devel.)

> Fixed reversed DDC port so the assignments are congruent with nvidiafb's and
> X's nv driver.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
>  drivers/video/riva/rivafb-i2c.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
> index bcb2096..b9f1590 100644
> --- a/drivers/video/riva/rivafb-i2c.c
> +++ b/drivers/video/riva/rivafb-i2c.c
> @@ -133,11 +133,11 @@ void __devinit riva_create_i2c_busses(st
>  	par->chan[1].par	= par;
>  	par->chan[2].par        = par;
>  
> -	par->chan[0].ddc_base = 0x3e;
> -	par->chan[1].ddc_base = 0x36;
> +	par->chan[0].ddc_base = 0x36;
> +	par->chan[1].ddc_base = 0x3e;
>  	par->chan[2].ddc_base = 0x50;
> -	riva_setup_i2c_bus(&par->chan[0], "BUS1", 0);
> -	riva_setup_i2c_bus(&par->chan[1], "BUS2", I2C_CLASS_HWMON);
> +	riva_setup_i2c_bus(&par->chan[1], "BUS1", I2C_CLASS_HWMON);
> +	riva_setup_i2c_bus(&par->chan[0], "BUS2", 0);
>  	riva_setup_i2c_bus(&par->chan[2], "BUS3", 0);
>  }

Do you really want to swap &par->chan[0] and &par->chan[1] here? I
don't think so, otherwise it almost reverts the change you are doing -
and it breaks the classes, too.

-- 
Jean Delvare

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
