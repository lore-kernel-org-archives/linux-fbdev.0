From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 09:50:50 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083109849.20091.1.camel@gaston>
References: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
	 <408EF0D9.6000403@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcRN-0006WQ-Oh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:56:41 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIcRN-000639-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:56:41 -0700
In-Reply-To: <408EF0D9.6000403@undead.cc>
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
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> That's another thing I'm adding to my kernel.  I didn't mention it as 
> I'm still trying to nail down a few details.  My current experiment is 
> that I've made device number 5,255 for now (later I'm either going to 
> make it 5,0 or just make fb0 point to it but that's one of the things 
> I'm debating) and call it just fb (for now).  Now when a user opens this 
> fb it will figure out what console they're on and refuse to run if it's 
> they're not on a physical console (unless fbcon is not compiled then it 
> will default to fb0 - these are the details I'm working on).

Hrm... I'm not fully confortable with this. I don't see why we need
anything different but what we had today.

> Now if the user really wants to start something from a serial console or 
> even a ssh session for that matter they can just use an explicit frame 
> buffer device like fb0, fb1, etc.  These would then be root only for 
> example.

Nah, software like X, MacOnLinux, etc... should open a VT and trigger a
console switch. Or at least switch to KD_GRAPHICS if they don't, but
then, having a user doing that to your console is only a matter of
setting the proper permissions. Again, I don't see what problem you
are trying to solve.

> An added bonus is that if you have multiple video cards or a dual head 
> configuration with each head on a different fbx device the 5,255 device 
> would figure out which console you are on when you start the program and 
> use the appropriate fb device.  Once the radeon dual head code gets 
> written I'll have to try to start X on fb0 (head 1) and leave the fbcon 
> running on fb1 (head two).
> 
> But this is just a fun little experiment on my part.  If I succeed I'll 
> let everyone know.
> 
> John
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
