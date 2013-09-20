From: Joe Perches <joe@perches.com>
Date: Fri, 20 Sep 2013 18:43:07 +0000
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
Message-Id: <1379702587.2301.12.camel@joe-AO722>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
         <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
         <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
         <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>

On Fri, 2013-09-20 at 19:18 +0100, Maciej W. Rozycki wrote:
> Joe, Geert --

Hi Maciej

> Can we please wait with that a few days?  I've been reviving DECstation 
> bits recently but the generic stuff took priority (thankfully little 
> bitrot there, the port generally works, except from the 64-bit mode).  I 
> think it'll make more sense if we have an incremental diff in the repo 
> rather than a complete removal, followed with a readdition with necessary 
> adjustments.

Good for you.

I do wonder how many of these still exist though.

I haven't had one of those on a desk since the early
'90's (a VAXstation w/VMS and a DECstation w/Ultrix)

This one's been dead for about that long too so
what's a little more time...

The commit that removed it was:
-------------------
commit c708093f8164011d01eb3bbdf7d61965f283ee0e
Author: James Simmons <jsimmons@maxwell.earthlink.net>
Date:   Wed Oct 30 20:06:21 2002 -0800

Moved all console configuration out of arch directories into
drivers/video/console. Allow resize of a single VC via the tty layer.
Nuked GET_FB_IDX.
-------------------

I think you could do:

---

 drivers/video/pmag-aa-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/pmag-aa-fb.c b/drivers/video/pmag-aa-fb.c
index 8384248..0362fb7 100644
--- a/drivers/video/pmag-aa-fb.c
+++ b/drivers/video/pmag-aa-fb.c
@@ -459,7 +459,7 @@ static int __init init_one(int slot)
 		return -EINVAL;
 
 	printk(KERN_INFO "fb%d: %s frame buffer in TC slot %d\n",
-	       GET_FB_IDX(ip->info.node), ip->info.modename, slot);
+	       ip->info.node, ip->info.modename, slot);
 
 	return 0;
 }



