From: James Simmons <jsimmons@infradead.org>
Subject: Re: Status of radeonfb in 2.5?
Date: Thu, 21 Nov 2002 18:38:43 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211211832230.1792-100000@phoenix.infradead.org>
References: <3DADD22F.9030508@netscape.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18EwEW-00025B-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Nov 2002 10:39:25 -0800
In-Reply-To: <3DADD22F.9030508@netscape.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Wourms <nwourms@netscape.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux-fbdev-devel@lists.sourceforge.net


> Excellent!  Two other questions (not necessarily related):
> 
> A) Is it (or will it ever be) possible to run dual head 
> using two different cards (like radeon & riva-tnt2)?  I know 
> there is still much work to be done, but I was curious if 
> this was even remotely possible.  Sorta hate to let a good 
> video card go to waste if you know what I mean :-).

Well that depends on if it is possible to initialize the card fully 
without using the graphics BIOS. To my current knowledge the Matrox card 
can do this and it is possible for the 3Dfx family of cards. This I have 
seen in the docs. As for NVIDIA cards they don't release that info and ATI 
is also funny about release such info as well :-(

> XFree-4.2?  I only ask because the XFree modelines are all 
> determined by i2c DDC probing, thus there are none in the 

Ah DDC support. I really wanted to add that into the fbdev layer but 
unfortunely I don't have the time to do that :-( Only if I did fbdev for a 
living.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
