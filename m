From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Problem with cfb_imageblit
Date: 25 May 2002 07:24:51 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1022282739.542.1.camel@daplas>
References: <1022214909.540.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17BOPR-0004kD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 May 2002 16:23:45 -0700
Received: from [205.136.61.38] (cwc38.compass.com.ph [205.136.61.38])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id HAA24152
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 May 2002 07:23:40 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <1022214909.540.1.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-05-24 at 21:19, Antonino Daplas wrote:
> Hi,
> 
> I have an unusual problem with cfb_imageblit.  I'm not too sure if this
> is unique to my system. I get garbage pixels.  For example the
> underscore character (_) appears like this magnified:

Didn't look carefully enough, I found the problem.  

Tony

--- cfbimgblt.c-orig	Fri May 24 15:51:13 2002
+++ cfbimgblt.c	Fri May 24 15:51:28 2002
@@ -105,7 +105,7 @@
 				fb_writel((mask & eorx)^bgx, dst);
 				dst++;
 			}
-			l =- pad;		
+			l -= pad;		
 			dst1 += p->fix.line_length;	
 		}	
 	}


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
