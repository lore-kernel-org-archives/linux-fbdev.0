From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [BK FBDEV] A few more updates.
Date: 26 Mar 2003 17:53:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048672391.1025.28.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18y7pn-0008D9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 02:08:39 -0800
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
> > 5.  softcursor should not concern itself with memory bookkeeping, and
> > must be able to function with just the parameter passed to it in order
> > to keep it as simple as possible.  These tasks are moved to
> > accel_cursor.
> 
> We do if we make a ioctl for cursors. I'm trying to avoid reprogramming 
> the hardware over and over again if the properties of the cursor don't 
> change. The idea is similar to passing in var and comparing it to the var 
> in struct fb_info. 

Of course, that's what the fb_cursor.set field is for, and drivers have
the option of ignoring or not ignoring bits in this field. Whoever calls
fb_cursor has the responsibility of setting any cursor state changes. 

Unlike fb_set_var(), cursor states change very frequently (ie, each
blink or movement of the cursor are considered state changes), so just
forego the memcmp() and call fb_cursor unconditionally.  Let the
low-level method sort it out by checking bits in fb_cursor.set.

But what I really meant was since accel_cursor() is already doing the
memory bookkeeping, why let softcursor do it too?  We can all do these
in the upper layer.

This is especially true if you are planning to expose cursor handling to
user space.  For example, softcursor refers to fields in
fb_info.fb_cursor, but this is a structure private to the driver. 
Worse, it refers to both the passed fb_cursor structure and the
fb_info.fb_cursor structure. Why not just make softcursor refer entirely
to the passed fb_cursor structure?  It's saner, less confusing and less
prone to bugs.  

Tony
 




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
