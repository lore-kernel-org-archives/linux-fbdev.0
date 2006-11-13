From: "Nathan King" <natetheking@gmail.com>
Subject: Re: who is writing to my framebuffer?
Date: Mon, 13 Nov 2006 12:06:58 -0600
Message-ID: <bb9a78950611131006j55e89ce3k2cf9485e28961acc@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311149224=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjgDA-0005sX-Gl for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 10:07:12 -0800
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GjgD9-0007yk-Pp
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 10:07:12 -0800
Received: by nf-out-0910.google.com with SMTP id c31so1249104nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Nov 2006 10:06:59 -0800 (PST)
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

--===============0311149224==
Content-Type: multipart/alternative; 
	boundary="----=_Part_25818_632375.1163441218940"

------=_Part_25818_632375.1163441218940
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > I'm not sure how to use the information in that link. Everything I'm
> doing
> > is in kernelspace and that tutorial appears to be for userspace
> programming.
> > Also it seems to be for a system with VGA hardware and ours has none,
> we've
> > got a virtual framebuffer that sits in system RAM.
> >
> > I'd considered that the cursor could be at fault somehow, but the cursor
> > drawing code that fbcon points to (softcursor if I recall correctly)
> just
> > points back again to the cfb* functions.
> >
> > I don't suppose you have any other thoughts on this? I'm going to start
> > feeling pretty stupid if I can't solve it soon. ;)
>
> Looking at the code all cursor control from the driver level has been
> removed. It been put into fbcon. So if you enable fbcon then it will
> activate the cursor and have full control of the cursor. Only terminal
> codes will turn it off. Any reason to fbcon enabled?
>

Well, without fbcon I'm not too sure how we could see any of our output. To
view our graphics data we're reading from the framebuffer and sending that
data to another piece of hardware that puts it on a screen.

------=_Part_25818_632375.1163441218940
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&gt; I'm not sure how to use the information in that link. Everything I'm doing
<br>&gt; is in kernelspace and that tutorial appears to be for userspace programming.<br>&gt; Also it seems to be for a system with VGA hardware and ours has none, we've<br>&gt; got a virtual framebuffer that sits in system RAM.
<br>&gt;<br>&gt; I'd considered that the cursor could be at fault somehow, but the cursor<br>&gt; drawing code that fbcon points to (softcursor if I recall correctly) just<br>&gt; points back again to the cfb* functions.<br>
&gt;<br>&gt; I don't suppose you have any other thoughts on this? I'm going to start<br>&gt; feeling pretty stupid if I can't solve it soon. ;)<br><br>Looking at the code all cursor control from the driver level has been<br>
removed. It been put into fbcon. So if you enable fbcon then it will<br>activate the cursor and have full control of the cursor. Only terminal<br>codes will turn it off. Any reason to fbcon enabled?<br></blockquote></div>
<br>Well, without fbcon I'm not too sure how we could see any of our output. To view our graphics data we're reading from the framebuffer and sending that data to another piece of hardware that puts it on a screen. <br>

------=_Part_25818_632375.1163441218940--


--===============0311149224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0311149224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0311149224==--
