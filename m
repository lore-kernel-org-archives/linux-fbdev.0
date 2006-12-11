From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: fbdev driver for S3 Trio/Virge
Date: Tue, 12 Dec 2006 00:39:03 +0100
Message-ID: <20061211233903.GA1235@localhost.localdomain>
References: <20061206100601.GA1408@localhost.localdomain>
	<20061211143041.d42aff3b.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gtujv-0000JL-RC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Dec 2006 15:39:20 -0800
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gtujr-0002lT-6b
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Dec 2006 15:39:19 -0800
Content-Disposition: inline
In-Reply-To: <20061211143041.d42aff3b.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Dec 11, 2006 at 02:30:41PM -0800, Andrew Morton wrote:
> On Wed, 6 Dec 2006 11:06:01 +0100
> Ondrej Zajicek <santiago@crfreenet.org> wrote:
> 
> > This patch adds driver for S3 Trio / S3 Virge.
> 
> Confused.  Don't S3triofb.c and virgefb.c already do that?

virgefb.c
  - amiga/zorro specific,
  - broken (according to Kconfig),
  - uses obsolete/nonexistent interface (struct display_switch)
  - recent Adrian Bunk's patch removes this driver
  
S3triofb.c
  - ppc/openfirmware specific
  - minimal functionality
  - broken (according to Kconfig),
  - uses obsolete/nonexistent interface (struct display_switch)

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
