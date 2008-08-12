From: Bernhard Fischer <rep.dot.nop@gmail.com>
Subject: Re: [Patch 3/13 v3] [RESEND] viafb: fix for	the
	malformed patch issue
Date: Tue, 12 Aug 2008 18:47:13 +0200
Message-ID: <20080812164713.GB3571@mx.loc>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F4A1A@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSx2I-0003NM-Hh for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 09:47:54 -0700
Received: from fg-out-1718.google.com ([72.14.220.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSx2H-0002HH-5P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 09:47:54 -0700
Received: by fg-out-1718.google.com with SMTP id d23so1283313fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 12 Aug 2008 09:47:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F4A1A@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org

On Tue, Aug 12, 2008 at 09:00:04AM +0800, JosephChan@via.com.tw wrote:
>Correct the malformed issue for v2's patch which .
>2D and HW cursor stuff of viafb driver.
>
>Signed-off-by: Joseph Chan <josephchan@via.com.tw>
>
>diff -Nurp a/drivers/video/via/accel.c b/drivers/video/via/accel.c
>--- a/drivers/video/via/accel.c	1970-01-01 08:00:00.000000000 +0800
>+++ b/drivers/video/via/accel.c	2008-07-22 02:07:29.000000000 +0800

>+void viafb_init_accel(void)
>+{

>+	/* Reverse 8*1024 memory space for cursor image */

s/verse/serve/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
