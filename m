From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: patch to radeonfb accel functions
Date: Fri, 23 Apr 2004 20:18:08 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082715487.10628.6.camel@gaston>
References: <4088C014.7030505@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGxnZ-0002bX-C9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 03:20:45 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BGxnZ-0002cG-0K
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 03:20:45 -0700
In-Reply-To: <4088C014.7030505@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-04-23 at 17:04, John Zielinski wrote:
> I haven't seen anything about this on the list so I'm posting it.  The 
> first change adds the pseudo_palette lookup to the fillrect function 
> which cleans up the ugliness when running make menuconfig among other 
> things.  The second change I'm not 100% sure if it's right but I'm quite 
> sure what was originally there isn't right.  DP_SRC_RECT has the same 
> value as GMC_DST_8BPP and is listed in the DP_MIX section and not the 
> GMC section .  I'm assuming it should have been GMC_DP_SRC_RECT .  Can 
> someone else confirm this?

Your first patch wasn't lost, it's in my queue, I was planning to submit
it along with other fixes as soon as we have sorted out the fbcon accel
setting issue.

I'll look at this other question tomorrow hopefully

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
