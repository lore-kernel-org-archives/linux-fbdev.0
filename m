From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Restoring Screen when coming back
	from	KD_GRAPHICS
Date: Thu, 25 Dec 2003 09:47:38 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072306057.15476.19.camel@gaston>
References: <3FC4603C.2000702@undead.cc> <1072254378.739.65.camel@gaston>
	 <3FEA0E0D.3030001@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZHna-00077R-EZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 14:48:14 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZHnZ-0000KK-4i
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 14:48:13 -0800
In-Reply-To: <3FEA0E0D.3030001@undead.cc>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>


> I'll take a look.  This fits well with what I'm trying to do with the 
> mode switching between virtual terminals.  The callback will definately 
> be neccessarry to tell the driver to save any driver specific data that 
> I'm not already saving (ie anything that's not defined in fb.h).

I don't think we need to "save" anything, there is no way I want any
knowledge of fbcon-specific stuff to go back into fbdev's, it was
hard enough to split these properly (that's a good thing James did).

I think we just need to instruct the fbdev to restore it's mode via
a set_var with an activate flag FB_ACTIVATE_FORCE, that bypass any
test inside the driver about the mode changing from the current info-var,
that is basically forcing it to re-apply it's current var. Most drivers
will also reset the accel engine properly if any when doing so.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
