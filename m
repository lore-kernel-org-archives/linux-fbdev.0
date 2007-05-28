From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: Problem with FB
Date: Mon, 28 May 2007 17:18:57 +0200
Message-ID: <465AF2E1.9090705@rfo.atmel.com>
References: <464B3527.4080406@apexar.com>
	<464D5A56.4070906@rfo.atmel.com>	<464DA279.6070404@apexar.com>
	<464DA8FA.6050303@rfo.atmel.com> <4655CC7D.6020600@apexar.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hsh02-0001k9-Be for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 08:19:10 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hsh01-0002Ld-Jh
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 08:19:10 -0700
In-Reply-To: <4655CC7D.6020600@apexar.com>
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
To: "Diego A. Fons" <diegofons@apexar.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Diego A. Fons :
> I was changing the timings values but it seems to get worse, with a set 
> of values the screen moves with every ftp command thet sftp sends!
> Now the values are (it doesn't work either):
> 
> #define AT91_DM9000_NWE_SETUP           (8 << 0)
> #define AT91_DM9000_NCS_WR_SETUP        (4 << 8)
> #define AT91_DM9000_NRD_SETUP           (8 << 16)
> #define AT91_DM9000_NCS_RD_SETUP        (4 << 24)
> 
> #define AT91_DM9000_NWE_PULSE           (16 << 0)
> #define AT91_DM9000_NCS_WR_PULSE        (32 << 8)
> #define AT91_DM9000_NRD_PULSE           (16 << 16)
> #define AT91_DM9000_NCS_RD_PULSE        (32 << 24)
> 
> #define AT91_DM9000_NWE_CYCLE           (36 << 0)
> #define AT91_DM9000_NRD_CYCLE           (36 << 16)
> 
> #define AT91_DM9000_TDF                 (1 << 16)
> 
> I test it with lower and higher values and nothing (with 1 and 127).
> 
> Can you tell me how is it possible that the DM9000 timings interfere 
> with the frame buffer?

Well they both use the SDRam/EBI interface (in fact the ARM926 and the LCD) 
and they may be in conflict some time to get the internal AHB bus (H matrix).
The idea is that one or the other master takes the bus for too long.

What can help us is if you can also check if the fifo underflow UFLWIS 
bit (#4) rises during LDC use.

So, if the LCD is interrupted during a data burst from sdram, it can have 
difficulties to resume its transfer. You can try to lower the configured burst 
length on the LCD : 
ATMEL_LCDC_DMA_BURST_LEN = 4 (so the register field must be written with 0x3) 
instead of 8.

Another option will be to keep the burst length and increase the slot cycle 
in the Matrix interface (from 16->32 or 64). It is the preferred one. This is 
done in the AT91bootstrap but you can do it for testing using a jtag ice.

Keep me informed, Cheers,
-- 
Nicolas Ferre



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
