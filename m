From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: writing to a floating point register ?
Date: Wed, 5 Feb 2003 11:17:53 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205101753.GA1466@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gMd1-0006OO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 02:18:03 -0800
Received: from mel-rta8.wanadoo.fr (193.252.19.79) by mel-rto2.wanadoo.fr (6.7.015)
        id 3E0C3370018D2E50 for linux-fbdev-devel@lists.sourceforge.net; Wed, 5 Feb 2003 11:17:54 +0100
Received: from iliana (80.14.240.127) by mel-rta8.wanadoo.fr (6.7.015)
        id 3E26DA7000B3BB16 for linux-fbdev-devel@lists.sourceforge.net; Wed, 5 Feb 2003 11:17:54 +0100
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 18gMcr-0000Nt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 11:17:53 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello, ...

while writing a fbdev driver, i need to write a value to a floating
point register. Do we have any macro doing this, or should i need to
calculate the sign, mantissa and exponent by hand ?

Just doing a unsigned int cast would round the value i think, and thus
not give the right result.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
