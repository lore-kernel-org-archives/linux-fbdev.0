From: Stefan Reinauer <stepan@suse.de>
Subject: Re: Re: atyfb in 2.5.51
Date: Sun, 15 Dec 2002 12:45:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021215124528.A5347@suse.de>
References: <1039596149.24691.2.camel@rth.ninka.net> <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from ns.suse.de ([213.95.15.193] helo=Cantor.suse.de)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18NXDA-000158-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Dec 2002 03:45:32 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Wed, Dec 11, 2002 at 07:16:04AM -0800
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

* James Simmons <jsimmons@infradead.org> [021211 16:16]:
> 
> > I've always stated that the whole fbdev model was flawed, it makes
> > basic assumptions about how a video card's memory and registers are
> > accessed (ie. the programming model) and many popular cards absolutely
> > do not fit into that model.
> 
> I agree that the design of the /dev/fbX interface is not the best.
> Unfortunely we are stuck with it. Changing it would break userland apps.

One thing I was wondering: Is there a proper way to make sure that 
acceses to the framebuffer end up only on one specific virtual console?
I have an application that runs on one virtual console, but when
switching I do not want the screen to be trashed by writing just into
the framebuffer memory. My solution was to check whether the current
console is the console the application started on, but this looks a
bit bloated to me and I had some weird effects when switching to X and
back - like one frame still got painted into graphics memory while X was
already shown.
  
  Any ideas?
  Stefan

-- 
Laissez Faire Economics is the theory that if each acts like a vulture,
all will end as doves.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
