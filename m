From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: patch-scripts, CVS, bitkeeper and kernel-sources
Date: Tue, 01 Feb 2005 00:33:15 +0100
Message-ID: <41FEC03B.1070401@XLsigned.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cvl2q-0007Ry-G8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Jan 2005 15:33:24 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cvl2n-0006xC-Do
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Jan 2005 15:33:24 -0800
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

Hi,

after reading "docco.txt" of "patch-scripts", browsing the mailing list archive and
inspecting the "linux-fbdev" CVS repository on soureforge I'm a little confused.

Where are the sources or rather how can I access the HEAD revision (of trunk, tags and/or
branches) that are required when generating a patch?

My intelfb-patch is based on 2.6.10 kernel sources that might have been patched already by
gentoo (gentoo 2.6.10-r6), though I'm quite sure that "intelfb" was'nt touched.
But 2.6.11-rc2-mm2 on kernel.org does obviously contain patches for "intelfb"
that I wasn't aware of. (Maybe the patches that were recently posted here)

Does that mean that I have to check "kernel.org" for latest patches (change sets)?
What for is this (almost empty) "linux-fbdev" CVS repository? My first thought was
that this is the place where current fbdev development is taken place and that
"stable releases" are transmitted to "kernel.org".

Right now I'm assuming that the truth is: I have to maintain a kernel-source-tree
by my own and use the (quoting) "fragile" patch-scripts to apply bitkeeper diffs
from kernel.org?

Is this all because of linux using bitkeeper and not cvs, gnu/arch (tla) or subversion?

Thanks for answering my stupid questions

--Axel










-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
