From: James Simmons <jsimmons@transvirtual.com>
Subject: [PATCH] Fbdev updates and fixes.
Date: Thu, 30 May 2002 12:38:52 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205301227340.12679-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DVlU-000678-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 12:39:16 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Hannu Mallat <hmallat@cc.hut.fi>, Denis Oliver Kropp <dok@convergence.de>, Russell King <rmk@arm.linux.org.uk>


Here are several fixes and a few new ports. The drivers I ported over
to the new api are: 

1) 3DFX Voodoo3+ fbdev driver 

2) NeoMagic fbdev driver

Please review these drivers. 

-----------------
The fixes where for the anakin framebuffer and CLPS711X framebuffer.


/////////////////////////////////////////////////////////////////////
The standard diff is at 

http://www.transvirtual.com/~jsimmons/fbdev.diff

and the BK link is 

http://fbdev.bkbits.net:8080/fbdev-2.5

Thank you.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
