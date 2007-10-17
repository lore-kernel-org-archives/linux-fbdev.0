From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: hgafb: needs a release function
Date: Wed, 17 Oct 2007 15:19:55 -0700
Message-ID: <20071017151955.7c0e14fd.randy.dunlap@oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiHH3-0001wE-ED for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 15:21:57 -0700
Received: from agminet01.oracle.com ([141.146.126.228])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IiHH2-0007kA-1F
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 15:21:57 -0700
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
To: fero@drama.obuda.kando.hu, linux-nvidia@lists.surfsouth.com
Cc: linux-fbdev-devel@lists.sourceforge.net

(no hga device, that part is correct)

hgafb: HGA card not detected.
hgafb: probe of hgafb.0 failed with error -22
Device 'hgafb.0' does not have a release() function, it is broken and must be fixed.
WARNING: at drivers/base/core.c:107 device_release()

Call Trace:
 [<ffffffff80321f2c>] kobject_put+0x19/0x1b
 [<ffffffff803a770d>] device_release+0x83/0x85
 [<ffffffff80321f66>] kobject_cleanup+0x38/0x67
 [<ffffffff80321f95>] kobject_release+0x0/0xf
 [<ffffffff80321fa2>] kobject_release+0xd/0xf
 [<ffffffff80322ec2>] kref_put+0x5f/0x6b
 [<ffffffff80321f2c>] kobject_put+0x19/0x1b
 [<ffffffff803a7855>] put_device+0x15/0x17
 [<ffffffff803ac260>] platform_device_put+0x12/0x14
 [<ffffffff803ac2df>] platform_device_unregister+0x19/0x1e
 [<ffffffff8810b458>] :hgafb:hgafb_exit+0x10/0x1e
 [<ffffffff80258eec>] sys_delete_module+0x1b5/0x1e6
 [<ffffffff8020ef44>] syscall_trace_enter+0x95/0x99
 [<ffffffff8020beec>] tracesys+0xdc/0xe1



See Documentation/driver-model/{device.txt,porting.txt} for some info,
although more doc for this particular requirement is needed.

---
~Randy

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
