From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: fbcon or sisfb problem?
Date: Fri, 28 May 2004 16:52:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B75217.2060704@winischhofer.net>
References: <40B6874E.8070200@winischhofer.net> <40B6A4C2.80708@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTije-0007iW-E4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 07:53:26 -0700
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BTijd-00004r-Ny
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 07:53:25 -0700
In-Reply-To: <40B6A4C2.80708@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: linux-fbdev-devel@lists.sourceforge.net

John Zielinski wrote:
> Thomas Winischhofer wrote:
> 
>> 1) Upon start (be it in kernel, be it upon modprobe), I see a big 
>> white rectangle. It seems that this rectangle's size matches exactly 
>> the size of the previous console area. I have seen reports of similar 
>> problems since late 2003. Any progress on this? (I have digged around 
>> in the fbcon code but got lost at some time.)
>>
> I get something similar when using the radeonfb driver except that I get 
> mulit-colored garbage on the screen instead of solid white.  The 
> difference is probably due to the different ways that radeonfb and sisfb 
> remap the VGA memory layout.  I posted a fix in a post titled "Console 
> takeover screen corruption issue" a while back on this list.
> 
> Could you see if that patch fixes your problem?  If enough people test 
> it we could probably get it included into the kernel.
> 
> John
> 
> 

Will do.

BTW: I saw a post on google groups where a user of a Maxtrox described 
the exactly same phenomenon, ie white rectangle.

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
