From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Vesa fix
Date: Tue, 13 May 2003 18:50:22 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030513175022.GA3309@suse.de>
References: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from deviant.impure.org.uk ([195.82.120.238] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19FdvE-0001LV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 10:50:40 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 12, 2003 at 10:44:29PM +0100, James Simmons wrote:

 >    The results of the EDID info from the BIOS has been varied. For some it 
 > worked. Others it gave the wrong data. Then for other even the headers 
 > where corrupted :-( 

XFree86 seems to do a pretty good job of getting it right, maybe they
have blacklists ? Then again, this stuff is arguably better off done
in userspace anyway IMO.

		Dave



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
