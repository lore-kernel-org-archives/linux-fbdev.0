From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Merge of Luca and Ben's sysfs work for Radeon
Date: Thu, 25 Sep 2003 19:57:44 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030926025744.80379.qmail@web14905.mail.yahoo.com>
References: <20030926023617.GD9615@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2inh-0001i5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Sep 2003 19:57:45 -0700
Received: from web14905.mail.yahoo.com ([216.136.225.57])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2ing-0002OD-Pb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 Sep 2003 19:57:44 -0700
In-Reply-To: <20030926023617.GD9615@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

The merged tree is a copy of everything in Linus' tree plus our fbdev work.
Just treat it like a normal kernel tree.

make proper
copy your config
make oldconfig
make

The tree contains all of:
test5
fbdev work
hundreds of patches in the Linus tree past test5

To make sure it is absolutely up to date with Linus, cd into it and:
bk pull bk://linux.bkbits.net/linux-2.5
This will pull the up to the minute changes from Linus' own tree into yours.

To see the diffs from test5 to present:
bk revtool and find last revision number, probably something like 1.1303.
bk export -tpatch -rv2.6.0-test2,1.1303 -h >../patch

There will be a lot of diffs, Linus is about ready to tag test6.

To look at a specific file:
bk revtool file-name

Now that you have a bk tree you don't have to wait for a tagged release. Just
pull the changes fron Linus' tree when you want to update.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
