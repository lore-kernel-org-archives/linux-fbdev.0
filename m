From: Ludovic Drolez <ludovic.drolez@linbox.com>
Subject: Re: 2.6.9 bug: linux logo not displayed in vga16fb (bug found)
Date: Tue, 26 Oct 2004 17:54:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <417E733C.2040204__15897.6452229128$1098820087$gmane$org@linbox.com>
References: <4178CB95.7000505@linbox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMTl2-00004x-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 09:01:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMTl0-0004DG-L6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 09:01:12 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9QG18Mp017902
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Oct 2004 18:01:08 +0200 (MEST)
In-Reply-To: <4178CB95.7000505@linbox.com>
Resent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.61.0410261801050.19019@waterleaf.sonytel.be>
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
To: linux-kernel@vger.kernel.org

Ludovic Drolez wrote:
> Hi !
> 
> I used to have a nice vga boot logo with my 2.6.7 kernel, but with the 
> 2.6.9, my
> boot logo has disappeared (same .config)...
> It seems to switch to VGA, and some space is reserved for the logo, but 
> it is not displayed.
> The logo appears with vesafb.

I made a few diffs between my old working 2.6.7 kernel and the 2.6.9 and found 
something interesting in fbmem.c:

---------------
@@ -723,7 +419,7 @@
         if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
                 return 0;

-       image.depth = fb_logo.depth;
+       image.depth = 8;
         image.data = fb_logo.logo->data;

         if (fb_logo.needs_cmapreset)
---------------

So, on my 2.6.9, I replaced the '8' by 'fb_logo.depth' and now the logo is 
shown! (but the screen is still not cleared as before when the kernel boots).

Where's the QA guy ? I want to see him now ! ;-)

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 50 87 90                            fax : 03 87 75 19 26
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
