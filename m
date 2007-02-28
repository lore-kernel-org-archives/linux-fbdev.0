From: Ian Romanick <idr@us.ibm.com>
Subject: matroxfb returning incorrect fix.smem_len?
Date: Wed, 28 Feb 2007 11:20:48 -0800
Message-ID: <45E5D610.5060807@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMUS1-0005DS-Dl for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 11:26:57 -0800
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HMUS0-0008HL-VJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 11:26:57 -0800
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1SJPG6e023104
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 14:25:16 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1SJOwU9215958 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 14:24:58 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1SJOvIZ019644 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 14:24:58 -0500
Received: from [9.49.139.239] (sig-9-49-139-239.mts.ibm.com [9.49.139.239])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l1SJOvCw019592 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 14:24:57 -0500
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

While doing some work on the pci-rework branch of X.org, I noticed
something strange.  matroxfb correctly detects that my card has 16MiB,
but fix.smem_len is only 8MiB.

I looked around the matroxfb code and some of the other driver's code,
and I believe that matroxfb is incorrectly setting fix.smem_len.
Matroxfb sets fix.smem_len to (total_memory_size -
memory_used_by_current_mode).  Other drivers, such as nvidiafb do not do
this.

If folks agree that matroxfb is in error, I'll submit a patch.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFF5dYQX1gOwKyEAw8RAivuAJ45rPETrNtVJ7/OXSV/YZbMsKSslACfcB07
200urWC85ITtG6RZf32X8po=
=DG82
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
