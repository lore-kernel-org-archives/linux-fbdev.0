From: John Zielinski <grim@undead.cc>
Subject: Re: console resize working
Date: Mon, 29 Dec 2003 16:08:24 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FF097C8.1050004@undead.cc>
References: <1072681474.812.12.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ab4d4-0006hb-Ko
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Dec 2003 13:08:46 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ab4d4-0001kE-4z
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Dec 2003 13:08:46 -0800
In-Reply-To: <1072681474.812.12.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>I have console resize working properly finally (and not trashing
>over memory like mad after I closed a bunch of races in the VT
>code itself) in my tree.
>
>Right now, that relies on the low-level fbdev doing some kind of
>mode validation and implementing FB_ACTIVATE_FIND though. Sucks a
>bit but I'll fix fbdev's. No other way to do that properly imho.
>Only my new radeonfb implements that for now (and it's only tested
>on flat panels so far, where I allow almost any mode when I have a
>scaler).
>
>Comments welcome.
>  
>
Cool.  I'll give it a whirl in the next few days and let you know.   
I've been busy with holiday activities for the last little while. 

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
