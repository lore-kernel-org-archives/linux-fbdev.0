From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-users] who is writing to my
	framebuffer?
Date: Mon, 13 Nov 2006 17:24:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611131719270.2366@pentafluge.infradead.org>
References: <bb9a78950611130800m6b10fd0ek888c15cff7e6f1fe@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <bb9a78950611130800m6b10fd0ek888c15cff7e6f1fe@mail.gmail.com>
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
To: linux-fbdev-users@lists.sourceforge.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I'm not sure how to use the information in that link. Everything I'm doing
> is in kernelspace and that tutorial appears to be for userspace programming.
> Also it seems to be for a system with VGA hardware and ours has none, we've
> got a virtual framebuffer that sits in system RAM.
>
> I'd considered that the cursor could be at fault somehow, but the cursor
> drawing code that fbcon points to (softcursor if I recall correctly) just
> points back again to the cfb* functions.
>
> I don't suppose you have any other thoughts on this? I'm going to start
> feeling pretty stupid if I can't solve it soon. ;)

Looking at the code all cursor control from the driver level has been 
removed. It been put into fbcon. So if you enable fbcon then it will 
activate the cursor and have full control of the cursor. Only terminal 
codes will turn it off. Any reason to fbcon enabled?



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
