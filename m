From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Question] sumbit VIAFB driver
Date: Wed, 7 May 2008 13:28:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805071327060.13757@anakin>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6751F@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jthov-0000TJ-Cq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 04:28:25 -0700
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jthos-0001Qv-NW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 May 2008 04:28:25 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6751F@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, 7 May 2008, JosephChan@via.com.tw wrote:
> I've tried to split the patch into parts and sent to linux-fbdev-devel.
> But I got returned mail, it seems to be my patch was banned by
> linux-fbdev-devel.

Really? I don't see them being stuck in mailman, and I did receive them
through the list.
Can you please forward me the error email by personal email?

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> Sent: Wednesday, May 07, 2008 2:45 AM
> To: Geert Uytterhoeven
> Cc: Joseph Chan; linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [Linux-fbdev-devel] [Question] sumbit VIAFB driver
> 
> On Mon, 5 May 2008 20:37:22 +0200 (CEST) Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> 
> > 	Hi Joseph,
> > 
> > On Mon, 5 May 2008, JosephChan@via.com.tw wrote:
> > > We would like to sumbit VIA's framebuffer device driver into kernel 
> > > and I've done the patch file.
> > > But the patch seems too large to send (2 files exceed 2700 lines, 
> > > other
> > > 3 more files exceed 1000 lines), it's appreciated to guide me to 
> > > separate those signle file into multiple parts?
> > 
> > For review, you can split the patch in multiple parts (one for each 
> > big
> > change) and send them separately.
> > 
> > For submission (after integrating the review comments!), you can send 
> > it as one big patch to Andrew Morton, I think. Andrew?
> > 
> 
> Sure.  Just copy me on the split-up patches and remind me to join them
> all together for upstream merging.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
