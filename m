From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 00:18:32 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404280013210.23153-100000@phoenix.infradead.org>
References: <1083106967.16473.33.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIbqZ-0008A1-8I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:18:39 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIbqY-0001hJ-LE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:18:39 -0700
In-Reply-To: <1083106967.16473.33.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



> a regression from 2.4 and I don't think his patch will be more invasive
> than the rest of the changes you have been doing lately ;)
> 
> Face it, the current fbcon resize mecanism is just broken. It cannot
> work properly without full mode management in all drivers. A per-VT var
> along with fbcon properly adapting it's size to the VT's var would bring
> us back to 2.4 level of functionality at least, which is a good thing.

I refuse to have hacks to deal with a cripple VT system. What is 
acceptable is that we add what we need to struct vc_data. You do that and 
I have no problem then. From what I can see we need the following.

1) Color depth.
2) Frequency.
3) Over scan color.

Anything else? 

Personally I rather add these to struct vc_data. Consider if we ever had 
hardware that supported different hardware text modes. Say some at 
different color depths. I rather do this!!





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
