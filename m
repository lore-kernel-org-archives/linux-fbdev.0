From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: framebuffer_{alloc,release}
Date: Wed, 17 Sep 2003 17:47:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030917154735.GA3615@dreamland.darkstar.lan>
References: <20030916192753.GB14731@dreamland.darkstar.lan> <20030917085257.GA2613@iliana>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zeWz-0001SH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 08:47:49 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zeWy-0000aJ-6q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Sep 2003 08:47:48 -0700
Content-Disposition: inline
In-Reply-To: <20030917085257.GA2613@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Wed, Sep 17, 2003 at 10:52:57AM +0200, Sven Luther ha scritto: 
> On Tue, Sep 16, 2003 at 09:27:53PM +0200, Kronos wrote:
> > Hi,
> > this is a new version of the new framebuffer_alloc API. It is based on the
> > feedback I had (thanks to Russel King).
> > 
> > framebuffer_alloc  is unchanged,  driver  specific  release callback  is
> > gone. struct fb_info won't go away until we drop the refcount with a new
> > function. I think that framebuffer_free can  be misleading as it doesn't
> > free anything, so I named it framebuffer_release.
> 
> Just a quick question about this. I didn't really follow this thread,
> but it seem to me that you are implementing a sort of reference counting
> memory allocation, or something such.

We are talking about controlling  lifetime of framebuffer info structure
(struct fb_info). This  structure contains a description  of framebuffer
(current  mode, timings,  color  map, etc.). We  want  to register  this
structure with the driver core so  that drivers can export whatever they
want using sysfs.

> If so, it has been proven that exploratory garbage collection is more
> effective than reference-sounting in normal programming, even in
> imperative languages like C. I don't know if these results will apply as
> well in this case which handles framebuffer memory (or perhaps also the
> texture memory the DRI framework uses ?).

Framebuffer memory  (ie. the  place where  we draw)  is the  video board
memory,  we just  map it  upon  load and  unmap it  on exit. AFAIK  only
virtual framebuffer uses vmalloc() for its framebuffer memory.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Se il  destino di un uomo  e` annegare, anneghera` anche  in un bicchier
d'acqua.
Proverbio yddish


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
