From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: logos work/apply when?
Date: Fri, 13 Jul 2007 11:06:29 -0700
Message-ID: <20070713110629.d6eccbd4.rdunlap@xenotime.net>
References: <20070712130822.a8269fe0.rdunlap@xenotime.net>
	<1184284251.4566.3.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9PTR-0007dG-O9 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 11:02:40 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I9PTQ-00052a-5k
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 11:02:37 -0700
Received: from midway.site ([71.117.236.25]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 13 Jul 2007 11:02:30 -0700
In-Reply-To: <1184284251.4566.3.camel@daplas>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "Antonino A. Daplas" <adaplas@gmail.com>

On Fri, 13 Jul 2007 07:50:51 +0800 Antonino A. Daplas wrote:

> On Thu, 2007-07-12 at 13:08 -0700, Randy Dunlap wrote: 
> > Hi,
> > 
> > Is there some kernel config or video config (possibly set at boot time
> > via vga=xyz or video=wxy) where one or more of the logos is not
> > applicable?  or the other way:  are there certain kernel or video
> > configs where only certain logos are applicable?
> > 
> > 
> > I've tested vesafb with LOGO_LINUX_VGA16 but I can't see the logo.
> > I do see an empty space for it at the top of the screen area, however.
> > (booting with vga=0x317 in /etc/lilo.conf file)
> > 
> > When I use LOGO_LINUX_CLUT224 instead, I do see the logo.
> > 
> > or when I use FB_VGA16 instead of vesafb and also use LOGO_LINUX_VGA16,
> > I can see the logo.
> > 
> > I'm just trying to understand when/why I should expect (or not expect)
> > to see a logo (if it is enabled).
> 
> It's a bug. And I've been wanting to fix that for some time. Logo's with
> depths <= the fb depth should still be shown. The problem is that VGA16
> and monochrome logos do not contain color information, so we have to use
> the console palette (and not create a new one). Try the attached patch.

That works in my testing.  Thanks.

So when all 3 of these are enabled:
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
is the one with most depth that is supported by the fb driver used?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
