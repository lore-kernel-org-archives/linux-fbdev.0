From: John Zielinski <grim@undead.cc>
Subject: Re: fbcon or sisfb problem?
Date: Thu, 27 May 2004 22:32:34 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40B6A4C2.80708@undead.cc>
References: <40B6874E.8070200@winischhofer.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTXAy-0000bH-Od
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 19:32:52 -0700
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTXAy-0004zn-8k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 May 2004 19:32:52 -0700
In-Reply-To: <40B6874E.8070200@winischhofer.net>
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
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Thomas Winischhofer wrote:

> 1) Upon start (be it in kernel, be it upon modprobe), I see a big 
> white rectangle. It seems that this rectangle's size matches exactly 
> the size of the previous console area. I have seen reports of similar 
> problems since late 2003. Any progress on this? (I have digged around 
> in the fbcon code but got lost at some time.)
>
I get something similar when using the radeonfb driver except that I get 
mulit-colored garbage on the screen instead of solid white.  The 
difference is probably due to the different ways that radeonfb and sisfb 
remap the VGA memory layout.  I posted a fix in a post titled "Console 
takeover screen corruption issue" a while back on this list.

Could you see if that patch fixes your problem?  If enough people test 
it we could probably get it included into the kernel.

John




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
