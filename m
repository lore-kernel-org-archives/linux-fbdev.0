From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Portrait display mode
Date: 13 Sep 2002 01:36:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031852214.1810.3.camel@daplas>
References: <3D7E59B0.5FC023D3@bluewin.ch> <1031696622.548.13.camel@daplas>
	<3D7FA51A.EC5A6FD5@bluewin.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17pYqb-0002Mg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Sep 2002 11:37:49 -0700
Received: from AP-202-70-99-29.compass.com.ph (AP-202-70-99-29.compass.com.ph [202.70.99.29])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id CAA58303
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Sep 2002 02:37:39 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <3D7FA51A.EC5A6FD5@bluewin.ch>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2002-09-12 at 04:18, Otto Wyss wrote: 
> > I posted a patch under the thread titled "Console Rotation" 2 days ago.
> > It should support rotation in 3 additional directions (90, 180 and 270
> > degrees).  As far as fb-based apps, they have to do the rotation on
> 
> I should have looked more closely at the messages, "Console ..." misguided me.
> 
> > their own.  XFbdev in 4.2.0 already does that.
> > 
> When the fb drivers support rotation, XFbdev doesn't need rotation anymore.
It really is just console rotation, all other fb-based apps would still
display in the standard "upright" position unless specifically written
for display rotation, such as Xfbdev. 

> 
> > Doing this in 2.4 will be trickier because of absence of support for
> > drawing primitives.  (The i810fb driver had console rotation for half a
> > year now, though)
> > 
> Does this mean I have to use 2.5 to get rotation?
I'm not sure if the patch I submitted will even be accepted.  My point
is that it's easier to do this in the 2.5 fb framework than in 2.2-2.4. 
But you can already use Xfbdev in 2.4 to rotate the display.  

> 
> > If you are interested, try the patches (apply them in the order I
> > mentioned).  http://i810fb.sourceforge.net/fb_rotate.tar.gz
> > 
> I'm currently using "aty128fb" but may be able to switch to "matroxfb". I'm also
> considering buying card with an DVI plug (hopefully without fan :-( )
> 
It depends if the driver maintainers will support the drawing
primitives.  Some may refuse not to, and that is understandable. 

Tony 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
