From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: framebuffer_{alloc,release}
Date: Wed, 17 Sep 2003 10:52:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030917085257.GA2613@iliana>
References: <20030916192753.GB14731@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zWBs-0001wL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 23:53:28 -0700
Received: from smtp6.wanadoo.fr ([193.252.22.28] helo=mwinf0304.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zWBs-0004mr-4X
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 Sep 2003 23:53:28 -0700
Content-Disposition: inline
In-Reply-To: <20030916192753.GB14731@dreamland.darkstar.lan>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, Russell King <rmk@arm.linux.org.uk>

On Tue, Sep 16, 2003 at 09:27:53PM +0200, Kronos wrote:
> Hi,
> this is a new version of the new framebuffer_alloc API. It is based on the
> feedback I had (thanks to Russel King).
> 
> framebuffer_alloc  is unchanged,  driver  specific  release callback  is
> gone. struct fb_info won't go away until we drop the refcount with a new
> function. I think that framebuffer_free can  be misleading as it doesn't
> free anything, so I named it framebuffer_release.

Just a quick question about this. I didn't really follow this thread,
but it seem to me that you are implementing a sort of reference counting
memory allocation, or something such.

If so, it has been proven that exploratory garbage collection is more
effective than reference-sounting in normal programming, even in
imperative languages like C. I don't know if these results will apply as
well in this case which handles framebuffer memory (or perhaps also the
texture memory the DRI framework uses ?). I think the disadvantage of
not being able to handle circular structure is of no moment, as i doubt
circular structures will be implemtented in framebuffer memory.

Anyway have you at least looked a bit at the possibility of using an
exploratory garbage collection in this case, as well as designing a
framework which can be shared between not only the fbdevs but also the
other framebuffer using stuff (dri, X, etc.).

Disclaimer: i am by no means an expert of memory allocation or garbage
collection, altough my main programming language is ocaml, so what i say
hear may well be nonsense or something. Please excuse me if this is the
case.

Friendly,

Sven Luther



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
