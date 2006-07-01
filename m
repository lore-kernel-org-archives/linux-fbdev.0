From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/3] fbdev: Add framebuffer and
 display update module support for pnx4008
Date: Sat, 01 Jul 2006 13:03:43 +0800
Message-ID: <44A6022F.30500@gmail.com>
References: <44A51257.10804@gmail.com> <20060630204454.4ca27a23.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwXeB-0002uO-3a for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:03:59 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FwXe9-0004e0-PP
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 22:03:59 -0700
Received: by py-out-1112.google.com with SMTP id d42so915779pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 Jun 2006 22:03:56 -0700 (PDT)
In-Reply-To: <20060630204454.4ca27a23.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, gtolstolytkin@ru.mvista.com

Andrew Morton wrote:
> On Fri, 30 Jun 2006 20:00:23 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> +	if ((ret = put_cmd_string(cmds_c)) != 0) {
>> +		return ret;
>> +	}
> 
> Guys, please avoid the assign-then-test trick.  Kernel style is
> super-simple style.  The above should be coded as:
> 

I'm kinda lax when it comes to this style, but if you insist :-)

> 
> 	ret = put_cmd_string(cmds_c);
> 	if (ret != 0)
> 		return ret;
> 
> Nice and easy.
> 

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
