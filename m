From: John Zielinski <grim@undead.cc>
Subject: Re: Restoring Screen when coming back	from	KD_GRAPHICS
Date: Wed, 24 Dec 2003 20:22:51 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FEA3BEB.2060608@undead.cc>
References: <3FC4603C.2000702@undead.cc> <1072254378.739.65.camel@gaston>	 <3FEA0E0D.3030001@undead.cc> <1072306057.15476.19.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZKDU-00056v-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 17:23:08 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZKDT-0002Rp-UW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 17:23:08 -0800
In-Reply-To: <1072306057.15476.19.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

Benjamin Herrenschmidt wrote:

>I don't think we need to "save" anything, there is no way I want any
>knowledge of fbcon-specific stuff to go back into fbdev's, it was
>hard enough to split these properly (that's a good thing James did).
>  
>

I was using "save" as in "don't overwrite".    The fb_var_screeninfo and 
fb_cmap structures are the two main ones.  If we have seperate ones for 
each vt and one for when a graphics app then the contents of each is 
"saved" and can be restored by fbcon very easily.

But if a fbdev can't recreate it's state from the information that fbcon 
provides (var, cmap, etc) because it has some internal driver or hw 
state info then there needs to be a way for fbcon to tell the fbdev "put 
your internal state in this buffer" so it can be remembered when things 
get restored later.  That way the fbdev doesn't have to worry about any 
of the high level stuff.  It just gets the contents of that buffer back 
when things get restored.   Fbcon can ask the driver on startup as to 
how many bytes of buffer space does it need for it's save area and if 
the fbdev doesn't need any (it can totally restore it's state using the 
normal set_var mechanism) it can just say zero.

>I think we just need to instruct the fbdev to restore it's mode via
>a set_var with an activate flag FB_ACTIVATE_FORCE, that bypass any
>test inside the driver about the mode changing from the current info-var,
>that is basically forcing it to re-apply it's current var. Most drivers
>will also reset the accel engine properly if any when doing so.
>  
>

Can all the fbdevs restore everything with just that information?   If 
so then we don't have to worry about the internal state save buffer 
stuff above.

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
