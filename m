From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Portrait display mode
Date: 16 Sep 2002 11:07:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1032145647.568.29.camel@daplas>
References: <3D7E59B0.5FC023D3@bluewin.ch> <1031696622.548.13.camel@daplas>
	<3D7FA51A.EC5A6FD5@bluewin.ch> <1031850411.1810.0.camel@daplas> 
	<3D84D045.404EA715@bluewin.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17qmFW-0004xa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Sep 2002 20:08:34 -0700
In-Reply-To: <3D84D045.404EA715@bluewin.ch>
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
To: otto.wyss@bluewin.ch
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2002-09-16 at 02:24, Otto Wyss wrote:
> Sorry if I'm looking "heavy of understandig" (translated from German) but does
> this mean that some parts are written with and some without rotation? Or does it
> mean in console mode everything is rotated if the used driver supports it? Vise
> versa X?
> 
Diagramatically, the fb-based console looks something like this:

Console -> fbcon -> fbdev -> graphics-capable hardware

Rotation is done at the fbcon layer. fbdev on the other hand is just an
abstraction of the underlying graphics hardware.  It is fbdev that is
actually used by fb-based applications, such as Xfree86.  fbdev does not
know about display orientation, but Xfbdev does, and so can fbcon.
   
> What does a rotation unter X bring as long as the console doesn't? Okay for
This is actually what triggered me to submit the patches, it is quite
disconcerting to switch from a rotated Xfree86 display to an upright
console.

> anyone only using X the Xfbdev solution might be okay, but when the fb-diver
> supports rotation Xfbdev should use this.
See above.  fbdev does not know about rotation, nor does it need to.

Tony



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
