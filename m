From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 10:45:52 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066412752.1675.20.camel@torrey.et.myrio.com>
References: <Pine.LNX.4.44.0310171824190.966-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAYiX-0007oP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 10:48:49 -0700
Received: from devil.servak.biz ([209.124.81.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAYiN-0007WM-UE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 10:48:40 -0700
In-Reply-To: <Pine.LNX.4.44.0310171824190.966-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2003-10-17 at 10:25, James Simmons wrote:
[...]

> The BK tree doesn't have the new radeon driver. I placed the new radeon 
> driver into the patch so people coudl test it.

I have a Radeon All-In-Wonder 7500.  I downloaded the tar.gz patch and
applied it to -test7.  The resulting kernel panics at startup, while
test7 with the same config works fine for me.

Before it panics, the penguin shows up at least, so it works a little
bit :-/

I have not had time to attach a serial console to capture the oops yet,
but hope to do that by the end of the day...


-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
