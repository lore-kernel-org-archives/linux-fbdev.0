From: Guillem Jover <guillem@debian.org>
Subject: [PATCH 5/7] fbset: fix parsing of rgba keyword
Date: Mon, 9 Oct 2006 05:45:26 +0300
Message-ID: <20061009024526.GE9011@zulo.hadrons.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="19uQFt6ulqmgNgg1"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWmgM-0004nb-NB for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:24:02 -0700
Received: from 159.red-81-184-118.user.auna.net ([81.184.118.159]
	helo=pulsar.hadrons.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWmgL-0000Xd-VH
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:24:02 -0700
Received: from guillem by pulsar.hadrons.org with local (Exim 4.50)
	id 1GWlBV-00069e-FG for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 04:48:05 +0200
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This fixes the parsing of the rgba keyword in the db.

regards,
guillem

--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset_05_rgba_keyword.patch"

--- modes.l	1999-06-23 17:09:48.000000000 +0300
+++ modes.l	2006-10-09 03:27:58.000000000 +0300
@@ -99,6 +99,7 @@ static const char *CopyString(const char
 
 keyword	[a-zA-Z][a-zA-Z0-9]*
 number	[0-9]*
+colors	[0-9/,]*
 string	\"[^\"\n]*\"
 comment	\#([^\n]*)
 space	[ \t]+
@@ -115,6 +116,11 @@ junk	.
 		return NUMBER;
 	    }
 
+{colors}    {
+		yylval = (unsigned long)CopyString(yytext);
+		return COLORS;
+	    }
+
 {string}    {
 		yylval = (unsigned long)CopyString(yytext);
 		return STRING;
--- modes.y	1999-06-23 17:09:48.000000000 +0300
+++ modes.y	2006-10-09 03:27:58.000000000 +0300
@@ -42,7 +42,7 @@ static void ClearVideoMode(void)
 
 %token MODE GEOMETRY TIMINGS HSYNC VSYNC CSYNC GSYNC EXTSYNC BCAST LACED DOUBLE
        RGBA NONSTD ACCEL GRAYSCALE
-       ENDMODE POLARITY BOOLEAN STRING NUMBER 
+       ENDMODE POLARITY BOOLEAN STRING NUMBER COLORS
 
 %%
 
@@ -148,7 +148,7 @@ double	  : DOUBLE BOOLEAN
 	    }
 	  ;
 
-rgba      : RGBA STRING
+rgba      : RGBA COLORS
             {
 		makeRGBA(&VideoMode, (const char*)$2);
 	    }

--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--19uQFt6ulqmgNgg1--
