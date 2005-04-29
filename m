From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Hang when using a Matrox G550 with DVI
Date: Fri, 29 Apr 2005 03:50:39 -0700
Message-ID: <20050429035039.2b511dcd.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRT5d-0000iT-QO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 03:51:21 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DRT5d-0003MQ-6v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Apr 2005 03:51:21 -0700
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
Cc: Shaun Jackman <sjackman@gmail.com>



Begin forwarded message:

Date: Thu, 21 Apr 2005 11:31:32 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Hang when using a Matrox G550 with DVI


When I have a DVI display plugged into my Matrox G550 video card the
Linux kernel 2.6.11 hangs while booting. This can be worked around by
"disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
in arch/i386/boot/video.S" [1], or by unplugging the DVI display
before the kernel boots and plugging it back in before X starts. This
is the same bug listed here [2], and it has been around since the
2.5.67-bk6 days.

Please cc me in your reply. Cheers,
Shaun

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/0434.html
[2] http://bugme.osdl.org/show_bug.cgi?id=1458
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
