From: Russell King <rmk@arm.linux.org.uk>
Subject: [BUG] 2.5.71: no cursor until tty output
Date: Mon, 16 Jun 2003 19:00:42 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030616190042.F13312@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19RyHu-0002Sn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 11:01:02 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel List <linux-kernel@vger.kernel.org>

There appears to be a bug in fbcon where the soft cursor does not appear
on the screen until some tty output occurs.  I suspect soft cursor is
missing some initialisation somewhere; I have once seen some random garbage
flashing on the screen instead of the cursor, which seems to be where
the cursor is supposed to be.

When tty output occurs, the characters appear where the garbage was, and
the normal cursor appears.

I've noticed this on several fbcon drivers, so I don't believe it is a
generic fbcon bug.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
