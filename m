From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Mirrored Display?
Date: 29 Dec 2002 23:59:38 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041175846.1210.10.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212201947290.6471-100000@phoenix.infradead.org>
	<200212231204.39625.kaufmann@sohard.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Sg3l-000071-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Sun, 29 Dec 2002 08:13:06 -0800
In-Reply-To: <200212231204.39625.kaufmann@sohard.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Michael Kaufmann <kaufmann@sohard.de>
Cc: Linux-fbdev-devel@lists.sourceforge.net

On Mon, 2002-12-23 at 21:04, Michael Kaufmann wrote:
> Antonino has also answered to my question. And he said that there is nothing 
> i can do, because user apps will directly acces the framebuffer via read/write 
> or nmap. I can only patch the console and the show _logo to write the data 
> mirrored to the videobuffer (a lot of work).
> So my user apps (like nanoX or directfb/GTK+) must know about the mirrored 
> display and should write the picturedata mirrored in the framebuffer. 
> 
> I'm know a litte bit amazed about a rotation feature in next versions. Does 
> this mean, that the buffer where user apps (or also the console) are writing 
> there picture data is not directly the videobuffer anymore? Or how does this 
> rotation feature works?
I think the rotation hooks are console specific.  

> 
> I think it would be a good feature to have 'something' between the framebuffer 
> and the physical videobuffer to be able to manipulate the picture data (like 
That is the job of fb libraries.  You can use X (which already has
support for rotation, so mirroring should be easy to add), or modify
DirectFB.

> rotation, mirroring, etc.). But i don't know how this peace of software 
> should detect, changed data in the 'framebuffer' to e.g. mirror in the 
> videobuffer? Writing the whole buffers from time to time whould be a very
> bad solution (performance).
You can probably implement something similar to a shadow framebuffer. 
You expose this instead of the actual framebuffer (fix->smem_start, and
info->screen_base), then just refresh the contents of the actual
framebuffer, say during vsync.  You will have to set up a vsync
irq_handler or something similar.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
