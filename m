From: e.fuste@focal.fr
Subject: RE:Whats the scoop for the apollo framebuffers?
Date: Fri, 31 May 2002 18:14:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <OF23FD3867.7218A6AF-ONC1256BCA.0057E5DF-C1256BCA.0059138E@antall.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailhost.antall.com ([194.51.175.3] helo=stella.antall.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Dp2g-0007dz-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 09:14:18 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux-fbdev-devel@lists.sourceforge.net

>I noticed dnfb.c and dn_cfb4.c and dn_cfb8.c. They look the same except
>for different modes. Anyone have a clue here?

Yes, the only functionnal one was dnfb.c, the others were for testing
purpose:
Developpers Peter (and me for a less big part) had only the mono frame
buffer board.
There is color boards for Apollo DN workstation for which I have docs, but
I no longuer
have access to the hardware, color fb or Apollo. Basic color fb management
is similar to
the mono one.
Apollo hardware is ISA based, perhaps someone still have some working one.
I stoped working on Linux Apollo port because of lack of hardware.

Bye.


Emmanuel.
(Sory for my froggy english ;-))


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
