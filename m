From: Antonino Daplas <adaplas@pol.net>
Subject: Re: how to rotate 90 the LCD image
Date: 10 Mar 2003 10:06:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047261897.1266.27.camel@localhost.localdomain>
References: <1047202665.2653.irene7@mail2000.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sCj2-0003sx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Mar 2003 18:09:12 -0800
In-Reply-To: <1047202665.2653.irene7@mail2000.com.tw>
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
To: irene7@mail2000.com.tw
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-03-09 at 17:37, irene7 wrote:
> 
>  HI~ 
> 
>     i am an newbie. and i have a trouble :
>     my LCD driver is working fine , but the only problem is the LCD image is rotate 90.
>     what should i modified the driver to rotate it back? 

Hmm, a lot of LCD hardware have this sort of problem.  If you do not
have a hardware option to change how the data is to be displayed (such
as rotate 90 degrees the other way), you can do at least two things:

1.  have your own fbcon-cfb*.c functions that draws, clears and moves
pixels from top->bottom, right->left (90 degrees CW) or bottom->top,
left->right (90 degrees CCW).  You may also want to pre-rotate
display->fontdata in your xxxfb_setup routine, so you don't degrade
performance. You also need to modify the fbcon_show_logo in fbcon.c to
do the same thing.  The advantage of this method is you're going to have
a fairly efficient framebuffer console, the disadvantage is user
applications will not work.

2.  The second method is to allocate a virtual framebuffer.  Then on a
periodic basis, you transfer the data in the virtual framebuffer to the
actual framebuffer, doing the rotating on the fly.  The advantage of
this method is user applications should work, the disadvantage is it is
not the most efficient method.

You can look at: 

ftp://ssv-embedded.de/ssv/products/trm916/sample/x86/linux/fbdev

(authored by Henry)

for a template on how to implement #2.  You still have to implement the
rotation yourself.  If you have questions rotating the data, let me
know.


Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
