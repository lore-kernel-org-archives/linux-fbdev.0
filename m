From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK FBDEV] A few more updates.
Date: 26 Mar 2003 18:20:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048673964.1025.37.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18y8FF-000336-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 02:34:57 -0800
In-Reply-To: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2003-03-26 at 13:34, James Simmons wrote:
> 
> > 3.  BTW, there are too many kmalloc's/kfree's in accel_cursor() and
> > softcursor().  Personally, I would rather have 2 64-byte buffers for the
> > mask and the data in the info->cursor structure than allocating/freeing
> > memory each time the cursor flashes.  However, if you prefer doing it
> > this way, the patch also includes changes so kmallocs are only done when
> > necessary.  Still, accel_cursor() has unnecessary work being done, such
> > as always creating the mask bitmap, when a simple flag to monitor cursor
> > shape changes could prevent all this.
> 
> I agree. The problem is the upper layer of the console system is to brain 
> dead. Its either erase the cursor or redraw it again. There is no way to 
> just say cursor just moved. There is a CM_MOVE but the upper layer doesn't 
> even use it :-( If you look at vgacon and friends you will see they 
> recreate the cursor every time the cursor blinks. Yes even vgacon.c does 
> this. It is stupid and brain dead but that is the way the upper layers of 
> the console work. The correct solution would be to use actually use 
> CM_MOVE in the upper layers.

Even so, (and I don't really fault the console cursor as it only needs
to show, hide and move the cursor), accel_cursor() can easily monitor
shape changes.  We can use a bitfield somewhere in fb_cursor(perhaps the
high 8 bits of info->fb_cursor.set?) to "remember" the current cursor
shape.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
