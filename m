From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] platinumfb: misplaced parenthesis
Date: Sun, 17 May 2009 13:53:00 +0200
Message-ID: <4A0FFA9C.5000404@gmail.com>
References: <4A0C0C4E.6070401@gmail.com>	
	<20090514093827.33a099f7.akpm@linux-foundation.org>	
	<1242343459.1867.27.camel@pasglop>
	<4A0DD407.9090206@gmail.com>	 <20090515212449.GD6520@sci.fi>
	<1242426067.9691.4.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1M5evR-0008Si-Lh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 11:53:05 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5evQ-0007aZ-KW for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 11:53:05 +0000
Received: by ewy17 with SMTP id 17so3612978ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 17 May 2009 04:53:02 -0700 (PDT)
In-Reply-To: <1242426067.9691.4.camel@pasglop>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, adaplas@gmail.com

Since `+' has a higher precedence than the trinary operator `?', this
added `hres * (1 << color_mode)' to the boolean testing videomode
and depth.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 static inline int platinum_vram_reqd(int video_mode, int color_mode)
 {
+	int offset;
+
+	if ((video_mode == VMODE_832_624_75) && (color_mode > CMODE_8))
+		offset = 0x1010;
+	else
+		offset = 0x1020;
+
 	return vmode_attrs[video_mode-1].vres *
-	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
-		((video_mode == VMODE_832_624_75) &&
-		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
+		(vmode_attrs[video_mode-1].hres * (1<<color_mode) + offset);
 }
 
 #define STORE_D2(a, d) { \

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
