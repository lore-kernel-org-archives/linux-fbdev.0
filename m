From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: Problem with FB
Date: Fri, 18 May 2007 09:48:38 +0200
Message-ID: <464D5A56.4070906@rfo.atmel.com>
References: <464B3527.4080406@apexar.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoxCn-0002xV-TH for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 May 2007 00:48:53 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoxCn-0002Li-AF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 May 2007 00:48:53 -0700
In-Reply-To: <464B3527.4080406@apexar.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: buildroot@uclibc.org

Diego A. Fons :
> Hi,
> 
> First of all i'm not sure if it is the correct list for posting this 
> mail, if it's not, please tell me wich list is the correct one.
> 
> I'm working on an embedded device (a Ronetix pm9261 board with an 
> AT91SAM9261 cpu), i could build the linux kernel version 2.6.19.7 with 
> framebuffer support and it works fine. The problem is when i run any 
> command that uses net services, i.e. when i run sftp the sreen moves and 
> it kept like this, the offset (0,0) is in position (100,0) (it's just an 
> example, i don't know thw correct values) and i'm not able to correct 
> it. It occurs every time i run a net comand. The display i'm usin is a 
> LCD and the driver is sidsab.c.

Strange behavior is not it ;-)

I have seen this before and it was due to a bad timing setup of the
dm9000 chip select.

-	at91_sys_write(AT91_SMC_CYCLE(2), AT91_SMC_NWECYCLE_(0) | AT91_SMC_NRDCYCLE_(16));
+	at91_sys_write(AT91_SMC_CYCLE(2), AT91_SMC_NWECYCLE_(16) | AT91_SMC_NRDCYCLE_(16));

Is you have the first configuration, try with the second and it should
fix your problem.

Hope that it helps. Tell us if it works.

Regards,
-- 
Nicolas Ferre



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
