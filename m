From: Kronos <kronos@people.it>
Subject: [2.6.10-rc2] Regression in cursor code
Date: Fri, 19 Nov 2004 18:45:42 +0100
Message-ID: <20041119174542.GA5002@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVCou-0005SV-7R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 09:45:16 -0800
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CVCot-0008DX-1Y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 09:45:16 -0800
Received: from dreamland.darkstar.lan (84.222.33.240) by mail-relay-2.tiscali.it (7.1.021.3)
        id 415D985100A54E51 for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 18:45:07 +0100
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
I just tried 2.6.10-rc2 and there's a regression in cursor code. The
cursor disappear when I start a ncurses-based application and the switch
to another console.

Step to reproduce:
1) Start a ncurses application (like tin, mutt, alsamixer)
2) Switch vt: cursor is gone.

With tin, mutt, alsamixer it's 100% reproducible. It doesn't happen with
ViM though...

I'm using radeonfb (new one) on a R300; I tried with and without X and
it doesn't make any difference.

I'm sorry that I can't be more precise about the bug but I'm very busy.
I can try to track it down next week if it's needed.

Luca
-- 
Home: http://kronoz.cjb.net
"La vita potrebbe non avere alcun significato. Oppure, ancora peggio,
 potrebbe averne uno che disapprovo". -- Ashleigh Brilliant


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
