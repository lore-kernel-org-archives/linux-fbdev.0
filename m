From: Ben Collins <bcollins@debian.org>
Subject: Re: Linux 2.5.69
Date: Wed, 7 May 2003 15:35:12 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030507193512.GV679@phunnypharm.org>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com> <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from bristol.phunnypharm.org ([65.207.35.130])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19DVAR-0004ZO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 07 May 2003 13:05:31 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Wed, May 07, 2003 at 09:44:08PM +0200, Geert Uytterhoeven wrote:
> On Sun, 4 May 2003, Linus Torvalds wrote:
> > Summary of changes from v2.5.68 to v2.5.69
> > ============================================
> > 
> > Ben Collins:
> >   o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
> >   o [VIDEO]: Revert atyfb back to known working clean base
> 
> For future changes, could you please run these `reversals' through 
> linux-fbdev-devel, instead of silently passing them behind our backs? Thanks!

This was far from silent. These were discussed with James, DaveM and
Linus, and agreed to by James.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
