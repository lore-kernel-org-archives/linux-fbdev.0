From: Kevin O'Connor <kevin@koconnor.net>
Subject: [PATCH] matroxfb_maven module OOPS on insmod
Date: Mon, 22 Dec 2003 22:09:59 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031223030959.GA3038@arizona.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYcwa-0008QM-9X
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 19:10:48 -0800
Received: from smtp.everyone.net ([216.200.145.17] helo=rmta01.mta.everyone.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AYcwa-0001kS-28
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 19:10:48 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

When running the following commands:

/sbin/modprobe i2c-algo-bit
/sbin/modprobe i2c-matroxfb
/sbin/modprobe matroxfb_maven

the 2.6.0 kernel will reliably oops.  The problem is a result of calling
device_add with uninitialized data.  The following patch allows the module
to be inserted.

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=matrox_diff

--- gold-2.6/drivers/video/matrox/matroxfb_maven.c	2003-10-25 14:42:44.000000000 -0400
+++ linux-2.6.0/drivers/video/matrox/matroxfb_maven.c	2003-12-22 21:55:04.082725504 -0500
@@ -1249,6 +1249,7 @@
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0, sizeof(*new_client) + sizeof(*data));
 	data = (struct maven_data*)(new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;

--Q68bSM7Ycu6FN28Q--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
