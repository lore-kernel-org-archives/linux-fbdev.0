From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: [Linux-fbdev-devel]
 framebuffer-driver-for-mq11xx-graphics-chip.patch added to -mm tree
Date: Sat, 6 Aug 2005 13:54:32 +0400
Message-ID: <20050806135432.073bdc37.zap@homelink.ru>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
	<42F335C9.5010009@varma-el.com>
	<Pine.LNX.4.56.0508052103390.19722@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1LOQ-0000N5-Ub
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 02:55:02 -0700
Received: from mail.homelink.ru ([81.9.33.123] helo=eltel.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1LOO-0007uc-IP
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 06 Aug 2005 02:55:03 -0700
In-Reply-To: <Pine.LNX.4.56.0508052103390.19722@pentafluge.infradead.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, jamey@handhelds.org, anpaza@mail.ru, mm-commits@vger.kernel.org

On Fri, 5 Aug 2005 21:06:17 +0100 (BST)
James Simmons <jsimmons@infradead.org> wrote:

> I don't see the mq11xx.h. If it contains graphics related 
> information like register names I would recommend 
> it being placed into include/video. 
mq11xx.h contains register names, but its not framebuffer-specific
because this chip contains several functions inside, like an USB Device
Controller (UDC), an SPI controller, an auxiliary GPIO controller and
more. Maybe it should be in include/mfd if the .c file will be moved to
drivers/mfd.

-- 
Greetings,
   Andrew


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
