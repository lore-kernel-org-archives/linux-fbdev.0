From: Andres Salomon <dilinger@queued.net>
Subject: Re: lxfb driver regression
Date: Tue, 13 May 2008 13:50:15 -0400
Message-ID: <20080513135015.4452fb8f@ephemeral>
References: <20080507210836.1eb61b8f@ephemeral>
	<48230694.5010505@LiPPERT-AT.de>
	<20080512185148.104fc4c3@ephemeral>
	<alpine.LFD.1.10.0805130847150.3019@woody.linux-foundation.org>
	<20080513093554.64466981.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvyZc-00021N-S5 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 10:46:00 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvyZc-00062y-1O
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 May 2008 10:46:00 -0700
In-Reply-To: <20080513093554.64466981.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-geode@bombadil.infradead.org, Jens Rottmann <JRottmann@LiPPERT-AT.de>, linux-kernel@vger.kernel.org, jordan.crouse@amd.com, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 13 May 2008 09:35:54 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 13 May 2008 08:48:02 -0700 (PDT) Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> 
> > 
> > 
> > On Mon, 12 May 2008, Andres Salomon wrote:
> > > 
> > > Sorry for the delay, I got around to testing this today.  It works
> > > much better on an XO, so I've ack'd it.
> > 
> > If people expect me to apply that patch, I hope they'll re-send
> > (with acks etc). Otherwise I just expect I'll get it through the
> > normal fbdev queues (which is often Andrew, but shouldn't be).
> > 
> 
> It got confusing.  Turns out that I had a speculative revert patch,
> followed by a new patch with an identical changelog to the first one.
> 
> I folded them together and below is what I presently have against
> mainline, but I have no changelog describing what it fixes.
> 
> Can someone send some text please?
> 

How's this?  Jordan and Jens, please correct me if I'm off.




[PATCH] lxfb: fix regression on OLPC caused by PLL table updates

The following patch caused a regression with OLPC panels:

 commit 3888d4639e78802c4ec1086127124e890461b9e4
    lxfb: extend PLL table to support dotclocks below 25 MHz

    Extends the PLL frequency table of the AMD Geode-LX frame buffer driver to
    make use of the DIV4 bit, thus adding support for dotclocks between 6 and 25
    MHz.  These are needed for small LCDs (e.g.  320x240).  Also inserts some
    intermediate steps between pre-existing frequencies.

The problem was the insertion of intermediate steps into the frequency
table; they would cause the wrong frequency to be matched.  This patch
drops those intermediate frequencies while keeping the sub-25MHz
frequencies.

Signed-off-by: Andres Salomon <dilinger@debian.org>


> ---
> a/drivers/video/geode/lxfb_ops.c~fix-lxfb-extend-pll-table-to-support-dotclocks-below-25-mhz
> +++ a/drivers/video/geode/lxfb_ops.c @@ -63,54 +63,32 @@ static const
> struct { { 0x00014284,  19688 },
>    { 0x00011104,  20400 },
>    { 0x00016363,  23625 },
> -  { 0x00015303,  24380 },
>    { 0x000031AC,  24923 },
>    { 0x0000215D,  25175 },
>    { 0x00001087,  27000 },
>    { 0x0000216C,  28322 },
>    { 0x0000218D,  28560 },
> -  { 0x00010041,  29913 },
>    { 0x000010C9,  31200 },
>    { 0x00003147,  31500 },
> -  { 0x000141A1,  32400 },
>    { 0x000010A7,  33032 },
> -  { 0x00012182,  33375 },
> -  { 0x000141B1,  33750 },
>    { 0x00002159,  35112 },
>    { 0x00004249,  35500 },
>    { 0x00000057,  36000 },
> -  { 0x000141E1,  37125 },
>    { 0x0000219A,  37889 },
>    { 0x00002158,  39168 },
>    { 0x00000045,  40000 },
> -  { 0x000131A1,  40500 },
> -  { 0x00010061,  42301 },
>    { 0x00000089,  43163 },
> -  { 0x00012151,  43875 },
>    { 0x000010E7,  44900 },
>    { 0x00002136,  45720 },
> -  { 0x000152E1,  47250 },
> -  { 0x00010071,  48000 },
>    { 0x00003207,  49500 },
>    { 0x00002187,  50000 },
> -  { 0x00014291,  50625 },
> -  { 0x00011101,  51188 },
> -  { 0x00017481,  54563 },
>    { 0x00004286,  56250 },
> -  { 0x00014170,  57375 },
> -  { 0x00016210,  58500 },
>    { 0x000010E5,  60065 },
> -  { 0x00013140,  62796 },
>    { 0x00004214,  65000 },
> -  { 0x00016250,  65250 },
>    { 0x00001105,  68179 },
> -  { 0x000141C0,  69600 },
> -  { 0x00015220,  70160 },
> -  { 0x00010050,  72000 },
>    { 0x000031E4,  74250 },
>    { 0x00003183,  75000 },
>    { 0x00004284,  78750 },
> -  { 0x00012130,  80052 },
>    { 0x00001104,  81600 },
>    { 0x00006363,  94500 },
>    { 0x00005303,  97520 },
> _
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
