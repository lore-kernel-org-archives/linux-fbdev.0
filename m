From: Antonino Daplas <adaplas@pol.net>
Subject: Re: 2.5.60/atyfb
Date: 17 Feb 2003 19:34:02 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045481560.1324.16.camel@localhost.localdomain>
References: <20030215151128.GA478@schottelius.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kjX0-0000o4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 03:33:54 -0800
In-Reply-To: <20030215151128.GA478@schottelius.org>
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
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-02-15 at 23:11, Nico Schottelius wrote:
> Hello!
> 
> I retried using atyfb with 2.5.60:
> Afterloading atyfb the only thing left is the cursor.
> i don't see anything else anymore..i see the cursor moving, but that's all.
> btw, i am using a laptop (means lcd)...
> 
Strange. The good news is, if you see the cursor, it means the drawing
functions is working since atyfb uses soft_cursor() which uses
xxxfb_imageblit (the same function to draw the characters). That is
perhaps fixable.

> can somebody tell me whether playing around with fbset could make things
> working?
> 

You cannot use fbset anymore to change the window size, you have to use
stty cols <value> rows <value>.  That implies the driver can set the
video mode independently from fbset.  If it doesn't, you can use
something like this:

fbset 640x480-60 && stty cols 80 rows 30

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
