From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Restoring Screen when coming
	back	from	KD_GRAPHICS
Date: Thu, 25 Dec 2003 21:37:41 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1072348661.15461.31.camel@gaston>
References: <3FC4603C.2000702@undead.cc> <1072254378.739.65.camel@gaston>
	 <3FEA0E0D.3030001@undead.cc> <1072306057.15476.19.camel@gaston>
	 <3FEA3BEB.2060608@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZSsm-00013w-Be
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 02:38:20 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AZSsl-00024k-NW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Dec 2003 02:38:20 -0800
In-Reply-To: <3FEA3BEB.2060608@undead.cc>
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


> I was using "save" as in "don't overwrite".    The fb_var_screeninfo and 
> fb_cmap structures are the two main ones.  If we have seperate ones for 
> each vt and one for when a graphics app then the contents of each is 
> "saved" and can be restored by fbcon very easily.

Ok.

> But if a fbdev can't recreate it's state from the information that fbcon 
> provides (var, cmap, etc) because it has some internal driver or hw 
> state info then there needs to be a way for fbcon to tell the fbdev "put 
> your internal state in this buffer" so it can be remembered when things 
> get restored later.  That way the fbdev doesn't have to worry about any 
> of the high level stuff.  It just gets the contents of that buffer back 
> when things get restored.   Fbcon can ask the driver on startup as to 
> how many bytes of buffer space does it need for it's save area and if 
> the fbdev doesn't need any (it can totally restore it's state using the 
> normal set_var mechanism) it can just say zero.

I think we don't need (nor want) to go down that path. And I fail to
see what state info would matter anyway.

> >I think we just need to instruct the fbdev to restore it's mode via
> >a set_var with an activate flag FB_ACTIVATE_FORCE, that bypass any
> >test inside the driver about the mode changing from the current info-var,
> >that is basically forcing it to re-apply it's current var. Most drivers
> >will also reset the accel engine properly if any when doing so.
> >  
> >
> 
> Can all the fbdevs restore everything with just that information?   If 
> so then we don't have to worry about the internal state save buffer 
> stuff above.

The fbdev's can restore what they need. What I mean is they can restore the
whole state needed for the mode, the palette and their own accel ops to
behave properly. That's all they have to care about. If a gfx app need
more engine state, it's up to this app to save/restore it.

ben.
 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
