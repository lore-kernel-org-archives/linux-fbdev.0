From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/4] fbdev: uvesafb
Date: Thu, 12 Jul 2007 16:12:01 +0800
Message-ID: <1184227922.4504.22.camel@daplas>
References: <20070623104920.GA12623@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8tmV-0006v8-2d for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:12:12 -0700
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8tmU-0003ni-Ij
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:12:10 -0700
Received: by nz-out-0506.google.com with SMTP id f1so144087nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 01:12:09 -0700 (PDT)
In-Reply-To: <20070623104920.GA12623@spock.one.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Sat, 2007-06-23 at 12:49 +0200, Michal Januszewski wrote:

My apologies for the delayed response. I had problems with my ISP.
 
> uvesafb is a generic driver for VBE2+ compliant video cards; an enhanced
> version of vesafb and a direct successor of vesafb-tng [1].
> 
> uvesafb uses a userspace helper application (v86d, [2]) to run the x86
> Video BIOS code.  This makes it possible to include in uvesafb all the
> standard features (refresh rate control, video mode changes etc) that
> are missing from vesafb without resorting to ugly hacks such as the ones
> used in [1].  The current implementation of v86d can use either LRMI or
> x86emu to run the BIOS code and supports both x86 and x86_64.
> 
> [1] http://dev.gentoo.org/~spock/projects/vesafb-tng/
> [2] http://dev.gentoo.org/~spock/projects/uvesafb/
> 

This is cool, I had a similar project before (which did work) but
abandoned it. In fact, it need not be restricted to vbe, as long as the
userspace daemon can interpret VESA.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
