From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [OT] framebuffer ioctl
Date: Mon, 6 Sep 2004 20:11:21 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e47339104090617112c790d94@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <20040906211120.GC29544@guug.org>
	 <9e4733910409061439695460f@mail.gmail.com>
	 <20040907000103.GD29544@guug.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4TZy-0000SZ-RR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 17:11:22 -0700
Received: from rproxy.gmail.com ([64.233.170.193] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4TZy-0001hh-Fo
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 17:11:22 -0700
Received: by mproxy.gmail.com with SMTP id 77so150032rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Sep 2004 17:11:21 -0700 (PDT)
In-Reply-To: <20040907000103.GD29544@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Alan Cox has proposed a new unified mode setting mode that uses
hotplug. There are four ways to set modes: user space, vm86/real mode,
in kernel, mix of these. The new scheme supports mode setting for
hardware of these different types. fbdev is all in kernel.

On Mon, 6 Sep 2004 18:01:03 -0600, Otto Solares <solca@guug.org> wrote:
> On Mon, Sep 06, 2004 at 05:39:54PM -0400, Jon Smirl wrote:
> > Someone has already ported it, but I forget who it was. mesa-solo is
> > not quite ready for prime time yet because it does have mode setting
> > support. Ask on the cairo list about the port. It was simple to do, it
> > only took a day or so.
> 
> As I see it, mode-setting is a job for fbdev and it's current API,
> or a new one is being developed for mesa-solo?
> 
> 
> 
> -otto
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
