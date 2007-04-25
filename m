From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 27/41] fbdev: Advertise
	limitation	of drawing engine
Date: Thu, 26 Apr 2007 07:10:24 +0800
Message-ID: <1177542624.4655.6.camel@daplas>
References: <462EFBB4.1080900@gmail.com>
	<20070425212327.GA7956@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgqdF-0008NR-3N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 16:10:41 -0700
Received: from nz-out-0506.google.com ([64.233.162.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgqdE-0000ZG-If
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 16:10:41 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1209988nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 16:10:40 -0700 (PDT)
In-Reply-To: <20070425212327.GA7956@localhost.localdomain>
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
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2007-04-25 at 23:23 +0200, Ondrej Zajicek wrote:
> On Wed, Apr 25, 2007 at 02:56:52PM +0800, Antonino A. Daplas wrote:
> > A few drivers are not capable of blitting rectangles of any dimension.
> > vga16fb can only blit 8-pixel wide rectangles, while s3fb (in tileblitting
> > mode) can only blit 8x16 rectangles.
> 
> I have two new drivers which use tileblit. Where i can get diff of your
> tree (not splitted to fifty parts and mixed with mail) to be able to

No public tree, and I don't have CVS access to fbdev-devel.

> update that drivers to new interfaces? Or should i send it in current
> form (againts 2.6.21-rc7)?

You can submit it based on Linus's tree.  And then we'll just create
another patch on top of that (once akpm merges my changes to his tree).
This way, if your driver gets to Linus's tree prior to my changes, your
driver will stay working.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
