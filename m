From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: long time of switch console->X (fast opposite
 way)
Date: Sun, 18 Jul 2004 02:48:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40F9C8D9.9010605@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Blzqv-0007We-PU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jul 2004 17:48:29 -0700
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Blzqv-0002BT-5D
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 17 Jul 2004 17:48:29 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Miernik <miernik@ctnet.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net


 > The problem I have it takes 6.7 seconds to switch from console to X
 > with <Alt><F7>. The 6.7 s time is very consistent, every time I
 > measure it. It's very long and annoying.

This is very probably related to a problem with your mouse (which some 
versions of X reset during startup). Check your XF86Config and the X log 
for related messages. This is, however, not any of my drivers' fault.

Besides, sisfb does not support 1152x864 at 60Hz. This mode is (yet) 
only supported at 75 and 85Hz, both of which exceed the HSync range of 
your monitor. Hence the log entries (which BTW only appear when the 
display mode is switched and not "every several minutes").

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
