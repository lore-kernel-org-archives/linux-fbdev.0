From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Sat, 13 Sep 2003 00:47:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030912224717.GB29997@dreamland.darkstar.lan>
References: <20030909204544.GA16724@dreamland.darkstar.lan> <Pine.LNX.4.44.0309121847070.5017-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xwib-0002Rb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:48:45 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xwib-0008EM-67
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:48:45 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121847070.5017-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Fri, Sep 12, 2003 at 06:48:30PM +0100, James Simmons ha scritto: 
> > > > Most of work consists in changing "." into "->" ;)
> > > > Changes to fbmem.c are very similar to Greg KH's patch:
> > > 
> > > You probably want to fix more drivers , that would help getting
> > > it merged.
> > 
> > I sent radeonfb as an example. I've already fixed chipsfb.c, cyber2000fb.c,
> > hgafb.c, imsttfb.c, neofb.c, tdfxfb.c, tridentfb.c, vesafb.c and i810.
> 
> Patches welcomed. I already have the class_device stuff in my tree. Take a 
> look at the fbdev BK. Please make a patch aginat that tree.

I've just finished ;) I want to double-check everything, I'll send
patches ASAP.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Let me make your mind, leave yourself behind
Be not afraid


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
