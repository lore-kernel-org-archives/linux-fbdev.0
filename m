From: Andre Dias <aod@unisys.com.br>
Subject: sis acceleration
Date: Thu, 30 May 2002 00:59:35 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.0.20020530004937.019193a8@pop.unisys.com.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gw.incubadora.coppe.ufrj.br ([146.164.9.131] helo=inc)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DH6d-0000Hi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 21:00:07 -0700
Received: from [146.164.9.154] (helo=aod-laptop.unisys.com.br)
	by inc with esmtp (Exim 3.12 #1 (Debian))
	id 17DEKb-00029o-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 May 2002 22:02:21 -0300
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi!

I have built the latest 2.4.18 stable several times. But when I try to 
include as a module the SIS acceleration ( SIS 630/540/730 support only ) 
for the frame buffer I get this error:

depmod: *** Unresolved symbols in 
/lib/modules/2.4.18/kernel/drivers/video/sis/sisfb.o
depmod:         mclk
depmod:         sisfb_set_dispsw_accel
depmod:         eclk
depmod:         sisfb_init_legacy_vga
depmod:         sisfb_calc_clock_param
depmod:         sisfb_calc_clock_freq
make: *** [_modinst_post] Error 1


does anyone know to whom should I send a bug report?

thanks in advance



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
