From: Martin Sieper <msi@ngi-box.de>
Subject: Computer with 1GB and radeonfb
Date: Fri, 30 May 2003 22:13:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <elmo105432563416005480015305@arbeitspferd>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mx2.ngi.de ([213.191.74.84])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19LqGf-00013x-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 30 May 2003 13:14:25 -0700
Received: from unknown (HELO arbeitspferd) ([213.20.27.4])
          (envelope-sender <msi@ngi-box.de>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <linux-fbdev-devel@lists.sourceforge.net>; 30 May 2003 20:04:53 -0000
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hello developers,

I have a P4 computer with 1GB of RAM and a Radeon 9100 and I'm
using linux 2.4.20.

I had try the vesafb but it's failed. OK I've found a
patch for big memory on this list  and now vasafb works fine.

The radeonfb doesn't work. OK I've found these patch
radeonfb-041103-2.4.20.diff also on this list but the
radeonfb doesn't work:

May 30 13:22:22 arbeitspferd kernel: radeonfb_pci_register BEGIN
May 30 13:22:22 arbeitspferd kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=20000 from BIOS
May 30 13:22:22 arbeitspferd kernel: radeonfb: probed DDR SGRAM 131072k videoram
May 30 13:22:22 arbeitspferd kernel: BIOS 4 scratch = 2000002
May 30 13:22:22 arbeitspferd kernel: FP_GEN_CNTL: 0, FP2_GEN_CNTL: 8
May 30 13:22:22 arbeitspferd kernel: TMDS_TRANSMITTER_CNTL: 10000082, TMDS_CNTL: 1000000, LVDS_GEN_CNTL: 0
May 30 13:22:22 arbeitspferd kernel: DAC_CNTL: ff604002, DAC_CNTL2: 0, CRTC_GEN_CNTL: 2000200
May 30 13:22:22 arbeitspferd kernel: radeonfb: cannot map FB

I think it's also a big memory problem like the vesafb.
I'm not a kernel hacker, can someone help me please?

Thanks

Martin



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
