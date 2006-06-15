From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/7 2.6.17-rc6-mm2] add preliminary
 i2c support to intelfb
Date: Thu, 15 Jun 2006 09:04:35 +0200
Message-ID: <20060615090435.74476472.khali@linux-fr.org>
References: <EB373D75-DE32-4833-B201-8EFF45533863@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fqluc-0000s0-IB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jun 2006 00:05:06 -0700
Received: from smtp-104-thursday.nerim.net ([62.4.16.104] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FqluO-0004qx-3Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jun 2006 00:04:54 -0700
In-Reply-To: <EB373D75-DE32-4833-B201-8EFF45533863@cecropia.com>
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
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>, linux-fbdev-devel@lists.sourceforge.net

Hi Dennis,

> From: Dennis Munsie <dmunsie@cecropia.com>
> 
> [01/07] i2c: add intelfb bit algorithm id
> 
> Adds the intelfb bit algorithm id to i2c-id.h.
> 
> Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>
> 
> ---
> 
> include/linux/i2c-id.h |    1 +
> 1 file changed, 1 insertion(+)
> 
> diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff linux-2.6.17-rc6-patched/include/linux/i2c-id.h linux/include/linux/i2c-id.h
> --- linux-2.6.17-rc6-patched/include/linux/i2c-id.h	2006-06-13  14:57:01.000000000 -0500
> +++ linux/include/linux/i2c-id.h	2006-06-14 10:04:54.000000000 -0500
> @@ -189,6 +189,7 @@
> #define I2C_HW_B_RADEON		0x01001e /* radeon framebuffer driver */
> #define I2C_HW_B_EM28XX		0x01001f /* em28xx video capture cards */
> #define I2C_HW_B_CX2341X	0x010020 /* Conexant CX2341X MPEG encoder  
> cards */
> +#define I2C_HW_B_INTELFB	0x010021 /* intel framebuffer driver */
> /* --- PCF 8584 based algorithms					*/
> #define I2C_HW_P_LP		0x020000 /* Parallel port interface */

No need to make a seperate patch for this, this belongs to the same
patch where the user of this value is introduced.

Thanks,
-- 
Jean Delvare
