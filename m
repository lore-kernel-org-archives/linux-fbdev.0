From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 0/4] pxafb: add smartpanel support
Date: Tue, 8 Apr 2008 12:01:25 +0800
Message-ID: <f17812d70804072101u1244c864s2f8d2ec1c9f96239@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj51U-0003op-ON for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 21:01:28 -0700
Received: from wr-out-0506.google.com ([64.233.184.233])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jj51S-0001hR-JL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 21:01:28 -0700
Received: by wr-out-0506.google.com with SMTP id c48so1435401wra.1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Apr 2008 21:01:25 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel email list <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

There are 4 patches as listed below:

0001 - pxafb: introduce lcd_{read,write}l() to wrap the __raw_{read,write}l()
0002 - pxafb: use completion for LCD disable wait code
0003 - pxafb: move parallel LCD timing setup into dedicate function
0004 - pxafb: preliminary smart panel interface support

The actual support for the smartpanel interface is done by patch 0004, the
patches 0001-0003 are mainly cleanup ones.

The smartpanel interface supports LCD panels with internal buffers,
sometimes known as remote framebuffer.

The next step work will be to introduce an "struct pxafb_output" to
abstract two different output interface supported: the parallel and
the smartpanel, after these patches are merged.

-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
