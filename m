From: Otto Solares <solca@guug.org>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Fri, 26 Sep 2003 11:43:45 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030926174345.GA16729@guug.org>
References: <20030926023617.GD9615@guug.org> <20030926025744.80379.qmail@web14905.mail.yahoo.com> <20030926083946.GA14350@guug.org> <20030926171144.GA1380@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2wex-0004zj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 10:45:39 -0700
Received: from panoramix.vasoftware.com
	([198.186.202.147] helo=externalmx.vasoftware.com ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2wex-00069i-1H
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Sep 2003 10:45:39 -0700
Received: from guug.org ([168.234.203.30]:43786 helo=guug.galileo.edu)
	by externalmx.vasoftware.com with esmtp (Exim 4.22 #1 (Debian))
	id 1A2weo-0004pT-Q0
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 10:45:32 -0700
Content-Disposition: inline
In-Reply-To: <20030926171144.GA1380@dreamland.darkstar.lan>
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
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Sep 26, 2003 at 07:11:44PM +0200, Kronos wrote:
> Il Fri, Sep 26, 2003 at 02:39:46AM -0600, Otto Solares ha scritto: 
> > > To see the diffs from test5 to present:
> > > bk revtool and find last revision number, probably something like 1.1303.
> > > bk export -tpatch -rv2.6.0-test2,1.1303 -h >../patch
> > > 
> > > There will be a lot of diffs, Linus is about ready to tag test6.
> > > 
> > > To look at a specific file:
> > > bk revtool file-name
> > > 
> > > Now that you have a bk tree you don't have to wait for a tagged release. Just
> > > pull the changes fron Linus' tree when you want to update.
> > 
> > Probably am doing something wrong because there are no
> > sane files, just s.*.{c,h} binaries in SCCS subdir so i
> > can't treat it normally:
> > 
> > solca@appsrv:~/devel/radeon$ ls drivers/video/aty/SCCS/
> > s.aty128fb.c    s.atyfb.h         s.mach64_ct.c      s.mach64_gx.c  s.radeon_base.c  s.radeon_i2c.c      s.radeon_pm.c
> > s.atyfb_base.c  s.mach64_accel.c  s.mach64_cursor.c  s.Makefile     s.radeonfb.h     s.radeon_monitor.c  s.xlinit.c
> 
> You must checkout files (make will do it by itself):
> 
> bk get drivers/video/foo.c (readonly)
> bk edit drivers/video/foo.c (rw)
> bk your_favourite_editor drivers/video/foo.c (rw and opens your editor)
> 
> Also:
> 
> bk help commands

ok, i am understanding now, thank you.

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
