From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Feature Freeze?
Date: 06 Mar 2003 09:18:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046913402.1206.177.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051820470.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qk0A-00077i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 17:16:50 -0800
In-Reply-To: <Pine.LNX.4.44.0303051820470.27760-100000@phoenix.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 02:29, James Simmons wrote:
> 
> > 1. Text mode support?
> 
> We should remove it. Fbcon is to much bloat for text mode hardware. The 
> only driver that does support a text mode matrox. Sparcs do not support 
> text mode except for promcon. The issue was was a misunderstanding on teh 
> flexiablity of imageblit. The name image blit stirs up this idea of the 
> function has to be a place a image in buffer and send it on it way. This 
> is not the case. Take a look at cg6.c. Fancy tricks are still possible. 

If you are to add tileblitting, text mode will be inherently supported.

>  
> > 2. console resizing using fbset (besides stty)?
> 
> Fbcon needs alot of work on this. In theory it shoudl be smart enought to 
> handle the small details. 
> 

Any ideas on how to do this?  I have one in my other mail.

> > 3. support for unloading of fbcon if modular?
> 
> It can be done. I used fbcon modular with MDA text mode. I can test the 
> fbcon driver. The issue is if we have more than one vga card whcih vga to 
> graphics card mapping. 
>  

See my other mail for a proposal on this.

> > 4. driver specified placement of buffers - for putcs method?
> 
> Working on this. I think it is possible to merge the tileblit stuff with 
> the new buffer code.

I have to check your newest patch.

> 
> > 5. flexible logo placement/overlayed logo?
> 
> Not so important. More important is fixing fbcon to work with the logo 
> code. You can't compile it right now.
> 
> > 6. generic console display rotation?
> 
> Not so important right now. I removed the poll stuff. using signals is 
> better.

Yes, I think so too.

>  
> > 7. Anything else?
> 
> The cursor code needs cleanup and documentation. 

I already have stuff in my tree where fbcon allocates cursor resources
per device.  So there's no more static declarations in accel_cursor (and
accel_putcs).  I can submit that if you want.

I also added some locking code for accel_cursor, as well as accel_putcs,
just in case thread-safety is indeed an issue.

I'm also starting to clean up fbcon_cursor and the vbl_handler. 
Ideally, they should also be allocated per device so multi-seat can be
made possible.  It's low-priority right now.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
