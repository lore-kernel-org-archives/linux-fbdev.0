From: Zack Smith <plinius@comcast.net>
Subject: Re: Optimized cfbimgblt.c
Date: Thu, 27 Jan 2005 12:06:35 -0800
Message-ID: <41F949CB.405@comcast.net>
References: <Pine.LNX.4.56.0501192015560.20796@pentafluge.infradead.org> <200501252058.13632.adaplas@hotpop.com> <Pine.LNX.4.56.0501262104140.15652@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------090100060609090107010604"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuD97-0002m6-On
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Jan 2005 09:09:29 -0800
Received: from rwcrmhc11.comcast.net ([204.127.198.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CuD97-0007tn-1K
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Jan 2005 09:09:29 -0800
In-Reply-To: <Pine.LNX.4.56.0501262104140.15652@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090100060609090107010604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I just want to make a tangential comment, call it trivia almost,
but if we wanted to use my in-kernel GUI -- FBUI -- to handle
the graphics during startup, including the penguin image, or
even to handle the virtual console terminal itself or the login
prompt, then I expect that can be done.

Zack Smith
home.comcast.net/~plinius/fbui.html


James Simmons wrote:

>>Hi James,
>>
>>Tested on vesafb: works
>>Tested on rivafb: crashes on fb_show_logo().
>>    
>>
>
>Ug!! Which video card are you using,what logos are you attempting to 
>draw, and if you could post the oops trace? This is really strange. I 
>tested the code with Radeon, 3Dfx, NeoMagic, and the VesaFB driver. They 
>all worked. Also the riva drives used cfb_imageblit for the logo. Tomorrow 
>I will pull out my TNT2 card to see what happens. 
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>Tool for open source databases. Create drag-&-drop reports. Save time
>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
>  
>


--------------090100060609090107010604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
I just want to make a tangential comment, call it trivia almost,<br>
but if we wanted to use my in-kernel GUI -- FBUI -- to handle<br>
the graphics during startup, including the penguin image, or <br>
even to handle the virtual console terminal itself or the login<br>
prompt, then I expect that can be done.<br>
<br>
Zack Smith<br>
home.comcast.net/~plinius/fbui.html<br>
<br>
<br>
James Simmons wrote:
<blockquote
 cite="midPine.LNX.4.56.0501262104140.15652@pentafluge.infradead.org"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">Hi James,

Tested on vesafb: works
Tested on rivafb: crashes on fb_show_logo().
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Ug!! Which video card are you using,what logos are you attempting to 
draw, and if you could post the oops trace? This is really strange. I 
tested the code with Radeon, 3Dfx, NeoMagic, and the VesaFB driver. They 
all worked. Also the riva drives used cfb_imageblit for the logo. Tomorrow 
I will pull out my TNT2 card to see what happens. 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&amp;-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at <a class="moz-txt-link-freetext" href="http://www.intelliview.com/go/osdn_nl">http://www.intelliview.com/go/osdn_nl</a>
_______________________________________________
Linux-fbdev-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linux-fbdev-devel@lists.sourceforge.net">Linux-fbdev-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel">https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel</a>

  </pre>
</blockquote>
<br>
</body>
</html>

--------------090100060609090107010604--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
