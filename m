From: "Nathan King" <natetheking@gmail.com>
Subject: Re: who is writing to my framebuffer?
Date: Mon, 13 Nov 2006 13:19:23 -0600
Message-ID: <bb9a78950611131119r163c4beci5559b7e6e84c3e84@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0850891937=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjhL7-0004tr-KX for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 11:19:29 -0800
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GjhL6-0005x0-4E
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 11:19:29 -0800
Received: by nf-out-0910.google.com with SMTP id c31so1288569nfb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Nov 2006 11:19:23 -0800 (PST)
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

--===============0850891937==
Content-Type: multipart/alternative; 
	boundary="----=_Part_26862_12310082.1163445563346"

------=_Part_26862_12310082.1163445563346
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > > Looking at the code all cursor control from the driver level has been
> > > removed. It been put into fbcon. So if you enable fbcon then it will
> > > activate the cursor and have full control of the cursor. Only terminal
> > > codes will turn it off. Any reason to fbcon enabled?
> > >
> >
> > Well, without fbcon I'm not too sure how we could see any of our output.
> To
> > view our graphics data we're reading from the framebuffer and sending
> that
> > data to another piece of hardware that puts it on a screen.
>
> No serial port or network avaliable?
>

There is, but we don't want that, we'd like to put our output on a monitor
attached to the machine.

------=_Part_26862_12310082.1163445563346
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; &gt; Looking at the code all cursor control from the driver level has been<br>&gt; &gt; removed. It been put into fbcon. So if you enable fbcon then it will
<br>&gt; &gt; activate the cursor and have full control of the cursor. Only terminal<br>&gt; &gt; codes will turn it off. Any reason to fbcon enabled?<br>&gt; &gt;<br>&gt;<br>&gt; Well, without fbcon I'm not too sure how we could see any of our output. To
<br>&gt; view our graphics data we're reading from the framebuffer and sending that<br>&gt; data to another piece of hardware that puts it on a screen.<br><br>No serial port or network avaliable?<br></blockquote></div><br>
There is, but we don't want that, we'd like to put our output on a monitor attached to the machine.<br>

------=_Part_26862_12310082.1163445563346--


--===============0850891937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0850891937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0850891937==--
