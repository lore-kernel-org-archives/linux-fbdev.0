From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Add tdfx palette hack to offb driver
Date: Tue, 6 Jan 2004 18:24:48 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401061823580.18404-100000@phoenix.infradead.org>
References: <200303182344.50481.lists@rcdrummond.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Advst-0007zm-5u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 10:24:55 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Advss-00089w-9J
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 10:24:54 -0800
In-Reply-To: <200303182344.50481.lists@rcdrummond.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Drummond <lists@rcdrummond.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Attached is a patch (against 2.4.20) which adds a palette hack for Voodoo3/4/5 
> cards to the offb driver. It's tested and working here on a Voodoo3 and a 
> Voodoo4. I'd welcome comments, though. Particularly, I think the probing for 
> a Voodoo card may be a bit shaky. Basically I'm match the OF name with the 
> pattern "3Dfx,Voodoo*". This may cause problems if there are Voodoo1 or 2 
> cards available with OF drivers, and so need tightening up.

I have updated the patch against 2.6.0. Could you test it before I commit 
it to my tree.

--- /usr/src/linus-2.6/drivers/video/offb.c	2004-01-05 14:54:57.000000000 -0800
+++ offb.c	2004-01-06 13:21:32.000000000 -0800
@@ -43,6 +43,7 @@
 	cmap_M3B,		/* ATI Rage Mobility M3 Head B */
 	cmap_radeon,		/* ATI Radeon */
 	cmap_gxt2000,		/* IBM GXT2000 */
+	cmap_3dfx,		/* 3Dfx Voodoo3/4/5 */
 };
 
 struct offb_par {
@@ -149,6 +150,18 @@
 		out_le32((unsigned *) par->cmap_adr + regno,
 			 (red << 16 | green << 8 | blue));
 		break;
+	case cmap_3dfx:
+		/* Wait for 3 slots in the FIFO */
+		while((in_le32((unsigned *) par->cmap_adr) & 0x1F) < 3);
+		/* Is the desktop using the upper 256 entries of 
+		 * the CLUT ? */
+		if ((in_le32((unsigned *) par->cmap_adr + 0x5C) & 1 << 12))
+			regno += 256;
+		/* Stuff the palette index and data */
+		out_le32((unsigned *)(par->cmap_adr + 0x50), regno);
+		out_le32((unsigned *)(par->cmap_adr + 0x54),
+			 (red << 16 | green << 8 | blue));
+		break;	
 	}
 
 	if (regno < 16)
@@ -175,7 +188,7 @@
 static int offb_blank(int blank, struct fb_info *info)
 {
 	struct offb_par *par = (struct offb_par *) info->par;
-	int i, j;
+	int i, j, regno;
 
 	if (!par->cmap_adr)
 		return 0;
@@ -233,6 +246,20 @@
 				out_le32((unsigned *) par->cmap_adr + i,
 					 0);
 				break;
+			case cmap_3dfx:
+				/* Wait for 3 slots in the FIFO */
+				while((in_le32((unsigned *) par->cmap_adr) & 0x1F) < 3);
+				/* Is the desktop using the upper 256 
+				 * entries of the CLUT ? */
+				regno = (in_le32((unsigned *) par->cmap_adr +
+							0x5C) & 1 << 12) ?
+							i+256 : i;
+				/* Stuff the palette index and data */
+				out_le32((unsigned *)(par->cmap_adr + 0x50), 
+							regno);
+				out_le32((unsigned *)(par->cmap_adr + 0x54),
+							0);
+				break;
 			}
 	} else
 		fb_set_cmap(&info->cmap, 1, info);
@@ -466,6 +493,10 @@
 			unsigned long regbase = dp->addrs[0].address;
 			par->cmap_adr = ioremap(regbase + 0x6000, 0x1000);
 			par->cmap_type = cmap_gxt2000;
+		} else if (!strncmp(name, "3Dfx,Voodoo", 11)) {
+			unsigned long regbase = dp->addrs[2].address;
+			par->cmap_adr = ioremap(regbase, 0xff);
+			par->cmap_type = cmap_3dfx;
 		}
 		fix->visual = par->cmap_adr ? FB_VISUAL_PSEUDOCOLOR
 		    : FB_VISUAL_STATIC_PSEUDOCOLOR;



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
