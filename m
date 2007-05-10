From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Blitter speed tests (was: smart
	blitter	usage for scrolling)
Date: Fri, 11 May 2007 04:36:29 +0800
Message-ID: <1178829389.4662.13.camel@daplas>
References: <46434cdea1ce4@wp.pl>  <1178828675.4662.4.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmFNM-00027g-4Y for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 13:36:36 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HmFNL-00069F-Op
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 May 2007 13:36:36 -0700
Received: by py-out-1112.google.com with SMTP id a29so599823pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 May 2007 13:36:35 -0700 (PDT)
In-Reply-To: <1178828675.4662.4.camel@daplas>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2007-05-11 at 04:24 +0800, Antonino A. Daplas wrote:
> On Thu, 2007-05-10 at 18:48 +0200, Krzysztof Helt wrote:
> > Hi,
> > 
> If you do, it might even be wise to change the default from
> SCROLL_REDRAW to SCROLL_MOVE...?
> 
Come to think of it we'll probably just let the driver choose the scroll
method.

SCROLL_MOVE is faster at lower bit depths because the bitmap preparation
for the putcs method slows down SCROLL_REDRAW.  But as the bit depth
goes up, the amount of data moved by bmove goes up but at a higher rate
than the data moved by putcs. Thus SCROLL_MOVE loses its edge at 16-32
bpp. At what point these lines intersect we really don't know as it
depends on the hardware and the driver's imageblit/copyarea
implementation.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
