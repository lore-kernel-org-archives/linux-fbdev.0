From: Richard Smith <rsmith@bitworks.com>
Subject: Compiling Rage xlinit.c
Date: Tue, 11 May 2004 17:13:16 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40A14FFC.102@bitworks.com>
References: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org>
Reply-To: rsmith@bitworks.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNfVd-00027D-PI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 15:13:57 -0700
Received: from b44.xdsl.pgtc.com ([198.70.248.44] helo=bitworks.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BNfVd-0004Hk-8Y
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 May 2004 15:13:57 -0700
Received: from bitworks.com [192.168.1.22] by bitworks.com [127.0.0.1] with SMTP (MDaemon.v2.7.SP4.R) for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 May 2004 17:12:21 -0500
In-Reply-To: <Pine.LNX.4.44.0405110048330.8016-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

How does one get the rage xlinit stuff to work.  I've enabled it in my 
kernel build but it dosen't seem to be compiled and I don't see in the 
Makefile any attempt to compile it.

Does this get built for x86?

Any anycase my attempt to compile it yeild an structure member dosen't 
exist for pll->sclk_fb_div.  Checking the def for struct pll_ct shows 
that sclk_fb_div is not a member of pll_ct.  So I don't see how this 
would ever compile.




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
