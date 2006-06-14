From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Problems with rotated Logos
Date: Wed, 14 Jun 2006 19:56:41 +0100
Message-ID: <1150311401.9240.9.camel@localhost.localdomain>
References: <1150279997.27375.15.camel@localhost.localdomain>
	<4490091B.4090900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqaXv-0006sb-OU for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 11:56:55 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqaXt-0004p7-TK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 11:56:55 -0700
In-Reply-To: <4490091B.4090900@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

On Wed, 2006-06-14 at 21:03 +0800, Antonino A. Daplas wrote:
> Richard Purdie wrote:
> > Hi,
> > 
> > I've been experimenting with logos on the Sharp Zaurus C3000 which has a
> > 480x640 framebuffer which is rotated clockwise to give 640x480. I'm
> > using a 2.6.16 based kernel.
> > 
> > If I use the standard Linux logo (clut224), all is well. I added a
> > 640x185 logo and this locked the machine up when booting. Space was
> > cleared at the top of the console for the logo and some boot messages
> > appeared beneath it. Also, 639x185 gave the same result.
> 
> Yes, it's a bug. Also present in CCW. Try this patch.

The patch helps in that the 640x185 image no longer locks the system up
and it displays something, thanks! The image is corrupted however.
Rather than trying to describe it:

http://www.rpsys.net/openzaurus/temp/logo-corrupt.jpg

(I'm refraining from comment about the logo itself ;-)

As well as the wrapping, the blue colour to the left is also corruption,
and marks the edge of the screen.

I suspect the rotation function has a bug...

Cheers,

Richard
