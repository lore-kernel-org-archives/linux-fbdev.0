From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Problem with radeon new ROM probe code
Date: Thu, 25 Sep 2003 07:39:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030925053916.GA2068@iliana>
References: <1064425449.15996.58.camel@gaston> <20030924181257.78090.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2Or0-0006Xb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 22:39:50 -0700
Received: from smtp4.wanadoo.fr ([193.252.22.26] helo=mwinf0502.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A2Oqz-0001IO-Ih
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Sep 2003 22:39:49 -0700
Content-Disposition: inline
In-Reply-To: <20030924181257.78090.qmail@web14914.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michel DXnzer <michel@daenzer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Sep 24, 2003 at 11:12:57AM -0700, Jon Smirl wrote:
> Is the 'Mac' card being used on a x86 machine?
> I thought the ROM code was compiled out on non-X86 machines.

Notice that not all powerpc boxes are in this case. The pegasos at least
includes an x86 emulator in the OF which runs the cards bios. I know
that the amigaone does the same. So testing for powerpc may well not be
enough for detecting OF cards.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
