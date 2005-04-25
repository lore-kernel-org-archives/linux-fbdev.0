From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4543] New: [OPERA] Potential bug detected in
 /drivers/video/sis/sis_main.c
Date: Mon, 25 Apr 2005 15:29:37 -0700
Message-ID: <20050425152937.5bd0d30f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQC5q-0003CL-Ij
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 15:30:18 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DQC5X-0008S6-EN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 15:30:18 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PMTvs4006829
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 15:29:57 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3PMTveC011020
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Apr 2005 15:29:57 -0700
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



Begin forwarded message:

Date: Mon, 25 Apr 2005 15:01:03 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4543] New: [OPERA] Potential bug detected in /drivers/video/sis/sis_main.c


http://bugme.osdl.org/show_bug.cgi?id=4543

           Summary: [OPERA] Potential bug detected in
                    /drivers/video/sis/sis_main.c
    Kernel Version: 2.6.11.7
            Status: NEW
          Severity: normal
             Owner: drivers_video-other@kernel-bugs.osdl.org
         Submitter: lzmhome@yahoo.com


Problem Description:
A potential bug is detected by our tool in linux-
2.6.11.7/drivers/video/sis/sis_main.c:

--- sis_main.c  2005-04-25 16:50:04.000000000 -0500
+++ sis_main.fixed.c    2005-04-25 16:51:02.000000000 -0500
@@ -460,7 +460,7 @@
    if(monitor->hmax < sisfb_ddcfmodes[j].h) monitor->hmax = sisfb_ddcfmodes
[j].h + 1;
    if(monitor->vmin > sisfb_ddcsmodes[j].v) monitor->vmin = sisfb_ddcsmodes
[j].v;
    if(monitor->vmax < sisfb_ddcsmodes[j].v) monitor->vmax = sisfb_ddcsmodes
[j].v;
-   if(monitor->dclockmax < sisfb_ddcsmodes[j].d) monitor->dclockmax = 
sisfb_ddcsmodes[i].d;
+   if(monitor->dclockmax < sisfb_ddcsmodes[j].d) monitor->dclockmax = 
sisfb_ddcsmodes[j].d;
    }
  }
}

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
