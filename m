From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: FB_EVENT (blank and unblank?)
Date: Sat, 27 Nov 2004 14:53:48 -0000
Message-ID: <010501c4d490$e9edee40$0f01a8c0@max>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411250016.25813.adaplas@hotpop.com> <41A5F24A.4040804@fujitsu-siemens.com> <200411260351.57443.adaplas@hotpop.com> <Pine.GSO.4.61.0411261010460.26681@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CY3xX-00005O-Hr
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 06:53:59 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CY3xW-00013w-GN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 06:53:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iAREroeg015993
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Nov 2004 14:53:50 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 15664-04 for <linux-fbdev-devel@lists.sourceforge.net>;
 Sat, 27 Nov 2004 14:53:49 +0000 (GMT)
Received: from max (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iARErjlW015985
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Nov 2004 14:53:45 GMT
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-fbdev-devel@lists.sourceforge.net

I've been looking at ways to solve a couple of code interdepencies I don't 
like with w100fb and its backlight  and touch screen drivers.

I have two places where they need to talk. The first is for the touch screen 
to query the x resolution (and to know if the screen is blanked)[1]. The 
second is to turn the backlight off when the console is blanked.

On solution I've been looking at is to use fb_register_client. I could then 
hook into mode changes and that solves one problem. There is currently no 
FB_EVENT_BLANK and  FB_EVENT_UNBLANK however. Would it be acceptable to add 
these events with appropriate hooks in fbmem.c and to use fb_register_client 
in these drivers to obtain this information?

Or can anyone see an alternative other than global variables?

[1] Presumably for interference reasons, it only queries the touchscreen 
after a hsync. The hysnc pulse can be obtained from the IO lines but to get 
the timing right, xres also needs to be known. If the screen is blank, these 
delays can be disabled...

-- 
Richard 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
