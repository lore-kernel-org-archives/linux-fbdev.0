From: Martin Sieper <m.si@ngi.de>
Subject: Re: Computer with 1GB and radeonfb
Date: Thu, 05 Jun 2003 14:06:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <elmo1054814768183606478160@arbeitspferd>
References: <elmo105432563416005480015305@arbeitspferd> <20030531054213.GA7494@middle.of.nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mx2.ngi.de ([213.191.74.84])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19NtVg-0006MU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 05:06:24 -0700
Received: from unknown (HELO arbeitspferd) ([213.20.27.3])
          (envelope-sender <m.si@ngi.de>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <linux-fbdev-devel@lists.sourceforge.net>; 5 Jun 2003 11:55:18 -0000
In-Reply-To: <20030531054213.GA7494@middle.of.nowhere>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi Jurriaan,

thank you for the answer.

On Sat, 31 May 2003 07:42:13 +0200, Jurriaan wrote:
> The first one probably only affects the vesafb-driver. You could adapt
> it to the radeonfb-driver, just search for the correct lines in the
> radeonfb source and change them like the patch changes them.
> There's nothing like booting a kernel whose sources you've changed
> yourself to make you feel the power of open source :-)

I have look in the source radeonfb.c and have insert this:

--- linux-2.4.20/drivers/video/radeonfb.c.orig	2003-06-05 00:06:54.000000000 +0200
+++ linux-2.4.20/drivers/video/radeonfb.c	2003-06-01 12:19:07.000000000 +0200
@@ -1714,6 +1714,15 @@
 		}
 	}
 
+	/*
+	 * Hack for big memory (1GB main RAM) problem:
+	 * 	If the card memory bigger as 64MB
+	 *	so limit it to 64MB!
+	 */
+	if ((rinfo->video_ram / 1024) > 65536) {
+		rinfo->video_ram = 65536 * 1024;
+	}
+
 
 	RTRACE("radeonfb: probed %s %dk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
 

Now the radeonfb works in 8 bit mode but not perfect. There are pixel-trash 
when I scroll up/down. The 16 bit and 32 bit modes works but I have 
wrong colors and the same scroll problem. Any idea?

BTW: my Radeon 9100 has 128 MB RAM

 -Martin



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
