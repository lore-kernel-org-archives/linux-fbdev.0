From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Tue, 11 Mar 2003 16:06:13 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111558420.23668-100000@phoenix.infradead.org>
References: <1046913402.1206.177.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18smHN-0000lB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 08:07:01 -0800
In-Reply-To: <1046913402.1206.177.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> If you are to add tileblitting, text mode will be inherently supported.

If I do all three tileblitting functions. Personally I think we just need 
tileblit. 
 
> > > 2. console resizing using fbset (besides stty)?
> > 
> > Fbcon needs alot of work on this. In theory it shoudl be smart enought to 
> > handle the small details. 
> > 
> 
> Any ideas on how to do this?  I have one in my other mail.

I think it is coming together quite well this last week.

> > > 3. support for unloading of fbcon if modular?
> > 
> > It can be done. I used fbcon modular with MDA text mode. I can test the 
> > fbcon driver. The issue is if we have more than one vga card whcih vga to 
> > graphics card mapping. 
> >  
> 
> See my other mail for a proposal on this.

I will give it a try.

> > > 4. driver specified placement of buffers - for putcs method?
> > 
> > Working on this. I think it is possible to merge the tileblit stuff with 
> > the new buffer code.
> 
> I have to check your newest patch.

Its in the BK tree. 

> > Not so important. More important is fixing fbcon to work with the logo 
> > code. You can't compile it right now.

It works now. It doesn't compile tho if you disable the logo code and havd 
fbcon set.

> > > 6. generic console display rotation?
> > 
> > Not so important right now. I removed the poll stuff. using signals is 
> > better.
> 
> Yes, I think so too.

Actaully the way the pixmap code came out I think we can implement the 
rotation stuff via the pixmap hooks.

> I already have stuff in my tree where fbcon allocates cursor resources
> per device.  So there's no more static declarations in accel_cursor (and
> accel_putcs).  I can submit that if you want.

I seen it. I added parts. I'm going to use the upper console layer to get 
ride of the static variables for the cursor stuff.

> I also added some locking code for accel_cursor, as well as accel_putcs,
> just in case thread-safety is indeed an issue.

Added to BK tree already.

> I'm also starting to clean up fbcon_cursor and the vbl_handler. 
> Ideally, they should also be allocated per device so multi-seat can be
> made possible.  It's low-priority right now.

I seen that. The VBL handlers should be removed from fbcon.c and placed in
there respected drivers. I think that each driver should register its own 
VBL handler. Then inside the handler update the cursor. This way all we 
need is a timer for each display that blinks the cursor. 



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
