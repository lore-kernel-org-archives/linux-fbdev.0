From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Voyager GX color mapping
Date: Tue, 14 Dec 2004 18:40:35 +0100
Message-ID: <41BF2593.7000709@anagramm.de>
References: <41BF177E.7010205@anagramm.de> <Pine.GSO.4.61.0412141744200.10558@waterleaf.sonytel.be> <41BF1F8C.6030501@anagramm.de> <Pine.GSO.4.61.0412141818150.10558@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeGde-0006nW-FO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 09:39:06 -0800
Received: from moutng.kundenserver.de ([212.227.126.171])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CeGdd-0005P2-2G
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 09:39:06 -0800
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CeGdb-0000Hk-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 18:39:03 +0100
Received: from [217.235.127.66] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CeGdb-0000Rv-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 18:39:03 +0100
In-Reply-To: <Pine.GSO.4.61.0412141818150.10558@waterleaf.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi, Geert!

> I wrote `fbtest', not `fbset' ;-)

Okay... I will get it... very soon, tomorrow :-)

>>Well, whenever I change the (yet hardcoded) structs in the driver,
>>fbset -fb /dev/fb2 shows me the correct (changed) values.
>>But there is no change in X at all if I play around with the values.
>>Is it possible that X doesn't get my fb_var_screeninfo? Maybe I need
>>to check xorg.cfg again...
> 
> 
> X may try to change the values again. If you're driver allows that (like it
> seem to do, as per your description above), it may become confusion. Please
> don't allow to change the bitfields in your driver, only allow the values that
> the hardware does support.

Okay... interesting... How does it (try and fail to) change it?
Through IOCTL FBIOPUT_VSCREENINFO? Can I get more debug info out of it?
It's all unread-code-land for me yet. My driver might not implement that
yet... Is there good documentation in addition to RTFC?

Thanks again... I'll keep on learning.

Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
