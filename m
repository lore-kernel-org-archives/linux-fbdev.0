From: Andrew Morton <akpm@osdl.org>
Subject: Fw: 2.6.10-rc2 swsusp status & framebuffer problems
Date: Fri, 19 Nov 2004 04:10:43 -0800
Message-ID: <20041119041043.0b4ad40d.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CV7bN-0003XR-DW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 04:10:57 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CV7bK-0002N7-Tw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 04:10:57 -0800
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id iAJCAr921047
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 04:10:53 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Fri, 19 Nov 2004 13:08:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: 2.6.10-rc2 swsusp status & framebuffer problems


Hi!

If works for me, modulo graphics problems. So if it is broken on your
machine, try finding driver that is responsible.

Graphics problems: for some reason, swsusp now eats cursor
(radeonfb)... or is it softcursor breakage? There are more problems in
framebuffer, something seems to be very wrong in palete handling. (I
set green palete by default. mutt likes to reset terminal in such way
that font goes white; with -rc2 it affects even non-current console).
 
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
