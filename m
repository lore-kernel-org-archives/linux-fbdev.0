From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: how to test framebuffer driver
Date: Wed, 08 Sep 2004 21:24:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <413F5C58.B37C0419@orpatec.ch>
References: <4EE0CBA31942E547B99B3D4BFAB348111073FB@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C583J-0001rV-7O
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 12:24:21 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C583H-0006Jl-8V
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 12:24:21 -0700
Received: from orpatec.ch (217.162.130.125)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 8 Sep 2004 21:29:22 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

"Mukund JB." wrote:
> 
> Can I write an application by directly opening my fb device and
> performing operations like read/write/ioctl on it.
> 
Yes you can, see here
"http://cvs.sourceforge.net/viewcvs.py/wyodesktop/wyoDesktop/checkdfb/src/app.cpp?view=markup"
or here
"http://cvs.sourceforge.net/viewcvs.py/linux-fbdev/fbtest/main.c?view=markup".
You are welcomed to enhance either test or even write your own. Best if
you look at this thread as well "http://sourceforge.net/mailarchive/forum.php?thread_id=5445188&forum_id=2357".

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
